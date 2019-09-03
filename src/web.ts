import {WebPlugin} from '@capacitor/core';
import {IBraintreePlugin, InitializationOptions, OptionOptions, PaymentUiOptions} from './definitions';

export class BraintreeWeb extends WebPlugin implements IBraintreePlugin {
    constructor() {
        super({
            name: 'BrainTree',
            platforms: ['web']
        });
    }

    // @ts-ignore
    initialize(options: InitializationOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setUseVaultManager(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setDisablePayPal(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setDisableVenmo(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setUseThreeDSecureVerification(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setDisableAndroidPay(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    setDisableGooglePayment(options: OptionOptions): Promise<void> {
        return this.createGoAwayPromise();
    }

    // @ts-ignore
    presentModalPaymentUi(options: PaymentUiOptions): Promise<any> {
        return new Promise((_resolve, reject) => {
            const msg = "The BrainTree plugin doesn't plug in to the web. It only works on iOS/Android native.";
            console.log(msg);
            reject(msg);
        });
    }

    private createGoAwayPromise(): Promise<void> {
        return new Promise((_resolve, reject) => {
            const msg = "The BrainTree plugin doesn't plug in to the web. It only works on iOS/Android native.";
            console.log(msg);
            reject(msg);
        });
    }
}

const Braintree = new BraintreeWeb();

export {Braintree};

import {registerWebPlugin} from '@capacitor/core';

registerWebPlugin(Braintree);

