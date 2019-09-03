import { WebPlugin } from '@capacitor/core';
import { IBraintreePlugin, InitializationOptions, OptionOptions, PaymentUiOptions } from './definitions';
export declare class BraintreeWeb extends WebPlugin implements IBraintreePlugin {
    constructor();
    initialize(options: InitializationOptions): Promise<void>;
    setUseVaultManager(options: OptionOptions): Promise<void>;
    setDisablePayPal(options: OptionOptions): Promise<void>;
    setDisableVenmo(options: OptionOptions): Promise<void>;
    setUseThreeDSecureVerification(options: OptionOptions): Promise<void>;
    setDisableAndroidPay(options: OptionOptions): Promise<void>;
    setDisableGooglePayment(options: OptionOptions): Promise<void>;
    presentModalPaymentUi(options: PaymentUiOptions): Promise<any>;
    private createGoAwayPromise;
}
declare const Braintree: BraintreeWeb;
export { Braintree };
