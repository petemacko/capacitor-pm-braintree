import { IBraintreePlugin, InitializationOptions, OptionOptions, PaymentUiOptions } from "./definitions";
import { IPaymentUiResult } from "./i-payment-ui-result";
export declare class BraintreePayments implements IBraintreePlugin {
    initialize(options: InitializationOptions): Promise<void>;
    setUseVaultManager(options: OptionOptions): Promise<void>;
    setDisablePayPal(options: OptionOptions): Promise<void>;
    setDisableVenmo(options: OptionOptions): Promise<void>;
    setUseThreeDSecureVerification(options: OptionOptions): Promise<void>;
    setDisableAndroidPay(options: OptionOptions): Promise<void>;
    setDisableGooglePayment(options: OptionOptions): Promise<void>;
    presentModalPaymentUi(options: PaymentUiOptions): Promise<IPaymentUiResult>;
}
