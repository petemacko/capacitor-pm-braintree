import {Plugins} from '@capacitor/core';
import {IBraintreePlugin, InitializationOptions, OptionOptions, PaymentUiOptions} from "./definitions";
import {IPaymentUiResult} from "./i-payment-ui-result";

const {BrainTree} = Plugins;

export class BraintreePayments implements IBraintreePlugin {

    public initialize(options: InitializationOptions): Promise<void> {
        return BrainTree.initialize(options);
    }

    public setUseVaultManager(options: OptionOptions): Promise<void> {
        return BrainTree.setUseVaultManager(options);
    }

    public setDisablePayPal(options: OptionOptions): Promise<void> {
        return BrainTree.setDisablePayPal(options);
    }

    public setDisableVenmo(options: OptionOptions): Promise<void> {
        return BrainTree.setDisableVenmo(options);
    }

    public setUseThreeDSecureVerification(options: OptionOptions): Promise<void> {
        return BrainTree.setUseThreeDSecureVerification(options);
    }

    public setDisableAndroidPay(options: OptionOptions): Promise<void> {
        return BrainTree.setDisableAndroidPay(options);
    }

    public setDisableGooglePayment(options: OptionOptions): Promise<void> {
        return BrainTree.setDisableGooglePayment(options);
    }

    public presentModalPaymentUi(options: PaymentUiOptions): Promise<IPaymentUiResult> {
        return BrainTree.presentModalPaymentUi(options);
    }
}

