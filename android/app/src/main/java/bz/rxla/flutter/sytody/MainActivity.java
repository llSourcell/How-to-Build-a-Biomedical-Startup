package bz.rxla.flutter.sytody;

import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.util.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.util.ArrayList;
import java.util.Locale;


public class MainActivity extends FlutterActivity implements RecognitionListener {

    private static final String SPEECH_CHANNEL = "bz.rxla.flutter/recognizer";
    private static final String LOG_TAG = "SYTODY";
    private SpeechRecognizer speech;
    private MethodChannel speechChannel;
    String transcription = "";
    private boolean cancelled = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        speech = SpeechRecognizer.createSpeechRecognizer(getApplicationContext());
        speech.setRecognitionListener(this);

        final Intent recognizerIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        recognizerIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        recognizerIntent.putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true);
        recognizerIntent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 3);

        speechChannel = new MethodChannel(getFlutterView(), SPEECH_CHANNEL);
        speechChannel.setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        switch(call.method){
                            case "activate":
                                result.success(true); // on Android 6- permissions were given during installation
                                break;
                            case "start":
                                recognizerIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, getLocale(call.arguments.toString()));
                                cancelled = false;
                                speech.startListening(recognizerIntent);
                                result.success(true);
                                break;
                            case "cancel":
                                speech.stopListening();
                                cancelled = true;
                                result.success(true);
                                break;
                            case "stop":
                                speech.stopListening();
                                cancelled = false;
                                result.success(true);
                                break;
                            default:
                                result.notImplemented();
                        }
                    }
                }
        );
    }

    private Locale getLocale(String code) {
        String[] localeParts = code.split("_");
        return new Locale(localeParts[0], localeParts[1]);
    }

    @Override
    public void onReadyForSpeech(Bundle params) {
        Log.d("SYDOTY", "onReadyForSpeech");
        speechChannel.invokeMethod("onSpeechAvailability", true);
    }

    @Override
    public void onBeginningOfSpeech() {
        Log.d("SYDOTY", "onRecognitionStarted");
        transcription = "";

        speechChannel.invokeMethod("onRecognitionStarted", null);
    }

    @Override
    public void onRmsChanged(float rmsdB) {
        Log.d("SYDOTY", "onRmsChanged : " + rmsdB);
    }

    @Override
    public void onBufferReceived(byte[] buffer) {
        Log.d("SYDOTY", "onBufferReceived");
    }

    @Override
    public void onEndOfSpeech() {
        Log.d("SYDOTY", "onEndOfSpeech");
        speechChannel.invokeMethod("onRecognitionComplete", transcription);
    }

    @Override
    public void onError(int error) {
        Log.d("SYDOTY", "onError : " + error);
        speechChannel.invokeMethod("onSpeechAvailability", false);
        speechChannel.invokeMethod("onError", error);
    }

    @Override
    public void onPartialResults(Bundle partialResults) {
        Log.d("SYDOTY", "onPartialResults...");
        Log.i(LOG_TAG, "onResults");
        ArrayList<String> matches = partialResults
                .getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
        transcription = matches.get(0);
        sendTranscription(false);

    }

    @Override
    public void onResults(Bundle results) {
        Log.d(LOG_TAG, "onResults...");
        ArrayList<String> matches = results
                .getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
        String text = "";
        transcription = matches.get(0);
        Log.d(LOG_TAG, "onResults -> " + transcription);
        sendTranscription(true);
    }

    private void sendTranscription(boolean isFinal) {
        speechChannel.invokeMethod(isFinal ? "onRecognitionComplete" : "onSpeech", /*cancelled ? "" :*/ transcription);
    }

    @Override
    public void onEvent(int eventType, Bundle params) {
        Log.d("SYDOTY", "onEvent : " + eventType);
    }

}


