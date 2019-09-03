export interface ICardAccount {
    lastTwo: string;
    network: string;
    networkName: string;
}
export interface IPayPalAccount {
    email: string;
    firstName: string;
    lastName: string;
    phone: string;
    clientMetadataId: string;
    payerId: string;
}
export interface IThreeDSecureCard {
    liabilityShifted: boolean;
    liabilityShiftPossible: boolean;
}
export interface IVenmoAccount {
    username: string;
}
export interface IPaymentUiResult {
    userCancelled: boolean;
    nonce: string;
    type: string;
    localizedDescription: string;
    card: ICardAccount;
    payPalAccount: IPayPalAccount;
    threeDSecureCard: IThreeDSecureCard;
    venmoAccount: IVenmoAccount;
}
