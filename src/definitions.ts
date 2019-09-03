import {IPaymentUiResult} from './i-payment-ui-result';

declare module "@capacitor/core" {
    interface PluginRegistry {
        Braintree: IBraintreePlugin;
    }
}

export interface InitializationOptions {
    token: string;
}

export interface OptionOptions {
    value: boolean;
}

export interface PaymentUiOptions {
    amount: string;
    applePayEnabled?: boolean;
    paypalEnabled?: boolean;
    venmoEnabled?: boolean;
    threeDSecureVerificationEnabled?: boolean;
}

export interface IBraintreePlugin {
    initialize(options: InitializationOptions): Promise<void>;
    setUseVaultManager(options: OptionOptions): Promise<void>;
    setDisablePayPal(options: OptionOptions): Promise<void>;
    setDisableVenmo(options: OptionOptions): Promise<void>;
    setUseThreeDSecureVerification(options: OptionOptions): Promise<void>;
    setDisableAndroidPay(options: OptionOptions): Promise<void>;
    setDisableGooglePayment(options: OptionOptions): Promise<void>;
    presentModalPaymentUi(options: PaymentUiOptions): Promise<IPaymentUiResult>;
}




