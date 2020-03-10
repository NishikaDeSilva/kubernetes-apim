#!/bin/bash

#-------------------------------------------------------------------------------
# Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------------

set -e

# bash variables
k8s_obj_file="deployment.yaml"; str_sec=""
license_text="LICENSE.txt"

# wso2 subscription variables
WUMUsername=''; WUMPassword=''
IMG_DEST="docker.wso2.com"

: ${namespace:="wso2"}

function createLicenseText(){
cat > ${license_text} << "EOF"
WSO2 SOFTWARE LICENSE AGREEMENT

This WSO2 Software License Agreement (the “Agreement”) is entered into by you and the applicable WSO2 entity, as described below. If you are an
individual accepting this Agreement on behalf of a company or other legal entity, you represent that you are authorized to bind the entity to
the terms of this Agreement and “You” or “Your” will refer to the entity bound to this Agreement, not to you as an individual.

By using or accessing the Software, signing this Agreement or any document that references this Agreement (such as an Order), or by clicking
“I agree to the Terms” (or similar button or checkbox) upon downloading or installing the Software, You indicate Your assent to be bound by
this Agreement. If You do not agree to this Agreement, do not use or access the Software.

1. Definitions

a) “Order” is a document submitted by You authorizing the purchase of the Products requested by You, the Support Plan, associated fees, and
any additional terms.
b) “Products” means collectively Software, Support and/or other Services obtained by You from WSO2 subject to the terms of this Agreement.
c) “Software” means the computer programs developed and owned by WSO2 to which this License Agreement is attached, however you obtain or access them.
Software includes security patches, updates, or other modifications to the Software supplied by WSO2.
d) “Services” means training, consulting and other services, other than Support, specified in an Order.
e) “Support” means support provided by WSO2 to a Subscriber for the Software according to the terms of the WSO2 Support Services described in
Section 4.1.
f) “Support Plan” means the service level specified in an Order, from among the levels defined in the Support Services Policy.
g) “Subscription” is a commercial offering from WSO2 consisting of a license to use, and access to Support for, the Software, for a specific period
of time.
h) “Subscription Period” is the commencement date and duration of a Subscription, as specified in an Order.

2. License Grant

2.1 Free License for Non-commercial, Educational, or Trial use. WSO2 hereby grants You a worldwide, non-exclusive, royalty-free, non-transferable,
non-sublicensable, terminable license to use the Software for Non-commercial, Educational, or Trial purposes. Non-commercial, as used in this
Agreement, means personal use whereby no commercial advantage or monetary compensation is sought or received for use of the Software or for works,
data or services that use the Software. Educational or Trial Use, as used in this Agreement, means use for the purpose of learning to use the
Software, teaching others to use the Software, evaluating the Software capabilities, or for scholarly or artistic purposes.

2.2 License for commercial use. If You purchase a Subscription from WSO2 or one of its authorized Resellers, WSO2 hereby grants to You,
as “Subscriber”, a worldwide, non-exclusive, non-transferable, non-sublicensable, terminable license to use the Software for the duration of the
Subscription Period. This license is limited to the specific Software configuration or limit defined in the Order. The Order will specify the
scope of the Subscription purchased by Subscriber, including:
(1) product versions; (2) production or non-production use; (3) usage limits (e.g. cores or transaction limits); and
(4) any other license parameters.

3. Conditions of Use. A license granted to You by this Agreement is valid only if You adhere to the following conditions

3.1 Maintenance of Copyright Notices.  You shall not remove or alter any copyright or license notices that appear in or on the Product.
3.2 Modification.  You shall not modify, alter, decompile, decrypt, disassemble, translate, or reverse engineer the Product.
3.3 Distribution.  You shall not sublicense, transfer, lease, rent, or otherwise distribute or make available the Software to any third party.
3.4 SaaS.  Unless authorized by WSO2, You shall not make the Software available as commercial Software-as-a-Service.
3.5 Compliance with Applicable Laws.  You shall comply with all applicable laws regarding use of the Software.

4. Subscription Terms and Conditions. If You purchase a Subscription, the following terms and conditions apply.

4.1 Support. WSO2 will provide Subscriber with Support for the Software during the Subscription Period according to the Support Plan
indicated in the applicable Order, and subject to the WSO2 Support Policy set forth at https://wso2.com/licenses/support-policy. Each
Subscription includes Query Support subject to a maximum hours limit as indicated in the Order.  Limits can be increased subject to
additional fees. The maximum hours limit is reset upon renewal for a subsequent annual period; unused hours cannot be rolled over into
the next annual period.

4.2 Technical Currency.  WSO2 will provide Subscriber with all new versions of the Software that it generally releases, including all updates,
security updates, improvements, enhancements and bug fixes. All new versions of the Software are provided subject to the terms of the Agreement.

4.3 Online Services.  A Subscription may include online services.  Use of these online services is governed by the WSO2.com Terms of
Use at https://wso2.com/terms-of-use, the WSO2 Privacy Policy at https://wso2.com/privacy-policy, and the WSO2 Cloud Terms of Use at
https://wso2.com/cloud/terms-of-use.

4.4 Increases in Software Use. Subscriber may increase its use of the Software during the Subscription Period beyond the scope specified in the
applicable Orders, provided that Subscriber promptly notifies WSO2 of the additional use and pays the applicable Fees.

4.5 Bursting Use. Subscriber may temporarily exceed the Subscription limits, at no extra Fee, within the bursting limits for the Product
(“Authorized Bursting Use”). If Subscriber increases its use beyond Authorized Bursting Use, it must notify WSO2, increase the allowed usage
limits retroactively to the period where limits were exceeded, and pay the applicable Fees.  For products limited to a maximum number of cores,
Authorized Bursting Use allows up to 3 days (discrete 24-hour periods) within an annual Subscription period during which the core count may
exceed the Subscription limit by no more than 25%.  For products limited to a maximum number of monthly transactions, Authorized Bursting Use
allows transactions up to 25% over the monthly cap, within a single calendar month per annual Subscription period.

4.6 Subscription Renewal. Subscriptions automatically renew for additional periods equal to the or one year unless Subscriber notifies WSO2 in
writing that it wishes to renew for a longer period, or to end the Subscription at least 90 days prior to the end of the Subscription Period.
Upon renewal, unit fees increase by 5%, unless provided otherwise in an Order. Renewal of promotional or one-time priced Subscriptions will be at
WSO2’s applicable price list in effect at the time of the discount was granted. Fees for renewal are due according to the Fees and Payment terms
of this Agreement.

4.7 Termination for Change in Services.  WSO2 may change the terms of Support or Services from time to time without affecting the validity of this
Agreement.  In the event of any material changes, WSO2 will attempt to provide Subscriber notice by sending an email to the point of contact address
provided by Subscriber. In the event of a material and adverse change to the terms of Support or Services, Subscriber has the right to terminate
this Agreement upon 30 day notice to WSO2 at the following email address: support@wso2.com. In the event of such termination, WSO2 shall reimburse
Subscriber a pro rata amount of any fees actually prepaid by Subscriber.

4.8 Remedies. WSO2’S SOLE OBLIGATION AND SUBSCRIBER’S SOLE REMEDY FOR WSO2’S BREACH OF ANY REPRESENTATIONS, WARRANTIES OR OBLIGATIONS OF THIS
AGREEMENT IS TO (I) IN THE CASE OF A DEFECTIVE OR FAULTY BUG FIX, PATCH OR THE LIKE, DELIVER TO SUBSCRIBER A CORRECTED VERSION WHICH ALLOWS FOR
PROPER INSTALLATION; OR (II) IF OPTION (I) IS NOT RELEVANT OR IS DEEMED NOT TO BE COMMERCIALLY FEASIBLE BY WSO2, TERMINATE THIS AGREEMENT AND
REFUND A PRO RATA PORTION OF THE FEES PAID BY SUBSCRIBER.

4.9 Audit. Upon WSO2’s request with reasonable notice, Subscriber will permit technical and operational audits of Subscriber related to the subject
matter of this Agreement. Audits may include verifying Subscriber’s user of the Software conforms to the usage limits purchased by Subscriber.
Audits shall be carried out within Subscriber’s regular business hours and WSO2 will honor confidentiality and data protection requirements. If
non-compliance is discovered in an audit, Subscriber will be responsible for all costs associated with carrying out such audit. In addition, where
such audit reveals Subscriber has exceeded the usage subscribed-for, Subscriber shall pay WSO2 prorated fees for the excess usage at the same rate(s)
designated in the most proximate Order. If the date excess usage began cannot be determined to WSO2’s satisfaction, excess usage shall be deemed to
have commenced on the start date of the Subscription.

5. WSO2 Consulting Services. QuickStarts, Training, Technical Account Management, Managed Services, and other services WSO2 may offer to Subscriber
are subject to the following terms.

5.1 Consulting Services Terms. WSO2 provides on-site and remote consulting services according to the Consulting Service Terms at
https://wso2.com/licenses/consulting-terms, as updated or amended from time to time.
5.2 Managed Services Terms. WSO2 provides Managed Services according to the WSO2 Managed Services Terms and Service Level Agreement at
https://wso2.com/licenses/managed-services-terms.
5.3 Cloud Services Terms.  WSO2 provides Cloud Services according to the WSO2 Cloud Services Terms and Service Level Agreement at
https://wso2.com/licenses/cloud-services-terms.
5.4 Independent Contractor. The relationship of the parties is that of independent contractors. Neither party, nor any partner, agent or employee of
either party, has authority to enter into contracts that bind the other or create obligations on the part of the other without the prior written
authorization of such party.
5.5 Non-solicitation. During the term of this Agreement and for a period of one (1) year after its termination, neither party will directly or
indirectly (a) solicit for hire or engagement any of the other party’s personnel who were involved in the provision or receipt of Services under
this Agreement or (b) hire or engage any person or entity who is or was employed or engaged by the other party and who was involved in the provision
or receipt of Services under this Agreement until one hundred eighty (180) calendar days following the termination of the person’s or entity’s
employment or engagement with the other party. For purposes herein, “solicit” does not include broad-based recruiting efforts, including without
limitation help wanted advertising and posting of open positions on a party’s internet site. If You hire or engage directly or indirectly any
personnel of WSO2 in violation of this section, You will pay WSO2 a contractual penalty equal to three times the monthly billing rate
(assuming 168 hours per month) for such personnel.

6. Reseller Orders. This Section applies if You purchase Products through an authorized reseller of WSO2 (“Reseller”).

6.1 Instead of paying WSO2, You will pay the applicable amounts to the Reseller, as agreed between You and the Reseller. WSO2 may suspend or
terminate Your Subscription if WSO2 does not receive the corresponding payment from the Reseller.
6.2 Instead of an Order submitted to WSO2, Your order details will be as stated in the order placed with WSO2 by the Reseller on Your behalf,
and the Reseller is responsible for the accuracy of any such order as communicated to WSO2.
6.3 If You are entitled to a refund under this Agreement, then unless otherwise specified by WSO2, WSO2 will refund any applicable fees to the
Reseller and the Reseller will be solely responsible for refunding the appropriate amounts to You.
6.4 Resellers are not authorized to modify this Agreement or make any promises or commitments on WSO2’s behalf, and WSO2 is not bound by any
obligations to You other than as set forth in this Agreement.
6.5 The amount paid or payable by the Reseller to WSO2 for Your use of the applicable Software under this Agreement will be deemed the amount
actually paid or payable by You to WSO2 under this Agreement for purposes of calculating the liability cap in Section 12.

7. Publicity and Feedback

7.1 WSO2 Logos. WSO2 products may include features for theming the product user interfaces.  You will retain the “WSO2” or “powered by WSO2”
logos in conformance with WSO2 Logo Usage Guidelines at https://wso2.com/brand.
7.2 Publicity. You may state publicly that You are a user of the Products. Any identification or use of a party’s brand, logo, or
trademark shall conform with the trademark use guidelines provided by one party to the other. WSO2 may reference you as a Customer, use Your logo
on the WSO2 website. You will participate in a success story/case study related to WSO2.
7.3 Feedback. If You provide any suggestions, corrections, or feedback regarding the Products, WSO2 may use that information without obligation to You,
and You hereby irrevocably assign to WSO2 all right, title, and interest in the suggestions, corrections, or feedback.

8. Fees and Payment

8.1 Fees. After You authorize an Order, upon renewal of a Subscription, or for other fees due to WSO2, WSO2 will send you an invoice. You will pay
all fees specified in invoices. All payments are due within thirty (30) calendar days of receipt of an invoice from WSO2 and are non-refundable.
WSO2 may suspend or cancel performance of all or part of the Subscription or Services and may change its credit terms (after notifying You) if actual
payment is not received within sixty (60) calendar days of Your receipt of WSO2’s invoice. Payments past due sixty (60) calendar days will incur
interest at the rate of one and one-half percent (1.5%) per month or the highest rate permitted by law, whichever is less. In any proceeding brought
by WSO2 to collect amounts due, WSO2 will also receive its actual costs of collection, including reasonable attorneys’ fees.

8.2 Taxes.  All fees are exclusive of any applicable Taxes. You will pay to WSO2 an amount equal to any taxes arising from or relating to this
Agreement, including without limitation, sales, service, use or value added taxes, which are paid by or are payable by WSO2. "Taxes" means any
form of taxation, levy, duty, customs fee, charge, contribution or impost of whatever nature and by whatever authority imposed (including without
limitation any fine, penalty, surcharge or interest), excluding, however, any taxes based solely on the net income of WSO2. If You are required
under any applicable law or regulation, domestic or foreign, to withhold or deduct any portion of the payments due to WSO2, then the sum payable
to WSO2 will be increased by the amount necessary so that WSO2 receives an amount equal to the sum it would have received had Subscriber made no
withholdings or deductions.

8.3 Purchase Orders. Any pre-printed terms on any purchase order that is issued by You that are in addition to or in conflict with the terms of this
Agreement are null and void.

9. Term & Termination

9.1 Termination.  This Agreement terminates when:
a. Your Subscription terminates,
b. when You cease using the Software, or
c. if You do not have an active Subscription, 90 days after WSO2 notifies You that it wishes to terminate the Agreement.
9.2 Termination for Cause.  Either party may terminate this Agreement on written notice to the other if the other party fails to comply with this
Agreement after it has been notified in writing of the nature of the failure and been provided with 30 days after receiving the written notice to cure the
failure.
9.3 Effect of Termination. Upon termination of this Agreement:
a. the rights granted by one party to the other immediately cease;
b. all fees owed by Subscriber are immediately due upon receipt of the final invoice; and
c. You will delete the Software immediately.
9.4 Survival.  Sections 5.5, 8.1, 10.2, 12, and 14.9, and those provisions intended by their nature to survive termination of this Agreement survive
termination. Section 13 will survive termination of this Agreement for 3 years.

10. Limited Warranties

10.1 Warranties for Subscriber. If You are a Subscriber, WSO2 warrants that:
a. the Software will perform substantially in accordance with its documentation (located at https://docs.wso2.com);
b. it will perform Support and Consulting Services in a diligent and workmanlike manner consistent with industry standards; and
c. to its knowledge, the Software does not, at the time of delivery to you, include malicious mechanisms or code for the purpose of
damaging or corrupting the Software.

Subscriber’s exclusive remedy for WSO2’s material breach of warranty is to have WSO2 resolve such breach as provided in the
WSO2 Support Services Policy, or at WSO2’s option and upon Subscriber’s deletion of the Software, refund the unused portion of any fees
paid for the Subscription.

10.2 EXCEPT AS EXPRESSLY PROVIDED IN THE AGREEMENT, AND TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, ALL SERVICES, SOFTWARE, AND SUPPORT
PROVIDED BY WSO2 ARE PROVIDED “AS IS” WITHOUT ANY WARRANTIES OR CONDITIONS OF ANY KIND, INCLUDING IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND NON-INFRINGEMENT. NO WARRANTY, WRITTEN OR ORAL, IS EXPRESSED OR IMPLIED BY WSO2 OR MAY BE INFERRED FROM
A COURSE OF DEALING OR USAGE OF TRADE. NOTHING STATED IN THIS AGREEMENT IMPLIES THAT THE OPERATION OF ANY SOFTWARE WILL BE UNINTERRUPTED OR ERROR
FREE, OR THAT ERRORS WILL BE CORRECTED.

11. Indemnification. If You are a Subscriber, the provisions of this section apply to You.

11.1 Subject to the provisions of this Section 11, and commencing from the start of the Subscription Period, WSO2 will defend at its expense any
suit brought against Subscriber, and will pay any settlement WSO2 makes or approves, or any direct damages (excluding amounts awarded for reputation
harm or business impact) finally awarded in such suit, insofar as such suit is based on a claim by any third party alleging that the Products
misappropriate any trade secret recognized under the Uniform Trade Secrets Act or infringe any copyright or United States patent valid within the
Subscription Period (an “IP Claim”). WSO2’s indemnification obligations are limited to US $7,000,000.

11.2 If any portion of the Software or the Services becomes, or in WSO2’s opinion is likely to become, the subject of an IP Claim, WSO2 may, at
WSO2’s option: (i) procure for Subscriber the right to continue using the Products; (ii) replace the Products with non-infringing software or
services which do not materially impair the functionality of the Products; (iii) modify the Products so that it becomes non-infringing; or
(iv) terminate this Agreement and refund any fees actually paid by Subscriber to WSO2 for the remainder of the Term then in effect, and upon such
termination, Subscriber will immediately cease all use of the Software, documentation, and Services.

11.3 Notwithstanding anything to the contrary herein, WSO2 has no obligation with respect to any IP Claim based upon (i) any open source software
components included in the Software; (ii) any use of the Software or the Services not in accordance with this Agreement or as specified in the
documentation; (iii) any use of the Software in combination with other products, equipment, software or data not supplied by WSO2; or (iv) any
modification of the Software by any person other than WSO2 or its authorized agents. This Section states the sole and exclusive remedy of Subscriber
and the entire liability of WSO2, or any of the officers, directors, employees, shareholders, contractors or representatives of either party,
for IP Claims.

11.4 The indemnifying party’s obligations as set forth above are expressly conditioned upon complying with each of the following:
(i) the indemnified party must promptly notify the indemnifying party in writing of any threatened or actual claim or suit; (ii) the indemnifying
party will have sole control of the defense or settlement of any claim or suit; and (iii) the indemnified party must cooperate with the
indemnifying party to facilitate the settlement or defense of any claim or suit.

12. Limitation of Liability. EXCEPT FOR DAMAGES FOR BODILY INJURY (INCLUDING DEATH), WSO2’S TOTAL AGGREGATE LIABILITY UNDER THIS AGREEMENT IS
LIMITED TO THE AMOUNT OF FEES PAID BY YOU DURING THE PERIOD OF A MATERIAL BREACH UP TO A MAXIMUM OF ONE YEAR. IF YOU HAVE PAID NO FEES, OR ARE A
NON-COMMERCIAL, EDUCATIONAL, OR TRIAL LICENSEE, WSO2’S MAXIMUM AGGREGATE LIABILITY TO YOU IS $100.

IN NO EVENT WILL WSO2 OR ITS AFFILIATES BE LIABLE FOR ANY INCIDENTAL INDIRECT, SPECIAL, OR CONSEQUENTIAL COSTS OR DAMAGES INCLUDING, WITHOUT
LIMITATION, DOWNTIME COSTS; LOST BUSINESS, REVENUES, GOODWILL, OR PROFITS; FAILURE TO REALIZE EXPECTED SAVINGS; LOSS OF OR DAMAGE TO DATA; OR
SOFTWARE RESTORATION, REGARDLESS OF WHETHER ANY OF THE FOREGOING ARE FORESEEABLE, AND REGARDLESS OF WHETHER WSO2 HAS BEEN NOTIFIED OF THE
POSSIBILITY OF ANY OF THE FOREGOING. THESE LIMITATIONS APPLY REGARDLESS OF THE BASIS OF LIABILITY; INCLUDING NEGLIGENCE; MISREPRESENTATION; BREACH;
LIBEL; INFRINGEMENT OF PUBLICITY, PRIVACY, OR INTELLECTUAL PROPERTY RIGHTS; OR ANY OTHER CONTRACT OR TORT CLAIM.

13. Confidentiality

13.1 Definition. “Confidential Information” means any information, documentation, system, or process disclosed by a party or a party’s Affiliate
that is:
a. designated as confidential (or a similar designation) at the time of disclosure;
b. disclosed in circumstances of confidence; or
c. understood by the parties, exercising reasonable business judgment, to be confidential.

Confidential Information expressly includes proposals or price quotes created by WSO2 for You, Orders, and any changes or amendments to this
Agreement.

“Affiliate” means any entity that directly or indirectly controls, is controlled by, or is under common control with a party to this Agreement.

13.2 Exclusions. Confidential Information does not include information that:
a. was lawfully known or received by the receiving party prior to disclosure;
b. is or becomes part of the public domain other than as a result of a breach of this Agreement;
c. was disclosed to the receiving party by a third party, provided such third party, or any other party from whom such third party receives
such information, is not in breach of any confidentiality obligation in respect to such information; or
d. is independently developed by the receiving party as evidenced by independent written materials.

13.3 Nondisclosure. Each party shall treat as confidential all Confidential Information of the other party, shall not use Confidential Information
except as set forth in this Agreement, and shall use best efforts not to disclose Confidential Information to any third party. Without limiting the
foregoing, each of the parties shall use at least the same degree of care that it uses to prevent the disclosure of its own Confidential Information
of like importance to prevent the disclosure of Confidential Information disclosed to it by the other party under this Agreement. Each party shall
promptly notify the other party of any actual or suspected misuse or unauthorized disclosure of the other party’s Confidential Information.

13.4 Return of Confidential Information. Upon expiration or termination of this Agreement, each party shall return or destroy all Confidential
Information received from the other party.

13.5 Remedies. Any breach of the restrictions contained in this section is a breach of this Agreement that may cause irreparable harm to the
non-breaching party. Any such breach shall entitle the non-breaching party to injunctive relief in addition to all other legal remedies.

14. General

14.1 Severability.  If any provision of this Agreement is held by a court of competent jurisdiction to be contrary to law, such provision shall be
changed and interpreted so as to best accomplish the objectives of the original provision to the fullest extent allowed by law and the remaining
provisions of this Agreement shall remain in full force and effect.

14.2 Force Majeure.  Neither party will be liable for performance delays or for non-performance due to causes beyond its reasonable control; however,
this provision will not apply to Subscriber's payment obligations.

14.3 Headings.  The headings in this Agreement are inserted for convenience only and do not affect its interpretation.

14.4 Assignment.  You may not assign this Agreement, whether by operation of law, merger or reorganization or otherwise, without the prior written
consent of WSO2; any attempted assignment in violation of the foregoing will be void. WSO2 may assign its rights and delegate its duties under this
Agreement without Your written consent in connection with a reorganization, reincorporation, merger, or sale of all, or substantially all of the
shares or assets of WSO2 or the business of WSO2 to which this Agreement relates.

14.5 Export Compliance / Sanctions. The Software may be subject to export laws and regulations of the United States and other jurisdictions.
The parties represent that each of them is not named on any U.S. Government denied-party list. You will not use the Software in violation of any
U.S. export law or regulation.

14.6 Complete Agreement. This Agreement, and any terms, policies, or writings referenced within it, constitutes the final and complete agreement
between the parties with respect to the Products, and supersedes any prior or contemporaneous representations or agreements, whether written or oral.

14.7 Notices. Notice may be directed to WSO2 at legal@wso2.com.

14.8 WSO2 Contracting Entity, Governing Law, and Venue. The WSO2 entity entering into this Agreement, the law that will apply in any dispute
arising out of this Agreement, and the venue for any dispute depend on where You are domiciled.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
|If You are domiciled in: | The WSO2 entity entering into  | Governing law is:               | Method of dispute resolution is:                                       |
|                         | this Agreement is:             |                                 |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| USA, Canada, any country| WSO2, Inc., a Delaware         | California without giving       | Arbitration in Santa Clara, California in accordance with the rules    |
| not listed below        | corporation                    | effect to the principles of     | of the American Arbitration Association (“AAA”)                        |
|                         |                                | conflict of laws                |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| United Kingdom, Europe  | WSO2 UK Limited, a company     | English                         | Arbitration in London, United Kingdom, in accordance with the rules    |
| (except for Germany)    | incorporated under the laws    |                                 | of the International Chamber of Commerce (“ICC”)                       |
|                         | of England                     |                                 |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Sri Lanka, India,       | WSO2 LANKA (PRIVATE) LIMITED,  | Sri Lanka                       | Arbitration in Colombo, Sri Lanka in accordance with the rules of      |
| Malaysia, Mauritius,    | a company incorporated under   |                                 | the Arbitration Act No 11 of 1995                                      |
| Macau                   | the laws of Sri Lanka          |                                 |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| South America, Belize,  | WSO2 Brasil Technologia E      | Brazil                          | Arbitration in Sao Paulo, Brazil in accordance with the rules of       |
| Costa Rica, El Salvador,| Software LTDA, a company       |                                 | the International Chamber of Commerce (“ICC”)                          |
| Guatemala, Honduras,    | incorporated in Brazil         |                                 |                                                                        |
| Nicaragua, Panama.      |                                |                                 |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Australia or New        | WSO2 Australia Pty Limited,    | New South Wales, Australia      | Each party submits to the exclusive jurisdiction of the courts of      |
| Zealand                 | ABN 90 623 311 348             | without giving effect to        | New South Wales, Australia (and any relevant appellate courts).        |
|                         |                                | the principles of conflict      | Each party’s designated representatives will meet within ten (10) days |
|                         |                                | of laws.                        | following receipt of notice of the dispute and will attempt to resolve |
|                         |                                |                                 | the dispute within 15 days.  If the parties agree in writing, a        |
|                         |                                |                                 | dispute may be mediated or arbitrated. If any dispute is not resolved  |
|                         |                                |                                 | informally or referred to mediation or arbitration, either party may   |
|                         |                                |                                 | commence legal proceedings in respect of the dispute in a court of     |
|                         |                                |                                 | competent jurisdiction. If the parties agree in writing to arbitrate a |
|                         |                                |                                 | dispute, such dispute shall be referred to the Australian Disputes     |
|                         |                                |                                 | Centre (“ADC”) for resolution by binding arbitration in Sydney New     |
|                         |                                |                                 | South Wales in accordance with the ADC’s Conciliation Rules.           |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Germany                 | WSO2 Germany GmbH              | The laws of Germany with the    | Arbitration in Germany in accordance with the rules of the             |
|                         |                                | exception of United Nations     | International Chamber of Commerce (“ICC”)                              |
|                         |                                | Convention on the International |                                                                        |
|                         |                                | Sale of Goods (CISG)            |                                                                        |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

14.9 Agreement to Governing Law and Dispute Resolution.  Each party agrees to the applicable governing law above, and to the exclusive method
of dispute resolution. Where the applicable dispute resolution procedure is arbitration, the award rendered by the arbitrator shall be final and
binding on the parties, and judgment may be entered in any court of competent jurisdiction. Nothing in the above provision prevents either party
from applying to a court of competent jurisdiction for equitable or injunctive relief. Any dispute or other action arising out of this Agreement
must be brought within one year of the date the cause of action accrued. An action for nonpayment may be brought within two years of the date of
last payment.

14.10 Regional Agreement Variations: WSO2 Australia Pty Limited. Based upon the above, If You enter into this Agreement with WSO2 Australia Pty Limited,
Sections 4.8, 8.2, and 12 are replaced with the following:

4.8 Remedies. IF ANY WARRANTY OR GUARANTEE CANNOT BE EXCLUDED AT LAW, THEN TO THE EXTENT PERMITTED BY LAW, WSO2’S SOLE LIABILITY AND SUBSCRIBER’S
SOLE REMEDY FOR BREACH OF A WARRANTY, GUARANTEE, OR OBLIGATION OF THIS AGREEMENT IS LIMITED (AT WSO2’S OPTION) IN THE CASE OF: (A) SERVICES, TO
THE RESUPPLY OF THE SERVICES OR PAYMENT OF THE COST OF THE SAME; AND (B) GOODS (INCLUDING SOFTWARE), TO THE REPAIR OR REPLACEMENT OF THE GOODS,
SUPPLY OF EQUIVALENT GOODS OR PAYMENT OF THE COST OF THE SAME.

8.2 Taxes. All fees are exclusive of any applicable Taxes. You will pay to WSO2 an amount equal to any taxes arising from or relating to this
Agreement, including without limitation, GST, use or value added taxes, which are paid by or are payable by WSO2. "Taxes" means any form of
taxation, levy, duty, customs fee, charge, contribution or impost of whatever nature and by whatever authority imposed (including without
limitation any fine, penalty, surcharge or interest), excluding, however, any taxes based solely on the net income of WSO2. If You are required
under any applicable law or regulation, domestic or foreign, to withhold or deduct any portion of the payments due to WSO2, then the sum payable
to WSO2 will be increased by the amount necessary so that WSO2 receives an amount equal to the sum it would have received had Subscriber made no
withholdings or deductions.

Where a supply under this Agreement is a taxable supply, all amounts payable or other consideration provided must be increased by the amount of
GST payable in relation to the supply.  All GST must be paid at the time any payment for any supply to which it relates is payable (provided a
valid tax invoice has been issued for the supply).  In this Section, “GST”, “tax invoice” and “taxable supply” have the meanings given to them
in the A New Tax Systems (Goods and Services Tax) Act 1999 (Cth).

12. Limitation of Liability. EXCEPT FOR LIABILITY DAMAGES FOR BODILY INJURY (INCLUDING DEATH) WHICH SHALL BE UNLIMITED, WSO2’S TOTAL AGGREGATE
LIABILITY FOR ALL CLAIMS ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, REGARDLESS OF THE FORM OF ACTION (INCLUDING NEGLIGENCE), IS
LIMITED IN ANY CALENDAR YEAR TO THE AMOUNT PAID BY SUBSCRIBER FOR SERVICES DURING  THAT CALENDAR YEAR. IF YOU HAVE PAID NO FEES, OR ARE A
NON-COMMERCIAL, EDUCATIONAL, OR TRIAL LICENSEE, WSO2’S MAXIMUM AGGREGATE LIABILITY TO YOU IS $100.
.
IN NO EVENT WILL WSO2 BE LIABLE FOR ANY “INDIRECT LOSSES” BEING: (A) DOWNTIME COSTS, LOST BUSINESS, REVENUES, OR PROFITS, FAILURE TO REALIZE
EXPECTED SAVINGS OR OPPORTUNITY, LOSS OF OR DAMAGE TO DATA, LOSS OF GOODWILL OR REPUTATION, COSTS OF SOFTWARE RESTORATION; AND (B) ANY LOSS
THAT DOES NOT ARISE NATURALLY OR ACCORDING TO THE USUAL COURSE OF THINGS FROM A BREACH, ACT OR OMISSION RELATING TO THIS AGREEMENT REGARDLESS
OF WHETHER ANY OF THE FOREGOING ARE FORESEEABLE, AND REGARDLESS OF WHETHER WSO2 HAS BEEN NOTIFIED OF THE POSSIBILITY OF ANY OF THE FOREGOING.
THESE LIMITATIONS WILL APPLY REGARDLESS OF THE BASIS OF LIABILITY, INCLUDING NEGLIGENCE, MISREPRESENTATION, BREACH, DEFAMATION, INFRINGEMENT OF
PUBLICITY, PRIVACY, OR INTELLECTUAL PROPERTY RIGHTS, OR ANY OTHER CONTRACT OR TORT CLAIM.

14.11 Regional Agreement Variations: WSO2 Germany GmbH. Based upon the above, If You enter into this Agreement with WSO2 Germany GmbH,
Sections 5.5, 8.1, and 8.2 are replaced with the following:

5.5 Non-solicitation. During the term of this Agreement and for a period of one (1) year after its termination, neither party will directly
(a) solicit for hire or engagement any of the other party’s personnel who were involved in the provision or receipt of Services under this
Agreement or (b) hire or engage any person or entity who is or was employed or engaged by the other party and who was involved in the provision
or receipt of Services under this Agreement until one hundred eighty (180) calendar days following the termination of the person’s or entity’s
employment or engagement with the other party.

For purposes herein, “solicit” does not include broad-based recruiting efforts, including without limitation help wanted advertising and posting
of open positions on a party’s internet site. If You hire or engage directly or indirectly any personnel of WSO2 in violation of this section,
You will pay WSO2 a contractual penalty equal to three times the monthly billing rate (assuming 168 hours per month) for such personnel.

8.1 Fees. After You sign an Order, or upon renewal of a Subscription, WSO2 will send you an invoice. You will pay all fees specified in invoices.
All payments are due within thirty (30) calendar days of receipt of an invoice from WSO2 and are non-refundable. WSO2 may suspend or cancel
performance of all or part of the Subscription or Services and may change its credit terms (after notifying You) if actual payment is not
received within sixty (60) calendar days of Your receipt of WSO2’s invoice. Payments past due sixty (60) calendar days will incur interest at the
rate of 9 percentage points above the ECB basic interest rate per year. In addition, Subscriber has to pay 40 EUR in recovering charges. In any
proceeding brought by WSO2 to collect amounts due, WSO2 will also receive its actual costs of collection, including reasonable attorneys’ fees.

8.2 Taxes. All fees are exclusive of any applicable Taxes. You will pay to WSO2 an amount equal to any taxes arising from or relating to
this Agreement, including without limitation, VAT which is paid by or is payable by WSO2. "Taxes" means any form of taxation, levy, duty,
customs fee, charge, contribution or impost of whatever nature and by whatever authority imposed (including without limitation any fine,
penalty, surcharge or interest), excluding, however, any taxes based solely on the net income of WSO2. If You are required under any applicable
law or regulation, domestic or foreign, to withhold or deduct any portion of the payments due to WSO2, then the sum payable to WSO2 will be
increased by the amount necessary so that WSO2 receives an amount equal to the sum it would have received had Subscriber made no withholdings
or deductions.
EOF

viewLicenseText
}
function create_yaml(){
cat > $k8s_obj_file << "EOF"
EOF
if [ "$namespace" == "wso2" ]; then
cat > $k8s_obj_file << "EOF"

apiVersion: v1
kind: Namespace
metadata:
  name: wso2
---
EOF
fi
cat >> $k8s_obj_file << "EOF"

apiVersion: v1
kind: ServiceAccount
metadata:
  name: wso2am-pattern-1-svc-account
  namespace: wso2
---

apiVersion: v1
kind: Secret
metadata:
  name: wso2am-pattern-1-creds
  namespace: wso2
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: "k8s.apim.&.auth.wso2"
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wso2apim-mysql-dbscripts
  namespace: wso2
data:
  mysql_analytics.sql: |-
    DROP DATABASE IF EXISTS WSO2AM_STATS_DB;
    DROP DATABASE IF EXISTS WSO2AM_BUSINESS_RULES_DB;
    DROP DATABASE IF EXISTS WSO2AM_PERMISSIONS_DB;

    CREATE DATABASE WSO2AM_STATS_DB;
    CREATE DATABASE WSO2AM_BUSINESS_RULES_DB;
    CREATE DATABASE WSO2AM_PERMISSIONS_DB;

    GRANT ALL ON WSO2AM_STATS_DB.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';
    GRANT ALL ON WSO2AM_BUSINESS_RULES_DB.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';
    GRANT ALL ON WSO2AM_PERMISSIONS_DB.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';

    USE WSO2AM_STATS_DB;

    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
    FILE_NAME varchar(255) NOT NULL,
    FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FILE_PROCESSED tinyint(1) DEFAULT 0,
    FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
    );
  mysql_apim.sql: |-
    DROP DATABASE IF EXISTS WSO2AM_DB;
    CREATE DATABASE WSO2AM_DB;
    GRANT ALL ON WSO2AM_DB.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';

    USE WSO2AM_DB;

    -- Start of IDENTITY Tables--
    CREATE TABLE IF NOT EXISTS IDN_BASE_TABLE (
                PRODUCT_NAME VARCHAR(20),
                PRIMARY KEY (PRODUCT_NAME)
    )ENGINE INNODB;

    INSERT INTO IDN_BASE_TABLE values ('WSO2 Identity Server');

    CREATE TABLE IF NOT EXISTS IDN_OAUTH_CONSUMER_APPS (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                CONSUMER_KEY VARCHAR(255),
                CONSUMER_SECRET VARCHAR(2048),
                USERNAME VARCHAR(255),
                TENANT_ID INTEGER DEFAULT 0,
                USER_DOMAIN VARCHAR(50),
                APP_NAME VARCHAR(255),
                OAUTH_VERSION VARCHAR(128),
                CALLBACK_URL VARCHAR(2048),
                GRANT_TYPES VARCHAR (1024),
                PKCE_MANDATORY CHAR(1) DEFAULT '0',
                PKCE_SUPPORT_PLAIN CHAR(1) DEFAULT '0',
                APP_STATE VARCHAR (25) DEFAULT 'ACTIVE',
                USER_ACCESS_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
                APP_ACCESS_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
                REFRESH_TOKEN_EXPIRE_TIME BIGINT DEFAULT 84600,
                ID_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
                CONSTRAINT CONSUMER_KEY_CONSTRAINT UNIQUE (CONSUMER_KEY),
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_SCOPE_VALIDATORS (
    	APP_ID INTEGER NOT NULL,
    	SCOPE_VALIDATOR VARCHAR (128) NOT NULL,
    	PRIMARY KEY (APP_ID,SCOPE_VALIDATOR),
    	FOREIGN KEY (APP_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH1A_REQUEST_TOKEN (
                REQUEST_TOKEN VARCHAR(255),
                REQUEST_TOKEN_SECRET VARCHAR(512),
                CONSUMER_KEY_ID INTEGER,
                CALLBACK_URL VARCHAR(2048),
                SCOPE VARCHAR(2048),
                AUTHORIZED VARCHAR(128),
                OAUTH_VERIFIER VARCHAR(512),
                AUTHZ_USER VARCHAR(512),
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (REQUEST_TOKEN),
                FOREIGN KEY (CONSUMER_KEY_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH1A_ACCESS_TOKEN (
                ACCESS_TOKEN VARCHAR(255),
                ACCESS_TOKEN_SECRET VARCHAR(512),
                CONSUMER_KEY_ID INTEGER,
                SCOPE VARCHAR(2048),
                AUTHZ_USER VARCHAR(512),
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (ACCESS_TOKEN),
                FOREIGN KEY (CONSUMER_KEY_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_ACCESS_TOKEN (
                TOKEN_ID VARCHAR (255),
                ACCESS_TOKEN VARCHAR(2048),
                REFRESH_TOKEN VARCHAR(2048),
                CONSUMER_KEY_ID INTEGER,
                AUTHZ_USER VARCHAR (100),
                TENANT_ID INTEGER,
                USER_DOMAIN VARCHAR(50),
                USER_TYPE VARCHAR (25),
                GRANT_TYPE VARCHAR (50),
                TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                REFRESH_TOKEN_TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                VALIDITY_PERIOD BIGINT,
                REFRESH_TOKEN_VALIDITY_PERIOD BIGINT,
                TOKEN_SCOPE_HASH VARCHAR(32),
                TOKEN_STATE VARCHAR(25) DEFAULT 'ACTIVE',
                TOKEN_STATE_ID VARCHAR (128) DEFAULT 'NONE',
                SUBJECT_IDENTIFIER VARCHAR(255),
                ACCESS_TOKEN_HASH VARCHAR(512),
                REFRESH_TOKEN_HASH VARCHAR(512),
                IDP_ID INTEGER,
                PRIMARY KEY (TOKEN_ID),
                FOREIGN KEY (CONSUMER_KEY_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE,
                CONSTRAINT CON_APP_KEY UNIQUE (CONSUMER_KEY_ID,AUTHZ_USER,TENANT_ID,USER_DOMAIN,USER_TYPE,TOKEN_SCOPE_HASH,
                                               TOKEN_STATE,TOKEN_STATE_ID,IDP_ID)
    )ENGINE INNODB;


    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_ACCESS_TOKEN_AUDIT (
                TOKEN_ID VARCHAR (255),
                ACCESS_TOKEN VARCHAR(2048),
                REFRESH_TOKEN VARCHAR(2048),
                CONSUMER_KEY_ID INTEGER,
                AUTHZ_USER VARCHAR (100),
                TENANT_ID INTEGER,
                USER_DOMAIN VARCHAR(50),
                USER_TYPE VARCHAR (25),
                GRANT_TYPE VARCHAR (50),
                TIME_CREATED TIMESTAMP NULL,
                REFRESH_TOKEN_TIME_CREATED TIMESTAMP NULL,
                VALIDITY_PERIOD BIGINT,
                REFRESH_TOKEN_VALIDITY_PERIOD BIGINT,
                TOKEN_SCOPE_HASH VARCHAR(32),
                TOKEN_STATE VARCHAR(25),
                TOKEN_STATE_ID VARCHAR (128) ,
                SUBJECT_IDENTIFIER VARCHAR(255),
                ACCESS_TOKEN_HASH VARCHAR(512),
                REFRESH_TOKEN_HASH VARCHAR(512),
                INVALIDATED_TIME TIMESTAMP NULL,
                IDP_ID INTEGER
    );

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_AUTHORIZATION_CODE (
                CODE_ID VARCHAR (255),
                AUTHORIZATION_CODE VARCHAR(2048),
                CONSUMER_KEY_ID INTEGER,
                CALLBACK_URL VARCHAR(2048),
                SCOPE VARCHAR(2048),
                AUTHZ_USER VARCHAR (100),
                TENANT_ID INTEGER,
                USER_DOMAIN VARCHAR(50),
                TIME_CREATED TIMESTAMP,
                VALIDITY_PERIOD BIGINT,
                STATE VARCHAR (25) DEFAULT 'ACTIVE',
                TOKEN_ID VARCHAR(255),
                SUBJECT_IDENTIFIER VARCHAR(255),
                PKCE_CODE_CHALLENGE VARCHAR(255),
                PKCE_CODE_CHALLENGE_METHOD VARCHAR(128),
                AUTHORIZATION_CODE_HASH VARCHAR(512),
                IDP_ID INTEGER,
                PRIMARY KEY (CODE_ID),
                FOREIGN KEY (CONSUMER_KEY_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
    )ENGINE INNODB;




    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_ACCESS_TOKEN_SCOPE (
                TOKEN_ID VARCHAR (255),
                TOKEN_SCOPE VARCHAR (60),
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (TOKEN_ID, TOKEN_SCOPE),
                FOREIGN KEY (TOKEN_ID) REFERENCES IDN_OAUTH2_ACCESS_TOKEN(TOKEN_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_SCOPE (
                SCOPE_ID INTEGER NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(255) NOT NULL,
                DISPLAY_NAME VARCHAR(255) NOT NULL,
                DESCRIPTION VARCHAR(512),
                TENANT_ID INTEGER NOT NULL DEFAULT -1,
                PRIMARY KEY (SCOPE_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_SCOPE_BINDING (
                SCOPE_ID INTEGER NOT NULL,
                SCOPE_BINDING VARCHAR(255),
                FOREIGN KEY (SCOPE_ID) REFERENCES IDN_OAUTH2_SCOPE(SCOPE_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OAUTH2_RESOURCE_SCOPE (
                RESOURCE_PATH VARCHAR(255) NOT NULL,
                SCOPE_ID INTEGER NOT NULL,
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (RESOURCE_PATH),
                FOREIGN KEY (SCOPE_ID) REFERENCES IDN_OAUTH2_SCOPE (SCOPE_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_SCIM_GROUP (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                ROLE_NAME VARCHAR(255) NOT NULL,
                ATTR_NAME VARCHAR(1024) NOT NULL,
                ATTR_VALUE VARCHAR(1024),
                PRIMARY KEY (ID)
    )ENGINE INNODB;



    CREATE TABLE IF NOT EXISTS IDN_OPENID_REMEMBER_ME (
                USER_NAME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT 0,
                COOKIE_VALUE VARCHAR(1024),
                CREATED_TIME TIMESTAMP,
                PRIMARY KEY (USER_NAME, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OPENID_USER_RPS (
                USER_NAME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT 0,
                RP_URL VARCHAR(255) NOT NULL,
                TRUSTED_ALWAYS VARCHAR(128) DEFAULT 'FALSE',
                LAST_VISIT DATE NOT NULL,
                VISIT_COUNT INTEGER DEFAULT 0,
                DEFAULT_PROFILE_NAME VARCHAR(255) DEFAULT 'DEFAULT',
                PRIMARY KEY (USER_NAME, TENANT_ID, RP_URL)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OPENID_ASSOCIATIONS (
                HANDLE VARCHAR(255) NOT NULL,
                ASSOC_TYPE VARCHAR(255) NOT NULL,
                EXPIRE_IN TIMESTAMP NOT NULL,
                MAC_KEY VARCHAR(255) NOT NULL,
                ASSOC_STORE VARCHAR(128) DEFAULT 'SHARED',
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (HANDLE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_STS_STORE (
                ID INTEGER AUTO_INCREMENT,
                TOKEN_ID VARCHAR(255) NOT NULL,
                TOKEN_CONTENT BLOB(1024) NOT NULL,
                CREATE_DATE TIMESTAMP NOT NULL,
                EXPIRE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                STATE INTEGER DEFAULT 0,
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_IDENTITY_USER_DATA (
                TENANT_ID INTEGER DEFAULT -1234,
                USER_NAME VARCHAR(255) NOT NULL,
                DATA_KEY VARCHAR(255) NOT NULL,
                DATA_VALUE VARCHAR(2048),
                PRIMARY KEY (TENANT_ID, USER_NAME, DATA_KEY)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_IDENTITY_META_DATA (
                USER_NAME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT -1234,
                METADATA_TYPE VARCHAR(255) NOT NULL,
                METADATA VARCHAR(255) NOT NULL,
                VALID VARCHAR(255) NOT NULL,
                PRIMARY KEY (TENANT_ID, USER_NAME, METADATA_TYPE,METADATA)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_THRIFT_SESSION (
                SESSION_ID VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(255) NOT NULL,
                CREATED_TIME VARCHAR(255) NOT NULL,
                LAST_MODIFIED_TIME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (SESSION_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_AUTH_SESSION_STORE (
                SESSION_ID VARCHAR (100) NOT NULL,
                SESSION_TYPE VARCHAR(100) NOT NULL,
                OPERATION VARCHAR(10) NOT NULL,
                SESSION_OBJECT BLOB,
                TIME_CREATED BIGINT,
                TENANT_ID INTEGER DEFAULT -1,
                EXPIRY_TIME BIGINT,
                PRIMARY KEY (SESSION_ID, SESSION_TYPE, TIME_CREATED, OPERATION)
    )ENGINE INNODB;




    CREATE TABLE IF NOT EXISTS IDN_AUTH_TEMP_SESSION_STORE (
                SESSION_ID VARCHAR (100) NOT NULL,
                SESSION_TYPE VARCHAR(100) NOT NULL,
                OPERATION VARCHAR(10) NOT NULL,
                SESSION_OBJECT BLOB,
                TIME_CREATED BIGINT,
                TENANT_ID INTEGER DEFAULT -1,
                EXPIRY_TIME BIGINT,
                PRIMARY KEY (SESSION_ID, SESSION_TYPE, TIME_CREATED, OPERATION)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_AUTH_USER (
                USER_ID VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER NOT NULL,
                DOMAIN_NAME VARCHAR(255) NOT NULL,
                IDP_ID INTEGER NOT NULL,
                PRIMARY KEY (USER_ID),
                CONSTRAINT USER_STORE_CONSTRAINT UNIQUE (USER_NAME, TENANT_ID, DOMAIN_NAME, IDP_ID));

    CREATE TABLE IF NOT EXISTS IDN_AUTH_USER_SESSION_MAPPING (
                USER_ID VARCHAR(255) NOT NULL,
                SESSION_ID VARCHAR(255) NOT NULL,
                CONSTRAINT USER_SESSION_STORE_CONSTRAINT UNIQUE (USER_ID, SESSION_ID));

    CREATE TABLE IF NOT EXISTS IDN_AUTH_SESSION_APP_INFO (
                SESSION_ID VARCHAR (100) NOT NULL,
                SUBJECT VARCHAR (100) NOT NULL,
                APP_ID INTEGER NOT NULL,
                INBOUND_AUTH_TYPE VARCHAR (255) NOT NULL,
                PRIMARY KEY (SESSION_ID, SUBJECT, APP_ID, INBOUND_AUTH_TYPE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_AUTH_SESSION_META_DATA (
                SESSION_ID VARCHAR (100) NOT NULL,
                PROPERTY_TYPE VARCHAR (100) NOT NULL,
                VALUE VARCHAR (255) NOT NULL,
                PRIMARY KEY (SESSION_ID, PROPERTY_TYPE, VALUE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS SP_APP (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            TENANT_ID INTEGER NOT NULL,
    	    	APP_NAME VARCHAR (255) NOT NULL ,
    	    	USER_STORE VARCHAR (255) NOT NULL,
            USERNAME VARCHAR (255) NOT NULL ,
            DESCRIPTION VARCHAR (1024),
    	    	ROLE_CLAIM VARCHAR (512),
            AUTH_TYPE VARCHAR (255) NOT NULL,
    	    	PROVISIONING_USERSTORE_DOMAIN VARCHAR (512),
    	    	IS_LOCAL_CLAIM_DIALECT CHAR(1) DEFAULT '1',
    	    	IS_SEND_LOCAL_SUBJECT_ID CHAR(1) DEFAULT '0',
    	    	IS_SEND_AUTH_LIST_OF_IDPS CHAR(1) DEFAULT '0',
            IS_USE_TENANT_DOMAIN_SUBJECT CHAR(1) DEFAULT '1',
            IS_USE_USER_DOMAIN_SUBJECT CHAR(1) DEFAULT '1',
            ENABLE_AUTHORIZATION CHAR(1) DEFAULT '0',
    	    	SUBJECT_CLAIM_URI VARCHAR (512),
    	    	IS_SAAS_APP CHAR(1) DEFAULT '0',
    	    	IS_DUMB_MODE CHAR(1) DEFAULT '0',
            PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_APP ADD CONSTRAINT APPLICATION_NAME_CONSTRAINT UNIQUE(APP_NAME, TENANT_ID);

    CREATE TABLE IF NOT EXISTS SP_METADATA (
                ID INTEGER AUTO_INCREMENT,
                SP_ID INTEGER,
                NAME VARCHAR(255) NOT NULL,
                VALUE VARCHAR(255) NOT NULL,
                DISPLAY_NAME VARCHAR(255),
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (ID),
                CONSTRAINT SP_METADATA_CONSTRAINT UNIQUE (SP_ID, NAME),
                FOREIGN KEY (SP_ID) REFERENCES SP_APP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS SP_INBOUND_AUTH (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                INBOUND_AUTH_KEY VARCHAR (255),
                INBOUND_AUTH_TYPE VARCHAR (255) NOT NULL,
                INBOUND_CONFIG_TYPE VARCHAR (255) NOT NULL,
                PROP_NAME VARCHAR (255),
                PROP_VALUE VARCHAR (1024) ,
                APP_ID INTEGER NOT NULL,
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_INBOUND_AUTH ADD CONSTRAINT APPLICATION_ID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_AUTH_STEP (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                STEP_ORDER INTEGER DEFAULT 1,
                APP_ID INTEGER NOT NULL ,
                IS_SUBJECT_STEP CHAR(1) DEFAULT '0',
                IS_ATTRIBUTE_STEP CHAR(1) DEFAULT '0',
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_AUTH_STEP ADD CONSTRAINT APPLICATION_ID_CONSTRAINT_STEP FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_FEDERATED_IDP (
                ID INTEGER NOT NULL,
                TENANT_ID INTEGER NOT NULL,
                AUTHENTICATOR_ID INTEGER NOT NULL,
                PRIMARY KEY (ID, AUTHENTICATOR_ID)
    )ENGINE INNODB;

    ALTER TABLE SP_FEDERATED_IDP ADD CONSTRAINT STEP_ID_CONSTRAINT FOREIGN KEY (ID) REFERENCES SP_AUTH_STEP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_CLAIM_DIALECT (
    	   	ID INTEGER NOT NULL AUTO_INCREMENT,
    	   	TENANT_ID INTEGER NOT NULL,
    	   	SP_DIALECT VARCHAR (512) NOT NULL,
    	   	APP_ID INTEGER NOT NULL,
    	   	PRIMARY KEY (ID));

    ALTER TABLE SP_CLAIM_DIALECT ADD CONSTRAINT DIALECTID_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_CLAIM_MAPPING (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                IDP_CLAIM VARCHAR (512) NOT NULL ,
                SP_CLAIM VARCHAR (512) NOT NULL ,
                APP_ID INTEGER NOT NULL,
                IS_REQUESTED VARCHAR(128) DEFAULT '0',
    	    IS_MANDATORY VARCHAR(128) DEFAULT '0',
                DEFAULT_VALUE VARCHAR(255),
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_CLAIM_MAPPING ADD CONSTRAINT CLAIMID_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_ROLE_MAPPING (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                IDP_ROLE VARCHAR (255) NOT NULL ,
                SP_ROLE VARCHAR (255) NOT NULL ,
                APP_ID INTEGER NOT NULL,
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_ROLE_MAPPING ADD CONSTRAINT ROLEID_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_REQ_PATH_AUTHENTICATOR (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                AUTHENTICATOR_NAME VARCHAR (255) NOT NULL ,
                APP_ID INTEGER NOT NULL,
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_REQ_PATH_AUTHENTICATOR ADD CONSTRAINT REQ_AUTH_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE IF NOT EXISTS SP_PROVISIONING_CONNECTOR (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                TENANT_ID INTEGER NOT NULL,
                IDP_NAME VARCHAR (255) NOT NULL ,
                CONNECTOR_NAME VARCHAR (255) NOT NULL ,
                APP_ID INTEGER NOT NULL,
                IS_JIT_ENABLED CHAR(1) NOT NULL DEFAULT '0',
                BLOCKING CHAR(1) NOT NULL DEFAULT '0',
                RULE_ENABLED CHAR(1) NOT NULL DEFAULT '0',
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    ALTER TABLE SP_PROVISIONING_CONNECTOR ADD CONSTRAINT PRO_CONNECTOR_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE;

    CREATE TABLE SP_AUTH_SCRIPT (
      ID         INTEGER AUTO_INCREMENT NOT NULL,
      TENANT_ID  INTEGER                NOT NULL,
      APP_ID     INTEGER                NOT NULL,
      TYPE       VARCHAR(255)           NOT NULL,
      CONTENT    BLOB    DEFAULT NULL,
      IS_ENABLED CHAR(1) NOT NULL DEFAULT '0',
      PRIMARY KEY (ID));

    CREATE TABLE IF NOT EXISTS SP_TEMPLATE (
      ID         INTEGER AUTO_INCREMENT NOT NULL,
      TENANT_ID  INTEGER                NOT NULL,
      NAME VARCHAR(255) NOT NULL,
      DESCRIPTION VARCHAR(1023),
      CONTENT BLOB DEFAULT NULL,
      PRIMARY KEY (ID),
      CONSTRAINT SP_TEMPLATE_CONSTRAINT UNIQUE (TENANT_ID, NAME));

    CREATE TABLE IF NOT EXISTS IDN_ARTIFACT_STORE (
      ID          VARCHAR(255)           NOT NULL,
      TENANT_ID   INTEGER                NOT NULL,
      ARTIFACT    BLOB                   DEFAULT NULL,
      IDENTIFIER  VARCHAR(255)           NOT NULL,
      ARTIFACT_TYPE       VARCHAR(255)   NOT NULL,
      CONTENT_TYPE        VARCHAR(255)   DEFAULT NULL,
      PRIMARY KEY (ID),
      UNIQUE (IDENTIFIER , ARTIFACT_TYPE )
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_AUTH_WAIT_STATUS (
      ID              INTEGER AUTO_INCREMENT NOT NULL,
      TENANT_ID       INTEGER                NOT NULL,
      LONG_WAIT_KEY   VARCHAR(255)           NOT NULL,
      WAIT_STATUS     CHAR(1) NOT NULL DEFAULT '1',
      TIME_CREATED    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      EXPIRE_TIME     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (ID),
      CONSTRAINT IDN_AUTH_WAIT_STATUS_KEY UNIQUE (LONG_WAIT_KEY));

    CREATE TABLE IF NOT EXISTS IDP (
    			ID INTEGER AUTO_INCREMENT,
    			TENANT_ID INTEGER,
    			NAME VARCHAR(254) NOT NULL,
    			IS_ENABLED CHAR(1) NOT NULL DEFAULT '1',
    			IS_PRIMARY CHAR(1) NOT NULL DEFAULT '0',
    			HOME_REALM_ID VARCHAR(254),
    			IMAGE MEDIUMBLOB,
    			CERTIFICATE BLOB,
    			ALIAS VARCHAR(254),
    			INBOUND_PROV_ENABLED CHAR (1) NOT NULL DEFAULT '0',
    			INBOUND_PROV_USER_STORE_ID VARCHAR(254),
     			USER_CLAIM_URI VARCHAR(254),
     			ROLE_CLAIM_URI VARCHAR(254),
      			DESCRIPTION VARCHAR (1024),
     			DEFAULT_AUTHENTICATOR_NAME VARCHAR(254),
     			DEFAULT_PRO_CONNECTOR_NAME VARCHAR(254),
     			PROVISIONING_ROLE VARCHAR(128),
     			IS_FEDERATION_HUB CHAR(1) NOT NULL DEFAULT '0',
     			IS_LOCAL_CLAIM_DIALECT CHAR(1) NOT NULL DEFAULT '0',
                DISPLAY_NAME VARCHAR(255),
    			PRIMARY KEY (ID),
    			UNIQUE (TENANT_ID, NAME)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_ROLE (
    			ID INTEGER AUTO_INCREMENT,
    			IDP_ID INTEGER,
    			TENANT_ID INTEGER,
    			ROLE VARCHAR(254),
    			PRIMARY KEY (ID),
    			UNIQUE (IDP_ID, ROLE),
    			FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_ROLE_MAPPING (
    			ID INTEGER AUTO_INCREMENT,
    			IDP_ROLE_ID INTEGER,
    			TENANT_ID INTEGER,
    			USER_STORE_ID VARCHAR (253),
    			LOCAL_ROLE VARCHAR(253),
    			PRIMARY KEY (ID),
    			UNIQUE (IDP_ROLE_ID, TENANT_ID, USER_STORE_ID, LOCAL_ROLE),
    			FOREIGN KEY (IDP_ROLE_ID) REFERENCES IDP_ROLE(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_CLAIM (
    			ID INTEGER AUTO_INCREMENT,
    			IDP_ID INTEGER,
    			TENANT_ID INTEGER,
    			CLAIM VARCHAR(254),
    			PRIMARY KEY (ID),
    			UNIQUE (IDP_ID, CLAIM),
    			FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_CLAIM_MAPPING (
                ID INTEGER AUTO_INCREMENT,
                IDP_CLAIM_ID INTEGER,
                TENANT_ID INTEGER,
                LOCAL_CLAIM VARCHAR(253),
                DEFAULT_VALUE VARCHAR(255),
                IS_REQUESTED VARCHAR(128) DEFAULT '0',
                PRIMARY KEY (ID),
                UNIQUE (IDP_CLAIM_ID, TENANT_ID, LOCAL_CLAIM),
                FOREIGN KEY (IDP_CLAIM_ID) REFERENCES IDP_CLAIM(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_AUTHENTICATOR (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER,
                IDP_ID INTEGER,
                NAME VARCHAR(255) NOT NULL,
                IS_ENABLED CHAR (1) DEFAULT '1',
                DISPLAY_NAME VARCHAR(255),
                PRIMARY KEY (ID),
                UNIQUE (TENANT_ID, IDP_ID, NAME),
                FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_METADATA (
                ID INTEGER AUTO_INCREMENT,
                IDP_ID INTEGER,
                NAME VARCHAR(255) NOT NULL,
                VALUE VARCHAR(255) NOT NULL,
                DISPLAY_NAME VARCHAR(255),
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (ID),
                CONSTRAINT IDP_METADATA_CONSTRAINT UNIQUE (IDP_ID, NAME),
                FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_AUTHENTICATOR_PROPERTY (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER,
                AUTHENTICATOR_ID INTEGER,
                PROPERTY_KEY VARCHAR(255) NOT NULL,
                PROPERTY_VALUE VARCHAR(2047),
                IS_SECRET CHAR (1) DEFAULT '0',
                PRIMARY KEY (ID),
                UNIQUE (TENANT_ID, AUTHENTICATOR_ID, PROPERTY_KEY),
                FOREIGN KEY (AUTHENTICATOR_ID) REFERENCES IDP_AUTHENTICATOR(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_PROVISIONING_CONFIG (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER,
                IDP_ID INTEGER,
                PROVISIONING_CONNECTOR_TYPE VARCHAR(255) NOT NULL,
                IS_ENABLED CHAR (1) DEFAULT '0',
                IS_BLOCKING CHAR (1) DEFAULT '0',
                IS_RULES_ENABLED CHAR (1) DEFAULT '0',
                PRIMARY KEY (ID),
                UNIQUE (TENANT_ID, IDP_ID, PROVISIONING_CONNECTOR_TYPE),
                FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_PROV_CONFIG_PROPERTY (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER,
                PROVISIONING_CONFIG_ID INTEGER,
                PROPERTY_KEY VARCHAR(255) NOT NULL,
                PROPERTY_VALUE VARCHAR(2048),
                PROPERTY_BLOB_VALUE BLOB,
                PROPERTY_TYPE CHAR(32) NOT NULL,
                IS_SECRET CHAR (1) DEFAULT '0',
                PRIMARY KEY (ID),
                UNIQUE (TENANT_ID, PROVISIONING_CONFIG_ID, PROPERTY_KEY),
                FOREIGN KEY (PROVISIONING_CONFIG_ID) REFERENCES IDP_PROVISIONING_CONFIG(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_PROVISIONING_ENTITY (
                ID INTEGER AUTO_INCREMENT,
                PROVISIONING_CONFIG_ID INTEGER,
                ENTITY_TYPE VARCHAR(255) NOT NULL,
                ENTITY_LOCAL_USERSTORE VARCHAR(255) NOT NULL,
                ENTITY_NAME VARCHAR(255) NOT NULL,
                ENTITY_VALUE VARCHAR(255),
                TENANT_ID INTEGER,
                ENTITY_LOCAL_ID VARCHAR(255),
                PRIMARY KEY (ID),
                UNIQUE (ENTITY_TYPE, TENANT_ID, ENTITY_LOCAL_USERSTORE, ENTITY_NAME, PROVISIONING_CONFIG_ID),
                UNIQUE (PROVISIONING_CONFIG_ID, ENTITY_TYPE, ENTITY_VALUE),
                FOREIGN KEY (PROVISIONING_CONFIG_ID) REFERENCES IDP_PROVISIONING_CONFIG(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDP_LOCAL_CLAIM (
                ID INTEGER AUTO_INCREMENT,
                TENANT_ID INTEGER,
                IDP_ID INTEGER,
                CLAIM_URI VARCHAR(255) NOT NULL,
                DEFAULT_VALUE VARCHAR(255),
                IS_REQUESTED VARCHAR(128) DEFAULT '0',
                PRIMARY KEY (ID),
                UNIQUE (TENANT_ID, IDP_ID, CLAIM_URI),
                FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_ASSOCIATED_ID (
                ID INTEGER AUTO_INCREMENT,
                IDP_USER_ID VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT -1234,
                IDP_ID INTEGER NOT NULL,
                DOMAIN_NAME VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(255) NOT NULL,
                PRIMARY KEY (ID),
                UNIQUE(IDP_USER_ID, TENANT_ID, IDP_ID),
                FOREIGN KEY (IDP_ID) REFERENCES IDP(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_USER_ACCOUNT_ASSOCIATION (
                ASSOCIATION_KEY VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER,
                DOMAIN_NAME VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(255) NOT NULL,
                PRIMARY KEY (TENANT_ID, DOMAIN_NAME, USER_NAME)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS FIDO_DEVICE_STORE (
                TENANT_ID INTEGER,
                DOMAIN_NAME VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(45) NOT NULL,
                TIME_REGISTERED TIMESTAMP,
                KEY_HANDLE VARCHAR(200) NOT NULL,
                DEVICE_DATA VARCHAR(2048) NOT NULL,
                PRIMARY KEY (TENANT_ID, DOMAIN_NAME, USER_NAME, KEY_HANDLE)
            )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS FIDO2_DEVICE_STORE (
                TENANT_ID INTEGER,
                DOMAIN_NAME VARCHAR(255) NOT NULL,
                USER_NAME VARCHAR(45) NOT NULL,
                TIME_REGISTERED TIMESTAMP,
                USER_HANDLE VARCHAR(64) NOT NULL,
                CREDENTIAL_ID VARCHAR(200) NOT NULL,
                PUBLIC_KEY_COSE VARCHAR(1024) NOT NULL,
                SIGNATURE_COUNT BIGINT,
                USER_IDENTITY VARCHAR(512) NOT NULL,
                PRIMARY KEY (CREDENTIAL_ID, USER_HANDLE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_REQUEST (
        UUID VARCHAR (45),
        CREATED_BY VARCHAR (255),
        TENANT_ID INTEGER DEFAULT -1,
        OPERATION_TYPE VARCHAR (50),
        CREATED_AT TIMESTAMP,
        UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        STATUS VARCHAR (30),
        REQUEST BLOB,
        PRIMARY KEY (UUID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_BPS_PROFILE (
        PROFILE_NAME VARCHAR(45),
        HOST_URL_MANAGER VARCHAR(255),
        HOST_URL_WORKER VARCHAR(255),
        USERNAME VARCHAR(45),
        PASSWORD VARCHAR(1023),
        CALLBACK_HOST VARCHAR (45),
        CALLBACK_USERNAME VARCHAR (45),
        CALLBACK_PASSWORD VARCHAR (255),
        TENANT_ID INTEGER DEFAULT -1,
        PRIMARY KEY (PROFILE_NAME, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_WORKFLOW(
        ID VARCHAR (45),
        WF_NAME VARCHAR (45),
        DESCRIPTION VARCHAR (255),
        TEMPLATE_ID VARCHAR (45),
        IMPL_ID VARCHAR (45),
        TENANT_ID INTEGER DEFAULT -1,
        PRIMARY KEY (ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_WORKFLOW_ASSOCIATION(
        ID INTEGER NOT NULL AUTO_INCREMENT,
        ASSOC_NAME VARCHAR (45),
        EVENT_ID VARCHAR(45),
        ASSOC_CONDITION VARCHAR (2000),
        WORKFLOW_ID VARCHAR (45),
        IS_ENABLED CHAR (1) DEFAULT '1',
        TENANT_ID INTEGER DEFAULT -1,
        PRIMARY KEY(ID),
        FOREIGN KEY (WORKFLOW_ID) REFERENCES WF_WORKFLOW(ID)ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_WORKFLOW_CONFIG_PARAM(
        WORKFLOW_ID VARCHAR (45),
        PARAM_NAME VARCHAR (45),
        PARAM_VALUE VARCHAR (1000),
        PARAM_QNAME VARCHAR (45),
        PARAM_HOLDER VARCHAR (45),
        TENANT_ID INTEGER DEFAULT -1,
        PRIMARY KEY (WORKFLOW_ID, PARAM_NAME, PARAM_QNAME, PARAM_HOLDER),
        FOREIGN KEY (WORKFLOW_ID) REFERENCES WF_WORKFLOW(ID)ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_REQUEST_ENTITY_RELATIONSHIP(
      REQUEST_ID VARCHAR (45),
      ENTITY_NAME VARCHAR (255),
      ENTITY_TYPE VARCHAR (50),
      TENANT_ID INTEGER DEFAULT -1,
      PRIMARY KEY(REQUEST_ID, ENTITY_NAME, ENTITY_TYPE, TENANT_ID),
      FOREIGN KEY (REQUEST_ID) REFERENCES WF_REQUEST(UUID)ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS WF_WORKFLOW_REQUEST_RELATION(
      RELATIONSHIP_ID VARCHAR (45),
      WORKFLOW_ID VARCHAR (45),
      REQUEST_ID VARCHAR (45),
      UPDATED_AT TIMESTAMP,
      STATUS VARCHAR (30),
      TENANT_ID INTEGER DEFAULT -1,
      PRIMARY KEY (RELATIONSHIP_ID),
      FOREIGN KEY (WORKFLOW_ID) REFERENCES WF_WORKFLOW(ID)ON DELETE CASCADE,
      FOREIGN KEY (REQUEST_ID) REFERENCES WF_REQUEST(UUID)ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_RECOVERY_DATA (
      USER_NAME VARCHAR(255) NOT NULL,
      USER_DOMAIN VARCHAR(127) NOT NULL,
      TENANT_ID INTEGER DEFAULT -1,
      CODE VARCHAR(255) NOT NULL,
      SCENARIO VARCHAR(255) NOT NULL,
      STEP VARCHAR(127) NOT NULL,
      TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      REMAINING_SETS VARCHAR(2500) DEFAULT NULL,
      PRIMARY KEY(USER_NAME, USER_DOMAIN, TENANT_ID, SCENARIO,STEP),
      UNIQUE(CODE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_PASSWORD_HISTORY_DATA (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      USER_NAME   VARCHAR(127) NOT NULL,
      USER_DOMAIN VARCHAR(50) NOT NULL,
      TENANT_ID   INTEGER DEFAULT -1,
      SALT_VALUE  VARCHAR(255),
      HASH        VARCHAR(255) NOT NULL,
      TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY(ID),
      UNIQUE (USER_NAME,USER_DOMAIN,TENANT_ID,SALT_VALUE,HASH)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CLAIM_DIALECT (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      DIALECT_URI VARCHAR (255) NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      PRIMARY KEY (ID),
      CONSTRAINT DIALECT_URI_CONSTRAINT UNIQUE (DIALECT_URI, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CLAIM (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      DIALECT_ID INTEGER,
      CLAIM_URI VARCHAR (255) NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      PRIMARY KEY (ID),
      FOREIGN KEY (DIALECT_ID) REFERENCES IDN_CLAIM_DIALECT(ID) ON DELETE CASCADE,
      CONSTRAINT CLAIM_URI_CONSTRAINT UNIQUE (DIALECT_ID, CLAIM_URI, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CLAIM_MAPPED_ATTRIBUTE (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      LOCAL_CLAIM_ID INTEGER,
      USER_STORE_DOMAIN_NAME VARCHAR (255) NOT NULL,
      ATTRIBUTE_NAME VARCHAR (255) NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      PRIMARY KEY (ID),
      FOREIGN KEY (LOCAL_CLAIM_ID) REFERENCES IDN_CLAIM(ID) ON DELETE CASCADE,
      CONSTRAINT USER_STORE_DOMAIN_CONSTRAINT UNIQUE (LOCAL_CLAIM_ID, USER_STORE_DOMAIN_NAME, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CLAIM_PROPERTY (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      LOCAL_CLAIM_ID INTEGER,
      PROPERTY_NAME VARCHAR (255) NOT NULL,
      PROPERTY_VALUE VARCHAR (255) NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      PRIMARY KEY (ID),
      FOREIGN KEY (LOCAL_CLAIM_ID) REFERENCES IDN_CLAIM(ID) ON DELETE CASCADE,
      CONSTRAINT PROPERTY_NAME_CONSTRAINT UNIQUE (LOCAL_CLAIM_ID, PROPERTY_NAME, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CLAIM_MAPPING (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      EXT_CLAIM_ID INTEGER NOT NULL,
      MAPPED_LOCAL_CLAIM_ID INTEGER NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      PRIMARY KEY (ID),
      FOREIGN KEY (EXT_CLAIM_ID) REFERENCES IDN_CLAIM(ID) ON DELETE CASCADE,
      FOREIGN KEY (MAPPED_LOCAL_CLAIM_ID) REFERENCES IDN_CLAIM(ID) ON DELETE CASCADE,
      CONSTRAINT EXT_TO_LOC_MAPPING_CONSTRN UNIQUE (EXT_CLAIM_ID, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS  IDN_SAML2_ASSERTION_STORE (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      SAML2_ID  VARCHAR(255) ,
      SAML2_ISSUER  VARCHAR(255) ,
      SAML2_SUBJECT  VARCHAR(255) ,
      SAML2_SESSION_INDEX  VARCHAR(255) ,
      SAML2_AUTHN_CONTEXT_CLASS_REF  VARCHAR(255) ,
      SAML2_ASSERTION  VARCHAR(4096) ,
      ASSERTION BLOB ,
      PRIMARY KEY (ID)
    )ENGINE INNODB;

    CREATE TABLE IDN_SAML2_ARTIFACT_STORE (
      ID INT(11) NOT NULL AUTO_INCREMENT,
      SOURCE_ID VARCHAR(255) NOT NULL,
      MESSAGE_HANDLER VARCHAR(255) NOT NULL,
      AUTHN_REQ_DTO BLOB NOT NULL,
      SESSION_ID VARCHAR(255) NOT NULL,
      EXP_TIMESTAMP TIMESTAMP NOT NULL,
      INIT_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      ASSERTION_ID VARCHAR(255),
      PRIMARY KEY (`ID`)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_JTI (
      JWT_ID VARCHAR(255) NOT NULL,
      EXP_TIME TIMESTAMP NOT NULL ,
      TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
      PRIMARY KEY (JWT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS  IDN_OIDC_PROPERTY (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      TENANT_ID  INTEGER,
      CONSUMER_KEY  VARCHAR(255) ,
      PROPERTY_KEY  VARCHAR(255) NOT NULL,
      PROPERTY_VALUE  VARCHAR(2047) ,
      PRIMARY KEY (ID),
      FOREIGN KEY (CONSUMER_KEY) REFERENCES IDN_OAUTH_CONSUMER_APPS(CONSUMER_KEY) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_REQ_OBJECT_REFERENCE (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      CONSUMER_KEY_ID INTEGER ,
      CODE_ID VARCHAR(255) ,
      TOKEN_ID VARCHAR(255) ,
      SESSION_DATA_KEY VARCHAR(255),
      PRIMARY KEY (ID),
      FOREIGN KEY (CONSUMER_KEY_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE,
      FOREIGN KEY (TOKEN_ID) REFERENCES IDN_OAUTH2_ACCESS_TOKEN(TOKEN_ID) ON DELETE CASCADE,
      FOREIGN KEY (CODE_ID) REFERENCES IDN_OAUTH2_AUTHORIZATION_CODE(CODE_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_REQ_OBJECT_CLAIMS (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      REQ_OBJECT_ID INTEGER,
      CLAIM_ATTRIBUTE VARCHAR(255) ,
      ESSENTIAL CHAR(1) NOT NULL DEFAULT '0' ,
      VALUE VARCHAR(255) ,
      IS_USERINFO CHAR(1) NOT NULL DEFAULT '0',
      PRIMARY KEY (ID),
      FOREIGN KEY (REQ_OBJECT_ID) REFERENCES IDN_OIDC_REQ_OBJECT_REFERENCE (ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_REQ_OBJ_CLAIM_VALUES (
      ID INTEGER NOT NULL AUTO_INCREMENT,
      REQ_OBJECT_CLAIMS_ID INTEGER ,
      CLAIM_VALUES VARCHAR(255) ,
      PRIMARY KEY (ID),
      FOREIGN KEY (REQ_OBJECT_CLAIMS_ID) REFERENCES  IDN_OIDC_REQ_OBJECT_CLAIMS(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_CERTIFICATE (
                 ID INTEGER NOT NULL AUTO_INCREMENT,
                 NAME VARCHAR(100),
                 CERTIFICATE_IN_PEM BLOB,
                 TENANT_ID INTEGER DEFAULT 0,
                 PRIMARY KEY(ID),
                 CONSTRAINT CERTIFICATE_UNIQUE_KEY UNIQUE (NAME, TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_SCOPE (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(255) NOT NULL,
                TENANT_ID INTEGER DEFAULT -1,
                PRIMARY KEY (ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_OIDC_SCOPE_CLAIM_MAPPING (
                ID INTEGER NOT NULL AUTO_INCREMENT,
                SCOPE_ID INTEGER,
                EXTERNAL_CLAIM_ID INTEGER,
                PRIMARY KEY (ID),
                FOREIGN KEY (SCOPE_ID) REFERENCES IDN_OIDC_SCOPE(ID) ON DELETE CASCADE,
                FOREIGN KEY (EXTERNAL_CLAIM_ID) REFERENCES IDN_CLAIM(ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS IDN_FUNCTION_LIBRARY (
    	NAME VARCHAR(255) NOT NULL,
    	DESCRIPTION VARCHAR(1023),
    	TYPE VARCHAR(255) NOT NULL,
    	TENANT_ID INTEGER NOT NULL,
    	DATA BLOB NOT NULL,
    	PRIMARY KEY (TENANT_ID,NAME)
    )ENGINE INNODB;

    -- --------------------------- INDEX CREATION -----------------------------
    -- IDN_OAUTH2_ACCESS_TOKEN --
    CREATE INDEX IDX_TC ON IDN_OAUTH2_ACCESS_TOKEN(TIME_CREATED);
    CREATE INDEX IDX_ATH ON IDN_OAUTH2_ACCESS_TOKEN(ACCESS_TOKEN_HASH);
    CREATE INDEX IDX_AT_CK_AU ON IDN_OAUTH2_ACCESS_TOKEN(CONSUMER_KEY_ID, AUTHZ_USER, TOKEN_STATE, USER_TYPE);
    CREATE INDEX IDX_AT_TI_UD ON IDN_OAUTH2_ACCESS_TOKEN(AUTHZ_USER, TENANT_ID, TOKEN_STATE, USER_DOMAIN);
    CREATE INDEX IDX_AT_AU_TID_UD_TS_CKID ON IDN_OAUTH2_ACCESS_TOKEN(AUTHZ_USER, TENANT_ID, USER_DOMAIN, TOKEN_STATE, CONSUMER_KEY_ID);
    CREATE INDEX IDX_AT_AU_CKID_TS_UT ON IDN_OAUTH2_ACCESS_TOKEN(AUTHZ_USER, CONSUMER_KEY_ID, TOKEN_STATE, USER_TYPE);
    CREATE INDEX IDX_AT_RTH ON IDN_OAUTH2_ACCESS_TOKEN(REFRESH_TOKEN_HASH);

    -- IDN_OAUTH2_AUTHORIZATION_CODE --
    CREATE INDEX IDX_AUTHORIZATION_CODE_HASH ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE_HASH, CONSUMER_KEY_ID);
    CREATE INDEX IDX_AUTHORIZATION_CODE_AU_TI ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHZ_USER, TENANT_ID, USER_DOMAIN, STATE);
    CREATE INDEX IDX_AC_CKID ON IDN_OAUTH2_AUTHORIZATION_CODE(CONSUMER_KEY_ID);
    CREATE INDEX IDX_AC_TID ON IDN_OAUTH2_AUTHORIZATION_CODE(TOKEN_ID);

    -- IDN_SCIM_GROUP --
    CREATE INDEX IDX_IDN_SCIM_GROUP_TI_RN ON IDN_SCIM_GROUP (TENANT_ID, ROLE_NAME);
    CREATE INDEX IDX_IDN_SCIM_GROUP_TI_RN_AN ON IDN_SCIM_GROUP (TENANT_ID, ROLE_NAME, ATTR_NAME(500));

    -- IDN_AUTH_SESSION_STORE --
    CREATE INDEX IDX_IDN_AUTH_SESSION_TIME ON IDN_AUTH_SESSION_STORE (TIME_CREATED);

    -- IDN_AUTH_TEMP_SESSION_STORE --
    CREATE INDEX IDX_IDN_AUTH_TMP_SESSION_TIME ON IDN_AUTH_TEMP_SESSION_STORE (TIME_CREATED);

    -- IDN_OIDC_SCOPE_CLAIM_MAPPING --
    CREATE INDEX IDX_AT_SI_ECI ON IDN_OIDC_SCOPE_CLAIM_MAPPING(SCOPE_ID, EXTERNAL_CLAIM_ID);

    -- IDN_OAUTH2_SCOPE --
    CREATE INDEX IDX_SC_TID ON IDN_OAUTH2_SCOPE(TENANT_ID);
    CREATE INDEX IDX_SC_N_TID ON IDN_OAUTH2_SCOPE(NAME, TENANT_ID);

    -- IDN_OAUTH2_SCOPE_BINDING --
    CREATE INDEX IDX_SB_SCPID ON IDN_OAUTH2_SCOPE_BINDING(SCOPE_ID);

    -- IDN_OIDC_REQ_OBJECT_REFERENCE --
    CREATE INDEX IDX_OROR_TID ON IDN_OIDC_REQ_OBJECT_REFERENCE(TOKEN_ID);

    -- IDN_OAUTH2_ACCESS_TOKEN_SCOPE --
    CREATE INDEX IDX_ATS_TID ON IDN_OAUTH2_ACCESS_TOKEN_SCOPE(TOKEN_ID);

    -- SP_TEMPLATE --
    CREATE INDEX IDX_SP_TEMPLATE ON SP_TEMPLATE (TENANT_ID, NAME);

    -- IDN_AUTH_USER --
    CREATE INDEX IDX_AUTH_USER_UN_TID_DN ON IDN_AUTH_USER (USER_NAME, TENANT_ID, DOMAIN_NAME);
    CREATE INDEX IDX_AUTH_USER_DN_TOD ON IDN_AUTH_USER (DOMAIN_NAME, TENANT_ID);

    -- IDN_AUTH_USER_SESSION_MAPPING --
    CREATE INDEX IDX_USER_ID ON IDN_AUTH_USER_SESSION_MAPPING (USER_ID);
    CREATE INDEX IDX_SESSION_ID ON IDN_AUTH_USER_SESSION_MAPPING (SESSION_ID);

    -- IDN_OAUTH_CONSUMER_APPS --
    CREATE INDEX IDX_OCA_UM_TID_UD_APN ON IDN_OAUTH_CONSUMER_APPS(USERNAME,TENANT_ID,USER_DOMAIN, APP_NAME);

    -- IDX_SPI_APP --
    CREATE INDEX IDX_SPI_APP ON SP_INBOUND_AUTH(APP_ID);

    -- IDN_OIDC_PROPERTY --
    CREATE INDEX IDX_IOP_TID_CK ON IDN_OIDC_PROPERTY(TENANT_ID,CONSUMER_KEY);

    -- IDN_FIDO2_PROPERTY --
    CREATE INDEX IDX_FIDO2_STR ON FIDO2_DEVICE_STORE(USER_NAME, TENANT_ID, DOMAIN_NAME, CREDENTIAL_ID, USER_HANDLE);
    -- End of IDENTITY Tables--

    -- Start of CONSENT-MGT Tables --

    CREATE TABLE CM_PII_CATEGORY (
      ID           INTEGER AUTO_INCREMENT,
      NAME         VARCHAR(255) NOT NULL,
      DESCRIPTION  VARCHAR(1023),
      DISPLAY_NAME VARCHAR(255),
      IS_SENSITIVE INTEGER      NOT NULL,
      TENANT_ID    INTEGER DEFAULT '-1234',
      UNIQUE KEY (NAME, TENANT_ID),
      PRIMARY KEY (ID)
    );

    CREATE TABLE CM_RECEIPT (
      CONSENT_RECEIPT_ID  VARCHAR(255) NOT NULL,
      VERSION             VARCHAR(255) NOT NULL,
      JURISDICTION        VARCHAR(255) NOT NULL,
      CONSENT_TIMESTAMP   TIMESTAMP    NOT NULL,
      COLLECTION_METHOD   VARCHAR(255) NOT NULL,
      LANGUAGE            VARCHAR(255) NOT NULL,
      PII_PRINCIPAL_ID    VARCHAR(255) NOT NULL,
      PRINCIPAL_TENANT_ID INTEGER DEFAULT '-1234',
      POLICY_URL          VARCHAR(255) NOT NULL,
      STATE               VARCHAR(255) NOT NULL,
      PII_CONTROLLER      VARCHAR(2048) NOT NULL,
      PRIMARY KEY (CONSENT_RECEIPT_ID)
    );

    CREATE TABLE CM_PURPOSE (
      ID            INTEGER AUTO_INCREMENT,
      NAME          VARCHAR(255) NOT NULL,
      DESCRIPTION   VARCHAR(1023),
      PURPOSE_GROUP VARCHAR(255) NOT NULL,
      GROUP_TYPE    VARCHAR(255) NOT NULL,
      TENANT_ID     INTEGER DEFAULT '-1234',
      UNIQUE KEY (NAME, TENANT_ID, PURPOSE_GROUP, GROUP_TYPE),
      PRIMARY KEY (ID)
    );

    CREATE TABLE CM_PURPOSE_CATEGORY (
      ID          INTEGER AUTO_INCREMENT,
      NAME        VARCHAR(255) NOT NULL,
      DESCRIPTION VARCHAR(1023),
      TENANT_ID   INTEGER DEFAULT '-1234',
      UNIQUE KEY (NAME, TENANT_ID),
      PRIMARY KEY (ID)
    );

    CREATE TABLE CM_RECEIPT_SP_ASSOC (
      ID                 INTEGER AUTO_INCREMENT,
      CONSENT_RECEIPT_ID VARCHAR(255) NOT NULL,
      SP_NAME            VARCHAR(255) NOT NULL,
      SP_DISPLAY_NAME    VARCHAR(255),
      SP_DESCRIPTION     VARCHAR(255),
      SP_TENANT_ID       INTEGER DEFAULT '-1234',
      UNIQUE KEY (CONSENT_RECEIPT_ID, SP_NAME, SP_TENANT_ID),
      PRIMARY KEY (ID)
    );

    CREATE TABLE CM_SP_PURPOSE_ASSOC (
      ID                     INTEGER AUTO_INCREMENT,
      RECEIPT_SP_ASSOC       INTEGER      NOT NULL,
      PURPOSE_ID             INTEGER      NOT NULL,
      CONSENT_TYPE           VARCHAR(255) NOT NULL,
      IS_PRIMARY_PURPOSE     INTEGER      NOT NULL,
      TERMINATION            VARCHAR(255) NOT NULL,
      THIRD_PARTY_DISCLOSURE INTEGER      NOT NULL,
      THIRD_PARTY_NAME       VARCHAR(255),
      UNIQUE KEY (RECEIPT_SP_ASSOC, PURPOSE_ID),
      PRIMARY KEY (ID)
    );

    CREATE TABLE CM_SP_PURPOSE_PURPOSE_CAT_ASSC (
      SP_PURPOSE_ASSOC_ID INTEGER NOT NULL,
      PURPOSE_CATEGORY_ID INTEGER NOT NULL,
      UNIQUE KEY (SP_PURPOSE_ASSOC_ID, PURPOSE_CATEGORY_ID)
    );

    CREATE TABLE CM_PURPOSE_PII_CAT_ASSOC (
      PURPOSE_ID         INTEGER NOT NULL,
      CM_PII_CATEGORY_ID INTEGER NOT NULL,
      IS_MANDATORY       INTEGER NOT NULL,
      UNIQUE KEY (PURPOSE_ID, CM_PII_CATEGORY_ID)
    );

    CREATE TABLE CM_SP_PURPOSE_PII_CAT_ASSOC (
      SP_PURPOSE_ASSOC_ID INTEGER NOT NULL,
      PII_CATEGORY_ID     INTEGER NOT NULL,
      VALIDITY            VARCHAR(1023),
      UNIQUE KEY (SP_PURPOSE_ASSOC_ID, PII_CATEGORY_ID)
    );

    CREATE TABLE CM_CONSENT_RECEIPT_PROPERTY (
      CONSENT_RECEIPT_ID VARCHAR(255)  NOT NULL,
      NAME               VARCHAR(255)  NOT NULL,
      VALUE              VARCHAR(1023) NOT NULL,
      UNIQUE KEY (CONSENT_RECEIPT_ID, NAME)
    );

    ALTER TABLE CM_RECEIPT_SP_ASSOC
      ADD CONSTRAINT CM_RECEIPT_SP_ASSOC_fk0 FOREIGN KEY (CONSENT_RECEIPT_ID) REFERENCES CM_RECEIPT (CONSENT_RECEIPT_ID);

    ALTER TABLE CM_SP_PURPOSE_ASSOC
      ADD CONSTRAINT CM_SP_PURPOSE_ASSOC_fk0 FOREIGN KEY (RECEIPT_SP_ASSOC) REFERENCES CM_RECEIPT_SP_ASSOC (ID);

    ALTER TABLE CM_SP_PURPOSE_ASSOC
      ADD CONSTRAINT CM_SP_PURPOSE_ASSOC_fk1 FOREIGN KEY (PURPOSE_ID) REFERENCES CM_PURPOSE (ID);

    ALTER TABLE CM_SP_PURPOSE_PURPOSE_CAT_ASSC
      ADD CONSTRAINT CM_SP_P_P_CAT_ASSOC_fk0 FOREIGN KEY (SP_PURPOSE_ASSOC_ID) REFERENCES CM_SP_PURPOSE_ASSOC (ID);

    ALTER TABLE CM_SP_PURPOSE_PURPOSE_CAT_ASSC
      ADD CONSTRAINT CM_SP_P_P_CAT_ASSOC_fk1 FOREIGN KEY (PURPOSE_CATEGORY_ID) REFERENCES CM_PURPOSE_CATEGORY (ID);

    ALTER TABLE CM_SP_PURPOSE_PII_CAT_ASSOC
      ADD CONSTRAINT CM_SP_P_PII_CAT_ASSOC_fk0 FOREIGN KEY (SP_PURPOSE_ASSOC_ID) REFERENCES CM_SP_PURPOSE_ASSOC (ID);

    ALTER TABLE CM_SP_PURPOSE_PII_CAT_ASSOC
      ADD CONSTRAINT CM_SP_P_PII_CAT_ASSOC_fk1 FOREIGN KEY (PII_CATEGORY_ID) REFERENCES CM_PII_CATEGORY (ID);

    ALTER TABLE CM_CONSENT_RECEIPT_PROPERTY
      ADD CONSTRAINT CM_CONSENT_RECEIPT_PRT_fk0 FOREIGN KEY (CONSENT_RECEIPT_ID) REFERENCES CM_RECEIPT (CONSENT_RECEIPT_ID);

    INSERT INTO CM_PURPOSE (NAME, DESCRIPTION, PURPOSE_GROUP, GROUP_TYPE, TENANT_ID) VALUES ('DEFAULT', 'For core functionalities of the product', 'DEFAULT', 'SP', '-1234');

    INSERT INTO CM_PURPOSE_CATEGORY (NAME, DESCRIPTION, TENANT_ID) VALUES ('DEFAULT','For core functionalities of the product', '-1234');
    -- End of CONSENT-MGT Tables --

    -- Start of API-MGT Tables --
    CREATE TABLE IF NOT EXISTS AM_SUBSCRIBER (
        SUBSCRIBER_ID INTEGER AUTO_INCREMENT,
        USER_ID VARCHAR(255) NOT NULL,
        TENANT_ID INTEGER NOT NULL,
        EMAIL_ADDRESS VARCHAR(256) NULL,
        DATE_SUBSCRIBED TIMESTAMP NOT NULL,
        PRIMARY KEY (SUBSCRIBER_ID),
        CREATED_BY VARCHAR(100),
        CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UPDATED_BY VARCHAR(100),
        UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (TENANT_ID,USER_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_APPLICATION (
        APPLICATION_ID INTEGER AUTO_INCREMENT,
        NAME VARCHAR(100),
        SUBSCRIBER_ID INTEGER,
        APPLICATION_TIER VARCHAR(50) DEFAULT 'Unlimited',
        CALLBACK_URL VARCHAR(512),
        DESCRIPTION VARCHAR(512),
        APPLICATION_STATUS VARCHAR(50) DEFAULT 'APPROVED',
        GROUP_ID VARCHAR(100),
        CREATED_BY VARCHAR(100),
        CREATED_TIME TIMESTAMP,
        UPDATED_BY VARCHAR(100),
        UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UUID VARCHAR(256),
        TOKEN_TYPE VARCHAR(10),
        FOREIGN KEY(SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY(APPLICATION_ID),
        UNIQUE (NAME,SUBSCRIBER_ID),
        UNIQUE (UUID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API (
        API_ID INTEGER AUTO_INCREMENT,
        API_PROVIDER VARCHAR(200),
        API_NAME VARCHAR(200),
        API_VERSION VARCHAR(30),
        CONTEXT VARCHAR(256),
        CONTEXT_TEMPLATE VARCHAR(256),
        API_TIER VARCHAR(256),
        API_TYPE VARCHAR(10),
        CREATED_BY VARCHAR(100),
        CREATED_TIME TIMESTAMP,
        UPDATED_BY VARCHAR(100),
        UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(API_ID),
        UNIQUE (API_PROVIDER,API_NAME,API_VERSION)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_URL_MAPPING (
        URL_MAPPING_ID INTEGER AUTO_INCREMENT,
        API_ID INTEGER NOT NULL,
        HTTP_METHOD VARCHAR(20) NULL,
        AUTH_SCHEME VARCHAR(50) NULL,
        URL_PATTERN VARCHAR(512) NULL,
        THROTTLING_TIER varchar(512) DEFAULT NULL,
        MEDIATION_SCRIPT BLOB,
        PRIMARY KEY (URL_MAPPING_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_PRODUCT_MAPPING (
    	API_PRODUCT_MAPPING_ID INTEGER AUTO_INCREMENT,
    	API_ID INTEGER,
    	URL_MAPPING_ID INTEGER,
    	FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
    	FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
    	PRIMARY KEY(API_PRODUCT_MAPPING_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_SUBSCRIPTION (
        SUBSCRIPTION_ID INTEGER AUTO_INCREMENT,
        TIER_ID VARCHAR(50),
        API_ID INTEGER,
        LAST_ACCESSED TIMESTAMP NULL,
        APPLICATION_ID INTEGER,
        SUB_STATUS VARCHAR(50),
        SUBS_CREATE_STATE VARCHAR(50) DEFAULT 'SUBSCRIBE',
        CREATED_BY VARCHAR(100),
        CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UPDATED_BY VARCHAR(100),
        UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UUID VARCHAR(256),
        FOREIGN KEY(APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY (SUBSCRIPTION_ID),
        UNIQUE (UUID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_SUBSCRIPTION_KEY_MAPPING (
        SUBSCRIPTION_ID INTEGER,
        ACCESS_TOKEN VARCHAR(512),
        KEY_TYPE VARCHAR(512) NOT NULL,
        FOREIGN KEY(SUBSCRIPTION_ID) REFERENCES AM_SUBSCRIPTION(SUBSCRIPTION_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY(SUBSCRIPTION_ID,ACCESS_TOKEN)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_APPLICATION_KEY_MAPPING (
        APPLICATION_ID INTEGER,
        CONSUMER_KEY VARCHAR(255),
        KEY_TYPE VARCHAR(512) NOT NULL,
        STATE VARCHAR(30) NOT NULL,
        CREATE_MODE VARCHAR(30) DEFAULT 'CREATED',
        FOREIGN KEY(APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY(APPLICATION_ID,KEY_TYPE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_LC_EVENT (
        EVENT_ID INTEGER AUTO_INCREMENT,
        API_ID INTEGER NOT NULL,
        PREVIOUS_STATE VARCHAR(50),
        NEW_STATE VARCHAR(50) NOT NULL,
        USER_ID VARCHAR(255) NOT NULL,
        TENANT_ID INTEGER NOT NULL,
        EVENT_DATE TIMESTAMP NOT NULL,
        FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY (EVENT_ID)
    )ENGINE INNODB;

    CREATE TABLE AM_APP_KEY_DOMAIN_MAPPING (
        CONSUMER_KEY VARCHAR(255),
        AUTHZ_DOMAIN VARCHAR(255) DEFAULT 'ALL',
        PRIMARY KEY (CONSUMER_KEY,AUTHZ_DOMAIN)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_COMMENTS (
        COMMENT_ID VARCHAR(255) NOT NULL,
        COMMENT_TEXT VARCHAR(512),
        COMMENTED_USER VARCHAR(255),
        DATE_COMMENTED TIMESTAMP NOT NULL,
        API_ID INTEGER,
        FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY (COMMENT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_RATINGS (
        RATING_ID VARCHAR(255) NOT NULL,
        API_ID INTEGER,
        RATING INTEGER,
        SUBSCRIBER_ID INTEGER,
        FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        FOREIGN KEY(SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (RATING_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_TIER_PERMISSIONS (
        TIER_PERMISSIONS_ID INTEGER AUTO_INCREMENT,
        TIER VARCHAR(50) NOT NULL,
        PERMISSIONS_TYPE VARCHAR(50) NOT NULL,
        ROLES VARCHAR(512) NOT NULL,
        TENANT_ID INTEGER NOT NULL,
        PRIMARY KEY(TIER_PERMISSIONS_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_EXTERNAL_STORES (
        APISTORE_ID INTEGER AUTO_INCREMENT,
        API_ID INTEGER,
        STORE_ID VARCHAR(255) NOT NULL,
        STORE_DISPLAY_NAME VARCHAR(255) NOT NULL,
        STORE_ENDPOINT VARCHAR(255) NOT NULL,
        STORE_TYPE VARCHAR(255) NOT NULL,
        LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (APISTORE_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_WORKFLOWS(
        WF_ID INTEGER AUTO_INCREMENT,
        WF_REFERENCE VARCHAR(255) NOT NULL,
        WF_TYPE VARCHAR(255) NOT NULL,
        WF_STATUS VARCHAR(255) NOT NULL,
        WF_CREATED_TIME TIMESTAMP,
        WF_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
        WF_STATUS_DESC VARCHAR(1000),
        TENANT_ID INTEGER,
        TENANT_DOMAIN VARCHAR(255),
        WF_EXTERNAL_REFERENCE VARCHAR(255) NOT NULL,
        PRIMARY KEY (WF_ID),
        UNIQUE (WF_EXTERNAL_REFERENCE)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_APPLICATION_REGISTRATION (
        REG_ID INT AUTO_INCREMENT,
        SUBSCRIBER_ID INT,
        WF_REF VARCHAR(255) NOT NULL,
        APP_ID INT,
        TOKEN_TYPE VARCHAR(30),
        TOKEN_SCOPE VARCHAR(1500) DEFAULT 'default',
        INPUTS VARCHAR(1000),
        ALLOWED_DOMAINS VARCHAR(256),
        VALIDITY_PERIOD BIGINT,
        UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE),
        FOREIGN KEY(SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        FOREIGN KEY(APP_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
        PRIMARY KEY (REG_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_SCOPES (
       API_ID  INTEGER NOT NULL,
       SCOPE_ID  INTEGER NOT NULL,
       FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY (SCOPE_ID) REFERENCES IDN_OAUTH2_SCOPE (SCOPE_ID) ON DELETE CASCADE ON UPDATE CASCADE,
       PRIMARY KEY (API_ID, SCOPE_ID)
    )ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS AM_API_DEFAULT_VERSION (
                DEFAULT_VERSION_ID INT AUTO_INCREMENT,
                API_NAME VARCHAR(256) NOT NULL ,
                API_PROVIDER VARCHAR(256) NOT NULL ,
                DEFAULT_API_VERSION VARCHAR(30) ,
                PUBLISHED_DEFAULT_API_VERSION VARCHAR(30) ,
                PRIMARY KEY (DEFAULT_VERSION_ID)
    )ENGINE = INNODB;

    CREATE INDEX IDX_SUB_APP_ID ON AM_SUBSCRIPTION (APPLICATION_ID, SUBSCRIPTION_ID);

    CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE (
    	ID VARCHAR(100) NOT NULL,
    	STATE VARCHAR(50) NOT NULL,
    	STATUS VARCHAR(50) NOT NULL,
    	STARTED_TIME VARCHAR(50) NOT NULL,
    	PUBLISHED_TIME VARCHAR(50) NOT NULL,
    	PRIMARY KEY(ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
                ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
    	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                PRIMARY KEY (ALERT_TYPE_ID)
    )ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES_VALUES (
                ALERT_TYPE_ID INTEGER,
                USER_NAME VARCHAR(255) NOT NULL ,
    	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                PRIMARY KEY (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
    )ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS AM_ALERT_EMAILLIST (
    	    EMAIL_LIST_ID INTEGER AUTO_INCREMENT,
                USER_NAME VARCHAR(255) NOT NULL ,
    	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                PRIMARY KEY (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER)
    )ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS  AM_ALERT_EMAILLIST_DETAILS (
                EMAIL_LIST_ID INTEGER,
    	    EMAIL VARCHAR(255),
                PRIMARY KEY (EMAIL_LIST_ID,EMAIL)
    )ENGINE = INNODB;

    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber');
    INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher');



    -- AM Throttling tables --

    CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(512) NOT NULL,
                DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                TENANT_ID INT(11) NOT NULL,
                DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                QUOTA_TYPE VARCHAR(25) NOT NULL,
                QUOTA INT(11) NOT NULL,
                QUOTA_UNIT VARCHAR(10) NULL,
                UNIT_TIME INT(11) NOT NULL,
                TIME_UNIT VARCHAR(25) NOT NULL,
                RATE_LIMIT_COUNT INT(11) NULL DEFAULT NULL,
                RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
    	    CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
                STOP_ON_QUOTA_REACH BOOLEAN NOT NULL DEFAULT 0,
                BILLING_PLAN VARCHAR(20) NOT NULL,
                UUID VARCHAR(256),
                MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
                FIXED_RATE VARCHAR(15) NULL DEFAULT NULL,
                BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL,
                PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL,
                CURRENCY VARCHAR(15) NULL DEFAULT NULL,
                PRIMARY KEY (POLICY_ID),
                UNIQUE INDEX AM_POLICY_SUBSCRIPTION_NAME_TENANT (NAME, TENANT_ID),
                UNIQUE (UUID)
    )ENGINE = InnoDB;

    CREATE TABLE IF NOT EXISTS AM_POLICY_APPLICATION (
                POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(512) NOT NULL,
                DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                TENANT_ID INT(11) NOT NULL,
                DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                QUOTA_TYPE VARCHAR(25) NOT NULL,
                QUOTA INT(11) NOT NULL,
                QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                UNIT_TIME INT(11) NOT NULL,
                TIME_UNIT VARCHAR(25) NOT NULL,
                IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
    	    CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
    	          UUID VARCHAR(256),
                PRIMARY KEY (POLICY_ID),
                UNIQUE INDEX APP_NAME_TENANT (NAME, TENANT_ID),
                UNIQUE (UUID)
    )ENGINE = InnoDB;

    CREATE TABLE IF NOT EXISTS AM_POLICY_HARD_THROTTLING (
                POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(512) NOT NULL,
                TENANT_ID INT(11) NOT NULL,
                DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                QUOTA_TYPE VARCHAR(25) NOT NULL,
                QUOTA INT(11) NOT NULL,
                QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                UNIT_TIME INT(11) NOT NULL,
                TIME_UNIT VARCHAR(25) NOT NULL,
                IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                PRIMARY KEY (POLICY_ID),
                UNIQUE INDEX POLICY_HARD_NAME_TENANT (NAME, TENANT_ID)
    )ENGINE = InnoDB;


    CREATE TABLE IF NOT EXISTS AM_API_THROTTLE_POLICY (
                POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(512) NOT NULL,
                DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                TENANT_ID INT(11) NOT NULL,
                DESCRIPTION VARCHAR (1024),
                DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                DEFAULT_QUOTA INTEGER NOT NULL,
                DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                DEFAULT_UNIT_TIME INTEGER NOT NULL,
                DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                UUID VARCHAR(256),
                PRIMARY KEY (POLICY_ID),
                UNIQUE INDEX API_NAME_TENANT (NAME, TENANT_ID),
                UNIQUE (UUID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_CONDITION_GROUP (
                CONDITION_GROUP_ID INTEGER NOT NULL AUTO_INCREMENT,
                POLICY_ID INTEGER NOT NULL,
                QUOTA_TYPE VARCHAR(25),
                QUOTA INTEGER NOT NULL,
                QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                UNIT_TIME INTEGER NOT NULL,
                TIME_UNIT VARCHAR(25) NOT NULL,
                DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                PRIMARY KEY (CONDITION_GROUP_ID),
                FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE ON UPDATE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_QUERY_PARAMETER_CONDITION (
                QUERY_PARAMETER_ID INTEGER NOT NULL AUTO_INCREMENT,
                CONDITION_GROUP_ID INTEGER NOT NULL,
                PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
    	    	IS_PARAM_MAPPING BOOLEAN DEFAULT 1,
                PRIMARY KEY (QUERY_PARAMETER_ID),
                FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_HEADER_FIELD_CONDITION (
                HEADER_FIELD_ID INTEGER NOT NULL AUTO_INCREMENT,
                CONDITION_GROUP_ID INTEGER NOT NULL,
                HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
    	    	IS_HEADER_FIELD_MAPPING BOOLEAN DEFAULT 1,
                PRIMARY KEY (HEADER_FIELD_ID),
                FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_JWT_CLAIM_CONDITION (
                JWT_CLAIM_ID INTEGER NOT NULL AUTO_INCREMENT,
                CONDITION_GROUP_ID INTEGER NOT NULL,
                CLAIM_URI VARCHAR(512) DEFAULT NULL,
                CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
    	    IS_CLAIM_MAPPING BOOLEAN DEFAULT 1,
                PRIMARY KEY (JWT_CLAIM_ID),
                FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_IP_CONDITION (
      AM_IP_CONDITION_ID INT NOT NULL AUTO_INCREMENT,
      STARTING_IP VARCHAR(45) NULL,
      ENDING_IP VARCHAR(45) NULL,
      SPECIFIC_IP VARCHAR(45) NULL,
      WITHIN_IP_RANGE BOOLEAN DEFAULT 1,
      CONDITION_GROUP_ID INT NULL,
      PRIMARY KEY (AM_IP_CONDITION_ID),
      INDEX fk_AM_IP_CONDITION_1_idx (CONDITION_GROUP_ID ASC),  CONSTRAINT fk_AM_IP_CONDITION_1    FOREIGN KEY (CONDITION_GROUP_ID)
        REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE ON UPDATE CASCADE)
    ENGINE = InnoDB;


    CREATE TABLE IF NOT EXISTS AM_POLICY_GLOBAL (
                POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                NAME VARCHAR(512) NOT NULL,
                KEY_TEMPLATE VARCHAR(512) NOT NULL,
                TENANT_ID INT(11) NOT NULL,
                DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                SIDDHI_QUERY BLOB DEFAULT NULL,
                IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                UUID VARCHAR(256),
                PRIMARY KEY (POLICY_ID),
                UNIQUE (UUID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_THROTTLE_TIER_PERMISSIONS (
      THROTTLE_TIER_PERMISSIONS_ID INT NOT NULL AUTO_INCREMENT,
      TIER VARCHAR(50) NULL,
      PERMISSIONS_TYPE VARCHAR(50) NULL,
      ROLES VARCHAR(512) NULL,
      TENANT_ID INT(11) NULL,
      PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID))
    ENGINE = InnoDB;

    CREATE TABLE `AM_BLOCK_CONDITIONS` (
      `CONDITION_ID` int(11) NOT NULL AUTO_INCREMENT,
      `TYPE` varchar(45) DEFAULT NULL,
      `VALUE` varchar(512) DEFAULT NULL,
      `ENABLED` varchar(45) DEFAULT NULL,
      `DOMAIN` varchar(45) DEFAULT NULL,
      `UUID` VARCHAR(256),
      PRIMARY KEY (`CONDITION_ID`),
      UNIQUE (`UUID`)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS `AM_CERTIFICATE_METADATA` (
      `TENANT_ID` INT(11) NOT NULL,
      `ALIAS` VARCHAR(45) NOT NULL,
      `END_POINT` VARCHAR(100) NOT NULL,
      CONSTRAINT PK_ALIAS PRIMARY KEY (`ALIAS`)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS `AM_API_CLIENT_CERTIFICATE` (
      `TENANT_ID` INT(11) NOT NULL,
      `ALIAS` VARCHAR(45) NOT NULL,
      `API_ID` INTEGER NOT NULL,
      `CERTIFICATE` BLOB NOT NULL,
      `REMOVED` BOOLEAN NOT NULL DEFAULT 0,
      `TIER_NAME` VARCHAR (512),
      FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
      PRIMARY KEY (`ALIAS`, `TENANT_ID`, `REMOVED`)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_APPLICATION_GROUP_MAPPING (
        APPLICATION_ID INTEGER NOT NULL,
        GROUP_ID VARCHAR(512) NOT NULL,
        TENANT VARCHAR(255),
        PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
        FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
      TENANT_DOMAIN varchar(255) NOT NULL,
      FILE_NAME varchar(255) NOT NULL,
      FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FILE_PROCESSED tinyint(1) DEFAULT FALSE,
      FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
      PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_API_LC_PUBLISH_EVENTS (
        ID INTEGER(11) NOT NULL AUTO_INCREMENT,
        TENANT_DOMAIN VARCHAR(500) NOT NULL,
        API_ID VARCHAR(500) NOT NULL,
        EVENT_TIME TIMESTAMP NOT NULL,
        PRIMARY KEY (ID)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_APPLICATION_ATTRIBUTES (
      APPLICATION_ID int(11) NOT NULL,
      NAME varchar(255) NOT NULL,
      VALUE varchar(1024) NOT NULL,
      TENANT_ID int(11) NOT NULL,
      PRIMARY KEY (APPLICATION_ID,NAME),
      FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_LABELS (
      LABEL_ID VARCHAR(50),
      NAME VARCHAR(255),
      DESCRIPTION VARCHAR(1024),
      TENANT_DOMAIN VARCHAR(255),
      UNIQUE (NAME,TENANT_DOMAIN),
      PRIMARY KEY (LABEL_ID)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_LABEL_URLS (
      LABEL_ID VARCHAR(50),
      ACCESS_URL VARCHAR(255),
      PRIMARY KEY (LABEL_ID,ACCESS_URL),
      FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON UPDATE CASCADE ON DELETE CASCADE
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
        ID INTEGER AUTO_INCREMENT,
        NAME VARCHAR(50) NOT NULL,
        CONSUMER_KEY VARCHAR(512) NOT NULL,
        CONSUMER_SECRET VARCHAR(512) NOT NULL,
        CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (NAME),
        UNIQUE (CONSUMER_KEY),
        PRIMARY KEY (ID)
     ) ENGINE=InnoDB;

    -- BotDATA Email table --
    CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
        UUID VARCHAR(255),
        CATEGORY VARCHAR(255),
        NOTIFICATION_METHOD VARCHAR(255),
        SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
        PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
    ) ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
        UUID VARCHAR(255) NOT NULL,
        SIGNATURE VARCHAR(2048) NOT NULL,
        EXPIRY_TIMESTAMP BIGINT NOT NULL,
        TENANT_ID INTEGER DEFAULT -1,
        TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
        TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (UUID)
    ) ENGINE=InnoDB;
    -- End of API-MGT Tables --

    -- Performance indexes start--

    create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME);
    create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE);
    create index IDX_AAI_CTX on AM_API (CONTEXT);
    create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY);
    create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID);
    create index IDX_AAPM_AI on AM_API_PRODUCT_MAPPING (API_ID);
    create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER);
    create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE);
    create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE);
    create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE);
    create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID);
    create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE);
    create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY);

    -- Performance indexes end--
  mysql_shared.sql: |-
    DROP DATABASE IF EXISTS WSO2AM_SHARED_DB;
    CREATE DATABASE WSO2AM_SHARED_DB;
    GRANT ALL ON WSO2AM_SHARED_DB.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';

    USE WSO2AM_SHARED_DB;

    CREATE TABLE IF NOT EXISTS REG_CLUSTER_LOCK (
                 REG_LOCK_NAME VARCHAR (20),
                 REG_LOCK_STATUS VARCHAR (20),
                 REG_LOCKED_TIME TIMESTAMP,
                 REG_TENANT_ID INTEGER DEFAULT 0,
                 PRIMARY KEY (REG_LOCK_NAME)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_LOG (
                 REG_LOG_ID INTEGER AUTO_INCREMENT,
                 REG_PATH VARCHAR (750),
                 REG_USER_ID VARCHAR (31) NOT NULL,
                 REG_LOGGED_TIME TIMESTAMP NOT NULL,
                 REG_ACTION INTEGER NOT NULL,
                 REG_ACTION_DATA VARCHAR (500),
                 REG_TENANT_ID INTEGER DEFAULT 0,
                 PRIMARY KEY (REG_LOG_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX REG_LOG_IND_BY_REGLOG USING HASH ON REG_LOG(REG_LOGGED_TIME, REG_TENANT_ID);

    -- The REG_PATH_VALUE should be less than 767 bytes, and hence was fixed at 750.
    -- See CARBON-5917.

    CREATE TABLE IF NOT EXISTS REG_PATH(
                 REG_PATH_ID INTEGER NOT NULL AUTO_INCREMENT,
                 REG_PATH_VALUE VARCHAR(750) NOT NULL,
                 REG_PATH_PARENT_ID INTEGER,
                 REG_TENANT_ID INTEGER DEFAULT 0,
                 CONSTRAINT PK_REG_PATH PRIMARY KEY(REG_PATH_ID, REG_TENANT_ID),
                 CONSTRAINT UNIQUE_REG_PATH_TENANT_ID UNIQUE (REG_PATH_VALUE,REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX REG_PATH_IND_BY_PATH_VALUE USING HASH ON REG_PATH(REG_PATH_VALUE, REG_TENANT_ID);
    CREATE INDEX REG_PATH_IND_BY_PATH_PARENT_ID USING HASH ON REG_PATH(REG_PATH_PARENT_ID, REG_TENANT_ID);

    CREATE TABLE IF NOT EXISTS REG_CONTENT (
                 REG_CONTENT_ID INTEGER NOT NULL AUTO_INCREMENT,
                 REG_CONTENT_DATA LONGBLOB,
                 REG_TENANT_ID INTEGER DEFAULT 0,
                 CONSTRAINT PK_REG_CONTENT PRIMARY KEY(REG_CONTENT_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_CONTENT_HISTORY (
                 REG_CONTENT_ID INTEGER NOT NULL,
                 REG_CONTENT_DATA LONGBLOB,
                 REG_DELETED   SMALLINT,
                 REG_TENANT_ID INTEGER DEFAULT 0,
                 CONSTRAINT PK_REG_CONTENT_HISTORY PRIMARY KEY(REG_CONTENT_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_RESOURCE (
                REG_PATH_ID         INTEGER NOT NULL,
                REG_NAME            VARCHAR(256),
                REG_VERSION         INTEGER NOT NULL AUTO_INCREMENT,
                REG_MEDIA_TYPE      VARCHAR(500),
                REG_CREATOR         VARCHAR(31) NOT NULL,
                REG_CREATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                REG_LAST_UPDATOR    VARCHAR(31),
                REG_LAST_UPDATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                REG_DESCRIPTION     VARCHAR(1000),
                REG_CONTENT_ID      INTEGER,
                REG_TENANT_ID INTEGER DEFAULT 0,
                REG_UUID VARCHAR(100) NOT NULL,
                CONSTRAINT PK_REG_RESOURCE PRIMARY KEY(REG_VERSION, REG_TENANT_ID)
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE ADD CONSTRAINT REG_RESOURCE_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE ADD CONSTRAINT REG_RESOURCE_FK_BY_CONTENT_ID FOREIGN KEY (REG_CONTENT_ID, REG_TENANT_ID) REFERENCES REG_CONTENT (REG_CONTENT_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_IND_BY_NAME USING HASH ON REG_RESOURCE(REG_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_IND_BY_PATH_ID_NAME USING HASH ON REG_RESOURCE(REG_PATH_ID, REG_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_IND_BY_UUID USING HASH ON REG_RESOURCE(REG_UUID);
    CREATE INDEX REG_RESOURCE_IND_BY_TENAN USING HASH ON REG_RESOURCE(REG_TENANT_ID, REG_UUID);
    CREATE INDEX REG_RESOURCE_IND_BY_TYPE USING HASH ON REG_RESOURCE(REG_TENANT_ID, REG_MEDIA_TYPE);

    CREATE TABLE IF NOT EXISTS REG_RESOURCE_HISTORY (
                REG_PATH_ID         INTEGER NOT NULL,
                REG_NAME            VARCHAR(256),
                REG_VERSION         INTEGER NOT NULL,
                REG_MEDIA_TYPE      VARCHAR(500),
                REG_CREATOR         VARCHAR(31) NOT NULL,
                REG_CREATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                REG_LAST_UPDATOR    VARCHAR(31),
                REG_LAST_UPDATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                REG_DESCRIPTION     VARCHAR(1000),
                REG_CONTENT_ID      INTEGER,
                REG_DELETED         SMALLINT,
                REG_TENANT_ID INTEGER DEFAULT 0,
                REG_UUID VARCHAR(100) NOT NULL,
                CONSTRAINT PK_REG_RESOURCE_HISTORY PRIMARY KEY(REG_VERSION, REG_TENANT_ID)
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE_HISTORY ADD CONSTRAINT REG_RESOURCE_HIST_FK_BY_PATHID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE_HISTORY ADD CONSTRAINT REG_RESOURCE_HIST_FK_BY_CONTENT_ID FOREIGN KEY (REG_CONTENT_ID, REG_TENANT_ID) REFERENCES REG_CONTENT_HISTORY (REG_CONTENT_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_HISTORY_IND_BY_NAME USING HASH ON REG_RESOURCE_HISTORY(REG_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_HISTORY_IND_BY_PATH_ID_NAME USING HASH ON REG_RESOURCE(REG_PATH_ID, REG_NAME, REG_TENANT_ID);

    CREATE TABLE IF NOT EXISTS REG_COMMENT (
                REG_ID        INTEGER NOT NULL AUTO_INCREMENT,
                REG_COMMENT_TEXT      VARCHAR(500) NOT NULL,
                REG_USER_ID           VARCHAR(31) NOT NULL,
                REG_COMMENTED_TIME    TIMESTAMP NOT NULL,
                REG_TENANT_ID INTEGER DEFAULT 0,
                CONSTRAINT PK_REG_COMMENT PRIMARY KEY(REG_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_RESOURCE_COMMENT (
                REG_COMMENT_ID          INTEGER NOT NULL,
                REG_VERSION             INTEGER,
                REG_PATH_ID             INTEGER,
                REG_RESOURCE_NAME       VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE_COMMENT ADD CONSTRAINT REG_RESOURCE_COMMENT_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE_COMMENT ADD CONSTRAINT REG_RESOURCE_COMMENT_FK_BY_COMMENT_ID FOREIGN KEY (REG_COMMENT_ID, REG_TENANT_ID) REFERENCES REG_COMMENT (REG_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_COMMENT_IND_BY_PATH_ID_AND_RESOURCE_NAME USING HASH ON REG_RESOURCE_COMMENT(REG_PATH_ID, REG_RESOURCE_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_COMMENT_IND_BY_VERSION USING HASH ON REG_RESOURCE_COMMENT(REG_VERSION, REG_TENANT_ID);

    CREATE TABLE IF NOT EXISTS REG_RATING (
                REG_ID     INTEGER NOT NULL AUTO_INCREMENT,
                REG_RATING        INTEGER NOT NULL,
                REG_USER_ID       VARCHAR(31) NOT NULL,
                REG_RATED_TIME    TIMESTAMP NOT NULL,
                REG_TENANT_ID INTEGER DEFAULT 0,
                CONSTRAINT PK_REG_RATING PRIMARY KEY(REG_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_RESOURCE_RATING (
                REG_RATING_ID           INTEGER NOT NULL,
                REG_VERSION             INTEGER,
                REG_PATH_ID             INTEGER,
                REG_RESOURCE_NAME       VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE_RATING ADD CONSTRAINT REG_RESOURCE_RATING_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE_RATING ADD CONSTRAINT REG_RESOURCE_RATING_FK_BY_RATING_ID FOREIGN KEY (REG_RATING_ID, REG_TENANT_ID) REFERENCES REG_RATING (REG_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_RATING_IND_BY_PATH_ID_AND_RESOURCE_NAME USING HASH ON REG_RESOURCE_RATING(REG_PATH_ID, REG_RESOURCE_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_RATING_IND_BY_VERSION USING HASH ON REG_RESOURCE_RATING(REG_VERSION, REG_TENANT_ID);


    CREATE TABLE IF NOT EXISTS REG_TAG (
                REG_ID         INTEGER NOT NULL AUTO_INCREMENT,
                REG_TAG_NAME       VARCHAR(500) NOT NULL,
                REG_USER_ID        VARCHAR(31) NOT NULL,
                REG_TAGGED_TIME    TIMESTAMP NOT NULL,
                REG_TENANT_ID INTEGER DEFAULT 0,
                CONSTRAINT PK_REG_TAG PRIMARY KEY(REG_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_RESOURCE_TAG (
                REG_TAG_ID              INTEGER NOT NULL,
                REG_VERSION             INTEGER,
                REG_PATH_ID             INTEGER,
                REG_RESOURCE_NAME       VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE_TAG ADD CONSTRAINT REG_RESOURCE_TAG_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE_TAG ADD CONSTRAINT REG_RESOURCE_TAG_FK_BY_TAG_ID FOREIGN KEY (REG_TAG_ID, REG_TENANT_ID) REFERENCES REG_TAG (REG_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_TAG_IND_BY_PATH_ID_AND_RESOURCE_NAME USING HASH ON REG_RESOURCE_TAG(REG_PATH_ID, REG_RESOURCE_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_TAG_IND_BY_VERSION USING HASH ON REG_RESOURCE_TAG(REG_VERSION, REG_TENANT_ID);

    CREATE TABLE IF NOT EXISTS REG_PROPERTY (
                REG_ID         INTEGER NOT NULL AUTO_INCREMENT,
                REG_NAME       VARCHAR(100) NOT NULL,
                REG_VALUE        VARCHAR(1000),
                REG_TENANT_ID INTEGER DEFAULT 0,
                CONSTRAINT PK_REG_PROPERTY PRIMARY KEY(REG_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_RESOURCE_PROPERTY (
                REG_PROPERTY_ID         INTEGER NOT NULL,
                REG_VERSION             INTEGER,
                REG_PATH_ID             INTEGER,
                REG_RESOURCE_NAME       VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0
    )ENGINE INNODB;

    ALTER TABLE REG_RESOURCE_PROPERTY ADD CONSTRAINT REG_RESOURCE_PROPERTY_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);
    ALTER TABLE REG_RESOURCE_PROPERTY ADD CONSTRAINT REG_RESOURCE_PROPERTY_FK_BY_TAG_ID FOREIGN KEY (REG_PROPERTY_ID, REG_TENANT_ID) REFERENCES REG_PROPERTY (REG_ID, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_PROPERTY_IND_BY_PATH_ID_AND_RESOURCE_NAME USING HASH ON REG_RESOURCE_PROPERTY(REG_PATH_ID, REG_RESOURCE_NAME, REG_TENANT_ID);
    CREATE INDEX REG_RESOURCE_PROPERTY_IND_BY_VERSION USING HASH ON REG_RESOURCE_PROPERTY(REG_VERSION, REG_TENANT_ID);

    -- CREATE TABLE IF NOT EXISTS REG_ASSOCIATIONS (
    -- SRC_PATH_ID     INTEGER,
    -- SRC_RESOURCE_NAME    VARCHAR(256),
    -- SRC_VERSION     INTEGER,
    -- TGT_PATH_ID     INTEGER,
    -- TGT_RESOURCE_NAME    VARCHAR(256),
    -- TGT_VERSION     INTEGER
    -- )ENGINE INNODB;
    --
    -- ALTER TABLE REG_ASSOCIATIONS ADD CONSTRAINT REG_ASSOCIATIONS_FK_BY_SRC_PATH_ID FOREIGN KEY (SRC_PATH_ID) REFERENCES REG_PATH (PATH_ID);
    -- ALTER TABLE REG_ASSOCIATIONS ADD CONSTRAINT REG_ASSOCIATIONS_FK_BY_TGT_PATH_ID FOREIGN KEY (TGT_PATH_ID) REFERENCES REG_PATH (PATH_ID);
    -- CREATE INDEX REG_ASSOCIATIONS_IND_BY_SRC_VERSION ON REG_ASSOCIATIONS(SRC_VERSION);
    -- CREATE INDEX REG_ASSOCIATIONS_IND_BY_TGT_VERSION ON REG_ASSOCIATIONS(TGT_VERSION);
    -- CREATE INDEX REG_ASSOCIATIONS_IND_BY_SRC_RESOURCE_NAME ON REG_ASSOCIATIONS(SRC_RESOURCE_NAME);
    -- CREATE INDEX REG_ASSOCIATIONS_IND_BY_TGT_RESOURCE_NAME ON REG_ASSOCIATIONS(TGT_RESOURCE_NAME);



    CREATE TABLE IF NOT EXISTS REG_ASSOCIATION (
                REG_ASSOCIATION_ID INTEGER AUTO_INCREMENT,
                REG_SOURCEPATH VARCHAR (750) NOT NULL,
                REG_TARGETPATH VARCHAR (750) NOT NULL,
                REG_ASSOCIATION_TYPE VARCHAR (2000) NOT NULL,
                REG_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY (REG_ASSOCIATION_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS REG_SNAPSHOT (
                REG_SNAPSHOT_ID     INTEGER NOT NULL AUTO_INCREMENT,
                REG_PATH_ID            INTEGER NOT NULL,
                REG_RESOURCE_NAME      VARCHAR(255),
                REG_RESOURCE_VIDS     LONGBLOB NOT NULL,
                REG_TENANT_ID INTEGER DEFAULT 0,
                CONSTRAINT PK_REG_SNAPSHOT PRIMARY KEY(REG_SNAPSHOT_ID, REG_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX REG_SNAPSHOT_IND_BY_PATH_ID_AND_RESOURCE_NAME USING HASH ON REG_SNAPSHOT(REG_PATH_ID, REG_RESOURCE_NAME, REG_TENANT_ID);

    ALTER TABLE REG_SNAPSHOT ADD CONSTRAINT REG_SNAPSHOT_FK_BY_PATH_ID FOREIGN KEY (REG_PATH_ID, REG_TENANT_ID) REFERENCES REG_PATH (REG_PATH_ID, REG_TENANT_ID);


    -- ################################
    -- USER MANAGER TABLES
    -- ################################

    CREATE TABLE UM_TENANT (
    			UM_ID INTEGER NOT NULL AUTO_INCREMENT,
    	        UM_DOMAIN_NAME VARCHAR(255) NOT NULL,
                UM_EMAIL VARCHAR(255),
                UM_ACTIVE BOOLEAN DEFAULT FALSE,
    	        UM_CREATED_DATE TIMESTAMP NOT NULL,
    	        UM_USER_CONFIG LONGBLOB,
    			PRIMARY KEY (UM_ID),
    			UNIQUE(UM_DOMAIN_NAME)
    )ENGINE INNODB;

    CREATE TABLE UM_DOMAIN(
                UM_DOMAIN_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_DOMAIN_NAME VARCHAR(255) NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY (UM_DOMAIN_ID, UM_TENANT_ID),
                UNIQUE(UM_DOMAIN_NAME,UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE UNIQUE INDEX INDEX_UM_TENANT_UM_DOMAIN_NAME
                        ON UM_TENANT (UM_DOMAIN_NAME);

    CREATE TABLE UM_USER (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_USER_NAME VARCHAR(255) NOT NULL,
                 UM_USER_PASSWORD VARCHAR(255) NOT NULL,
                 UM_SALT_VALUE VARCHAR(31),
                 UM_REQUIRE_CHANGE BOOLEAN DEFAULT FALSE,
                 UM_CHANGED_TIME TIMESTAMP NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
                 PRIMARY KEY (UM_ID, UM_TENANT_ID),
                 UNIQUE(UM_USER_NAME, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_SYSTEM_USER (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_USER_NAME VARCHAR(255) NOT NULL,
                 UM_USER_PASSWORD VARCHAR(255) NOT NULL,
                 UM_SALT_VALUE VARCHAR(31),
                 UM_REQUIRE_CHANGE BOOLEAN DEFAULT FALSE,
                 UM_CHANGED_TIME TIMESTAMP NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
                 PRIMARY KEY (UM_ID, UM_TENANT_ID),
                 UNIQUE(UM_USER_NAME, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_ROLE (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_ROLE_NAME VARCHAR(255) NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
    		UM_SHARED_ROLE BOOLEAN DEFAULT FALSE,
                 PRIMARY KEY (UM_ID, UM_TENANT_ID),
                 UNIQUE(UM_ROLE_NAME, UM_TENANT_ID)
    )ENGINE INNODB;


    CREATE TABLE UM_MODULE(
    	UM_ID INTEGER  NOT NULL AUTO_INCREMENT,
    	UM_MODULE_NAME VARCHAR(100),
    	UNIQUE(UM_MODULE_NAME),
    	PRIMARY KEY(UM_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_MODULE_ACTIONS(
    	UM_ACTION VARCHAR(255) NOT NULL,
    	UM_MODULE_ID INTEGER NOT NULL,
    	PRIMARY KEY(UM_ACTION, UM_MODULE_ID),
    	FOREIGN KEY (UM_MODULE_ID) REFERENCES UM_MODULE(UM_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE UM_PERMISSION (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_RESOURCE_ID VARCHAR(255) NOT NULL,
                 UM_ACTION VARCHAR(255) NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
    		UM_MODULE_ID INTEGER DEFAULT 0,
    			       UNIQUE(UM_RESOURCE_ID,UM_ACTION, UM_TENANT_ID),
                 PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX INDEX_UM_PERMISSION_UM_RESOURCE_ID_UM_ACTION ON UM_PERMISSION (UM_RESOURCE_ID, UM_ACTION, UM_TENANT_ID);

    CREATE TABLE UM_ROLE_PERMISSION (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_PERMISSION_ID INTEGER NOT NULL,
                 UM_ROLE_NAME VARCHAR(255) NOT NULL,
                 UM_IS_ALLOWED SMALLINT NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
    	     UM_DOMAIN_ID INTEGER,
                 UNIQUE (UM_PERMISSION_ID, UM_ROLE_NAME, UM_TENANT_ID, UM_DOMAIN_ID),
    	     FOREIGN KEY (UM_PERMISSION_ID, UM_TENANT_ID) REFERENCES UM_PERMISSION(UM_ID, UM_TENANT_ID) ON DELETE CASCADE,
    	     FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID) ON DELETE CASCADE,
                 PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    -- REMOVED UNIQUE (UM_PERMISSION_ID, UM_ROLE_ID)
    CREATE TABLE UM_USER_PERMISSION (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_PERMISSION_ID INTEGER NOT NULL,
                 UM_USER_NAME VARCHAR(255) NOT NULL,
                 UM_IS_ALLOWED SMALLINT NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
                 FOREIGN KEY (UM_PERMISSION_ID, UM_TENANT_ID) REFERENCES UM_PERMISSION(UM_ID, UM_TENANT_ID) ON DELETE CASCADE,
                 PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    -- REMOVED UNIQUE (UM_PERMISSION_ID, UM_USER_ID)
    CREATE TABLE UM_USER_ROLE (
                 UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                 UM_ROLE_ID INTEGER NOT NULL,
                 UM_USER_ID INTEGER NOT NULL,
                 UM_TENANT_ID INTEGER DEFAULT 0,
                 UNIQUE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID),
                 FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_ROLE(UM_ID, UM_TENANT_ID),
                 FOREIGN KEY (UM_USER_ID, UM_TENANT_ID) REFERENCES UM_USER(UM_ID, UM_TENANT_ID),
                 PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_SHARED_USER_ROLE(
        UM_ROLE_ID INTEGER NOT NULL,
        UM_USER_ID INTEGER NOT NULL,
        UM_USER_TENANT_ID INTEGER NOT NULL,
        UM_ROLE_TENANT_ID INTEGER NOT NULL,
        UNIQUE(UM_USER_ID,UM_ROLE_ID,UM_USER_TENANT_ID, UM_ROLE_TENANT_ID),
        FOREIGN KEY(UM_ROLE_ID,UM_ROLE_TENANT_ID) REFERENCES UM_ROLE(UM_ID,UM_TENANT_ID) ON DELETE CASCADE,
        FOREIGN KEY(UM_USER_ID,UM_USER_TENANT_ID) REFERENCES UM_USER(UM_ID,UM_TENANT_ID) ON DELETE CASCADE
    )ENGINE INNODB;

    CREATE TABLE UM_ACCOUNT_MAPPING(
    	UM_ID INTEGER NOT NULL AUTO_INCREMENT,
    	UM_USER_NAME VARCHAR(255) NOT NULL,
    	UM_TENANT_ID INTEGER NOT NULL,
    	UM_USER_STORE_DOMAIN VARCHAR(100),
    	UM_ACC_LINK_ID INTEGER NOT NULL,
    	UNIQUE(UM_USER_NAME, UM_TENANT_ID, UM_USER_STORE_DOMAIN, UM_ACC_LINK_ID),
    	FOREIGN KEY (UM_TENANT_ID) REFERENCES UM_TENANT(UM_ID) ON DELETE CASCADE,
    	PRIMARY KEY (UM_ID)
    )ENGINE INNODB;


    CREATE TABLE UM_USER_ATTRIBUTE (
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_ATTR_NAME VARCHAR(255) NOT NULL,
                UM_ATTR_VALUE VARCHAR(1024),
                UM_PROFILE_ID VARCHAR(255),
                UM_USER_ID INTEGER,
                UM_TENANT_ID INTEGER DEFAULT 0,
                FOREIGN KEY (UM_USER_ID, UM_TENANT_ID) REFERENCES UM_USER(UM_ID, UM_TENANT_ID),
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX UM_USER_ID_INDEX ON UM_USER_ATTRIBUTE(UM_USER_ID);

    CREATE TABLE UM_DIALECT(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_DIALECT_URI VARCHAR(255) NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
                UNIQUE(UM_DIALECT_URI, UM_TENANT_ID),
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_CLAIM(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_DIALECT_ID INTEGER NOT NULL,
                UM_CLAIM_URI VARCHAR(255) NOT NULL,
                UM_DISPLAY_TAG VARCHAR(255),
                UM_DESCRIPTION VARCHAR(255),
                UM_MAPPED_ATTRIBUTE_DOMAIN VARCHAR(255),
                UM_MAPPED_ATTRIBUTE VARCHAR(255),
                UM_REG_EX VARCHAR(255),
                UM_SUPPORTED SMALLINT,
                UM_REQUIRED SMALLINT,
                UM_DISPLAY_ORDER INTEGER,
    	    UM_CHECKED_ATTRIBUTE SMALLINT,
                UM_READ_ONLY SMALLINT,
                UM_TENANT_ID INTEGER DEFAULT 0,
                UNIQUE(UM_DIALECT_ID, UM_CLAIM_URI, UM_TENANT_ID,UM_MAPPED_ATTRIBUTE_DOMAIN),
                FOREIGN KEY(UM_DIALECT_ID, UM_TENANT_ID) REFERENCES UM_DIALECT(UM_ID, UM_TENANT_ID),
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;


    CREATE TABLE UM_PROFILE_CONFIG(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_DIALECT_ID INTEGER NOT NULL,
                UM_PROFILE_NAME VARCHAR(255),
                UM_TENANT_ID INTEGER DEFAULT 0,
                FOREIGN KEY(UM_DIALECT_ID, UM_TENANT_ID) REFERENCES UM_DIALECT(UM_ID, UM_TENANT_ID),
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS UM_CLAIM_BEHAVIOR(
        UM_ID INTEGER NOT NULL AUTO_INCREMENT,
        UM_PROFILE_ID INTEGER,
        UM_CLAIM_ID INTEGER,
        UM_BEHAVIOUR SMALLINT,
        UM_TENANT_ID INTEGER DEFAULT 0,
        FOREIGN KEY(UM_PROFILE_ID, UM_TENANT_ID) REFERENCES UM_PROFILE_CONFIG(UM_ID,UM_TENANT_ID),
        FOREIGN KEY(UM_CLAIM_ID, UM_TENANT_ID) REFERENCES UM_CLAIM(UM_ID,UM_TENANT_ID),
        PRIMARY KEY(UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_HYBRID_ROLE(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_ROLE_NAME VARCHAR(255) NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY (UM_ID, UM_TENANT_ID),
                UNIQUE(UM_ROLE_NAME,UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX UM_ROLE_NAME_IND ON UM_HYBRID_ROLE(UM_ROLE_NAME);

    CREATE TABLE UM_HYBRID_USER_ROLE(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_USER_NAME VARCHAR(255),
                UM_ROLE_ID INTEGER NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
    	    UM_DOMAIN_ID INTEGER,
                UNIQUE (UM_USER_NAME, UM_ROLE_ID, UM_TENANT_ID, UM_DOMAIN_ID),
                FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_HYBRID_ROLE(UM_ID, UM_TENANT_ID) ON DELETE CASCADE,
    	    FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID) ON DELETE CASCADE,
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE TABLE UM_SYSTEM_ROLE(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_ROLE_NAME VARCHAR(255) NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY (UM_ID, UM_TENANT_ID),
                UNIQUE(UM_ROLE_NAME,UM_TENANT_ID)
    )ENGINE INNODB;

    CREATE INDEX SYSTEM_ROLE_IND_BY_RN_TI ON UM_SYSTEM_ROLE(UM_ROLE_NAME, UM_TENANT_ID);

    CREATE TABLE UM_SYSTEM_USER_ROLE(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
                UM_USER_NAME VARCHAR(255),
                UM_ROLE_ID INTEGER NOT NULL,
                UM_TENANT_ID INTEGER DEFAULT 0,
                UNIQUE (UM_USER_NAME, UM_ROLE_ID, UM_TENANT_ID),
                FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_SYSTEM_ROLE(UM_ID, UM_TENANT_ID),
                PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;


    CREATE TABLE UM_HYBRID_REMEMBER_ME(
                UM_ID INTEGER NOT NULL AUTO_INCREMENT,
    			UM_USER_NAME VARCHAR(255) NOT NULL,
    			UM_COOKIE_VALUE VARCHAR(1024),
    			UM_CREATED_TIME TIMESTAMP,
                UM_TENANT_ID INTEGER DEFAULT 0,
    			PRIMARY KEY (UM_ID, UM_TENANT_ID)
    )ENGINE INNODB;
---

apiVersion: v1
kind: Service
metadata:
  name: wso2apim-rdbms-service-mysql
  namespace: wso2
spec:
  type: ClusterIP
  selector:
    deployment: wso2apim-mysql
    product: api-manager
  ports:
    - name: mysql-port
      port: 3306
      targetPort: 3306
      protocol: TCP
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wso2apim-mysql-deployment
  namespace: wso2
spec:
  replicas: 1
  selector:
    matchLabels:
      deployment: wso2apim-mysql
      product: api-manager
  template:
    metadata:
      labels:
        deployment: wso2apim-mysql
        product: api-manager
    spec:
      containers:
        - name: wso2apim-mysql
          image: mysql:5.7
          livenessProbe:
            exec:
              command:
                - sh
                - -c
                - "mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD}"
            initialDelaySeconds: 60
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                - sh
                - -c
                - "mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD}"
            initialDelaySeconds: 60
            periodSeconds: 10
          imagePullPolicy: IfNotPresent
          securityContext:
            runAsUser: 999
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: root
            - name: MYSQL_USER
              value: wso2carbon
            - name: MYSQL_PASSWORD
              value: wso2carbon
          ports:
            - containerPort: 3306
              protocol: TCP
          volumeMounts:
            - name: wso2apim-mysql-dbscripts
              mountPath: /docker-entrypoint-initdb.d
          args: ["--max-connections", "10000"]
      volumes:
        - name: wso2apim-mysql-dbscripts
          configMap:
            name: wso2apim-mysql-dbscripts
      serviceAccountName: "wso2am-pattern-1-svc-account"
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wso2am-pattern-1-am-analytics-dashboard-conf
  namespace: wso2
data:
  deployment.yaml: |-
    # Carbon Configuration Parameters
      wso2.carbon:
        type: wso2-apim-analytics
          # value to uniquely identify a server
        id: wso2-am-analytics
          # server name
        name: WSO2 API Manager Analytics Server
          # enable/disable hostname verifier
        hostnameVerificationEnabled: false
          # ports used by this server
        ports:
            # port offset
          offset: 3

        # Configuration used for the databridge communication
      databridge.config:
          # No of worker threads to consume events
          # THIS IS A MANDATORY FIELD
        workerThreads: 10
          # Maximum amount of messages that can be queued internally in MB
          # THIS IS A MANDATORY FIELD
        maxEventBufferCapacity: 10000000
          # Queue size; the maximum number of events that can be stored in the queue
          # THIS IS A MANDATORY FIELD
        eventBufferSize: 2000
          # Keystore file path
          # THIS IS A MANDATORY FIELD
        keyStoreLocation : ${sys:carbon.home}/resources/security/wso2carbon.jks
          # Keystore password
          # THIS IS A MANDATORY FIELD
        keyStorePassword : wso2carbon
          # Session Timeout value in mins
          # THIS IS A MANDATORY FIELD
        clientTimeoutMin: 30
          # Data receiver configurations
          # THIS IS A MANDATORY FIELD
        dataReceivers:
        -
            # Data receiver configuration
          dataReceiver:
              # Data receiver type
              # THIS IS A MANDATORY FIELD
            type: Thrift
              # Data receiver properties
            properties:
              tcpPort: '7611'
              sslPort: '7711'

        -
            # Data receiver configuration
          dataReceiver:
              # Data receiver type
              # THIS IS A MANDATORY FIELD
            type: Binary
              # Data receiver properties
            properties:
              tcpPort: '9611'
              sslPort: '9711'
              tcpReceiverThreadPoolSize: '100'
              sslReceiverThreadPoolSize: '100'
              hostName: 0.0.0.0

        # Configuration of the Data Agents - to publish events through databridge
      data.agent.config:
          # Data agent configurations
          # THIS IS A MANDATORY FIELD
        agents:
        -
            # Data agent configuration
          agentConfiguration:
              # Data agent name
              # THIS IS A MANDATORY FIELD
            name: Thrift
              # Data endpoint class
              # THIS IS A MANDATORY FIELD
            dataEndpointClass: org.wso2.carbon.databridge.agent.endpoint.thrift.ThriftDataEndpoint
              # Data publisher strategy
            publishingStrategy: async
              # Trust store path
            trustStorePath: '${sys:carbon.home}/resources/security/client-truststore.jks'
              # Trust store password
            trustStorePassword: 'wso2carbon'
              # Queue Size
            queueSize: 32768
              # Batch Size
            batchSize: 200
              # Core pool size
            corePoolSize: 1
              # Socket timeout in milliseconds
            socketTimeoutMS: 30000
              # Maximum pool size
            maxPoolSize: 1
              # Keep alive time in pool
            keepAliveTimeInPool: 20
              # Reconnection interval
            reconnectionInterval: 30
              # Max transport pool size
            maxTransportPoolSize: 250
              # Max idle connections
            maxIdleConnections: 250
              # Eviction time interval
            evictionTimePeriod: 5500
              # Min idle time in pool
            minIdleTimeInPool: 5000
              # Secure max transport pool size
            secureMaxTransportPoolSize: 250
              # Secure max idle connections
            secureMaxIdleConnections: 250
              # secure eviction time period
            secureEvictionTimePeriod: 5500
              # Secure min idle time in pool
            secureMinIdleTimeInPool: 5000
              # SSL enabled protocols
            sslEnabledProtocols: TLSv1.1,TLSv1.2
              # Ciphers
            ciphers: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
        -
            # Data agent configuration
          agentConfiguration:
              # Data agent name
              # THIS IS A MANDATORY FIELD
            name: Binary
              # Data endpoint class
              # THIS IS A MANDATORY FIELD
            dataEndpointClass: org.wso2.carbon.databridge.agent.endpoint.binary.BinaryDataEndpoint
              # Data publisher strategy
            publishingStrategy: async
              # Trust store path
            trustStorePath: '${sys:carbon.home}/resources/security/client-truststore.jks'
              # Trust store password
            trustStorePassword: 'wso2carbon'
              # Queue Size
            queueSize: 32768
              # Batch Size
            batchSize: 200
              # Core pool size
            corePoolSize: 1
              # Socket timeout in milliseconds
            socketTimeoutMS: 30000
              # Maximum pool size
            maxPoolSize: 1
              # Keep alive time in pool
            keepAliveTimeInPool: 20
              # Reconnection interval
            reconnectionInterval: 30
              # Max transport pool size
            maxTransportPoolSize: 250
              # Max idle connections
            maxIdleConnections: 250
              # Eviction time interval
            evictionTimePeriod: 5500
              # Min idle time in pool
            minIdleTimeInPool: 5000
              # Secure max transport pool size
            secureMaxTransportPoolSize: 250
              # Secure max idle connections
            secureMaxIdleConnections: 250
              # secure eviction time period
            secureEvictionTimePeriod: 5500
              # Secure min idle time in pool
            secureMinIdleTimeInPool: 5000
              # SSL enabled protocols
            sslEnabledProtocols: TLSv1.1,TLSv1.2
              # Ciphers
            ciphers: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

        # Deployment configuration parameters
      wso2.artifact.deployment:
          # Scheduler update interval
        updateInterval: 5

        # HA Configuration
      state.persistence:
        enabled: false
        intervalInMin: 1
        revisionsToKeep: 2
        persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
        config:
          location: siddhi-app-persistence

        # Secure Vault Configuration
      wso2.securevault:
        secretRepository:
          type: org.wso2.carbon.secvault.repository.DefaultSecretRepository
          parameters:
            privateKeyAlias: wso2carbon
            keystoreLocation: ${sys:carbon.home}/resources/security/securevault.jks
            secretPropertiesFile: ${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties
        masterKeyReader:
          type: org.wso2.carbon.secvault.reader.DefaultMasterKeyReader
          parameters:
            masterKeyReaderFile: ${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml


      # Data Sources Configuration
      wso2.datasources:
        dataSources:
        # Dashboard data source
        - name: WSO2_DASHBOARD_DB
          description: The datasource used for dashboard feature
          jndiConfig:
            name: jdbc/DASHBOARD_DB
            useJndiReference: true
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/DASHBOARD_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
              username: wso2carbon
              password: wso2carbon
              driverClassName: org.h2.Driver
              maxPoolSize: 20
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false
        - name: BUSINESS_RULES_DB
          description: The datasource used for dashboard feature
          jndiConfig:
            name: jdbc/BUSINESS_RULES_DB
            useJndiReference: true
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_BUSINESS_RULES_DB?useSSL=false'
              username: wso2carbon
              password: wso2carbon
              driverClassName: com.mysql.cj.jdbc.Driver
              maxPoolSize: 20
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false

        # carbon metrics data source
        - name: WSO2_METRICS_DB
          description: The datasource used for dashboard feature
          jndiConfig:
            name: jdbc/WSO2MetricsDB
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
              username: wso2carbon
              password: wso2carbon
              driverClassName: org.h2.Driver
              maxPoolSize: 20
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false

        - name: WSO2_PERMISSIONS_DB
          description: The datasource used for dashboard feature
          jndiConfig:
            name: jdbc/PERMISSION_DB
            useJndiReference: true
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERMISSION_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
              username: wso2carbon
              password: wso2carbon
              driverClassName: org.h2.Driver
              maxPoolSize: 10
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false

        #Data source for APIM Analytics
        - name: APIM_ANALYTICS_DB
          description: Datasource used for APIM Analytics
          jndiConfig:
            name: jdbc/APIM_ANALYTICS_DB
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_STATS_DB?useSSL=false'
              username: wso2carbon
              password: wso2carbon
              driverClassName: com.mysql.cj.jdbc.Driver
              maxPoolSize: 50
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false

         #Main datasource used in API Manager
        - name: AM_DB
          description: Main datasource used by API Manager
          jndiConfig:
            name: jdbc/AM_DB
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_DB?useSSL=false'
              username: wso2carbon
              password: wso2carbon
              driverClassName: com.mysql.cj.jdbc.Driver
              maxPoolSize: 10
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false

      wso2.business.rules.manager:
        datasource: BUSINESS_RULES_DB
        # rule template wise configuration for deploying business rules
        deployment_configs:
          -
           # <IP>:<HTTPS Port> of the Worker node
           localhost:9444:
             # UUIDs of rule templates that are needed to be deployed on the node
             - stock-data-analysis
             - stock-exchange-input
             - stock-exchange-output
             - identifying-continuous-production-decrease
             - popular-tweets-analysis
             - http-analytics-processing
             - message-tracing-source-template
             - message-tracing-app-template
        # credentials for worker nodes
        username: admin
        password: admin

      wso2.transport.http:
        transportProperties:
          - name: "server.bootstrap.socket.timeout"
            value: 60
          - name: "client.bootstrap.socket.timeout"
            value: 60
          - name: "latency.metrics.enabled"
            value: true

        listenerConfigurations:
          - id: "default-https"
            host: "0.0.0.0"
            port: 30643
            scheme: https
            keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
            keyStorePassword: wso2carbon
            certPass: wso2carbon

      ## Dashboard data provider authorization
      data.provider.configs:
        authorizingClass: org.wso2.carbon.dashboards.core.DashboardDataProviderAuthorizer

      ## Additional APIs that needs to be added to the server.
      ## Should be provided as a key value pairs { API context path: Microservice implementation class }
      ## The configured APIs will be available as https://{host}:{port}/analytics-dashboard/{API_context_path}
      additional.apis:
        /apis/analytics/v1.0/apim: org.wso2.analytics.apim.rest.api.proxy.ApimApi

      ## Authentication configuration
      auth.configs:
        type: apim
        ssoEnabled: true
        properties:
          adminScope: apim_analytics:admin_carbon.super
          allScopes: apim_analytics:admin apim_analytics:product_manager apim_analytics:api_developer apim_analytics:app_developer apim_analytics:devops_engineer apim_analytics:analytics_viewer apim_analytics:everyone openid apim:api_view apim:subscribe
          adminServiceBaseUrl: https://"ip.node.k8s.&.wso2.apim":32293
          adminUsername: admin
          adminPassword: admin
          kmDcrUrl: https://"ip.node.k8s.&.wso2.apim":32293/client-registration/v0.15/register
          kmTokenUrlForRedirection: https://"ip.node.k8s.&.wso2.apim":32293/oauth2
          kmTokenUrl: https://"ip.node.k8s.&.wso2.apim":32293/oauth2
          kmUsername: admin
          kmPassword: admin
          portalAppContext: analytics-dashboard
          businessRulesAppContext : business-rules
          cacheTimeout: 900
          baseUrl: https://"ip.node.k8s.&.wso2.apim":30643
          grantType: authorization_code
          publisherUrl: https://"ip.node.k8s.&.wso2.apim":32293
          externalLogoutUrl: https://"ip.node.k8s.&.wso2.apim":32293/oidc/logout
          #storeUrl: https://localhost:9443

      wso2.dashboard:
        roles:
          creators:
            - apim_analytics:admin_carbon.super
---

apiVersion: v1
kind: Service
metadata:
  name: wso2am-pattern-1-analytics-dashboard-service
  namespace: wso2
spec:
  # label keys and values that must match in order to receive traffic for this service
  selector:
    deployment: wso2am-pattern-1-analytics-dashboard
    product: api-manager
  type: NodePort
  ports:
    # ports that this service should serve on
    -
      name: 'ui'
      port: 30643
      protocol: TCP
      targetPort: 30643
      nodePort: 30643
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wso2am-pattern-1-analytics-dashboard-deployment
  namespace: wso2
spec:
  replicas: 1
  minReadySeconds: 75
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  selector:
    matchLabels:
      deployment: wso2am-pattern-1-analytics-dashboard
      product: api-manager
  template:
    metadata:
      labels:
        deployment: wso2am-pattern-1-analytics-dashboard
        product: api-manager
    spec:
      initContainers:
        - name: init-apim-analytics-db
          image: busybox:1.31
          command: ['sh', '-c', 'echo -e "Checking for the availability of MySQL Server deployment"; while ! nc -z wso2apim-rdbms-service-mysql 3306; do sleep 1; printf "-"; done; echo -e "  >> MySQL Server has started";']
      containers:
        - name: wso2am-pattern-1-analytics-dashboard
          image: "$image.pull.@.wso2"/wso2am-analytics-dashboard:3.0.0
          livenessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 30643
            initialDelaySeconds: 100
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 30643
            initialDelaySeconds: 100
            periodSeconds: 10
          lifecycle:
            preStop:
              exec:
                command:  ['sh', '-c', '${WSO2_SERVER_HOME}/bin/dashboard.sh stop']
          resources:
            requests:
              memory: 4Gi
              cpu: 2000m
            limits:
              memory: 4Gi
              cpu: 2000m
          imagePullPolicy: Always
          securityContext:
            runAsUser: 802
          ports:
            -
              containerPort: 30643
              protocol: "TCP"
          volumeMounts:
            - name: wso2am-pattern-1-am-analytics-dashboard-conf
              mountPath: /home/wso2carbon/wso2-config-volume/conf/dashboard/deployment.yaml
              subPath: deployment.yaml
      serviceAccountName: wso2am-pattern-1-svc-account
      imagePullSecrets:
        - name: wso2am-pattern-1-creds
      volumes:
        - name: wso2am-pattern-1-am-analytics-dashboard-conf
          configMap:
            name: wso2am-pattern-1-am-analytics-dashboard-conf
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wso2am-pattern-1-am-analytics-worker-conf
  namespace: wso2
data:
  deployment.yaml: |-
    # Carbon Configuration Parameters
      wso2.carbon:
        type: wso2-apim-analytics
          # value to uniquely identify a server
        id: wso2-am-analytics
          # server name
        name: WSO2 API Manager Analytics Server
          # ports used by this server
        ports:
            # port offset
          offset: 1

      wso2.transport.http:
        transportProperties:
          -
            name: "server.bootstrap.socket.timeout"
            value: 60
          -
            name: "client.bootstrap.socket.timeout"
            value: 60
          -
            name: "latency.metrics.enabled"
            value: true

        listenerConfigurations:
          -
            id: "default"
            host: "0.0.0.0"
            port: 9091
          -
            id: "msf4j-https"
            host: "0.0.0.0"
            port: 9444
            scheme: https
            keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
            keyStorePassword: wso2carbon
            certPass: wso2carbon

        senderConfigurations:
          -
            id: "http-sender"

      siddhi.stores.query.api:
        transportProperties:
          -
            name: "server.bootstrap.socket.timeout"
            value: 60
          -
            name: "client.bootstrap.socket.timeout"
            value: 60
          -
            name: "latency.metrics.enabled"
            value: true

        listenerConfigurations:
          -
            id: "default"
            host: "0.0.0.0"
            port: 7071
          -
            id: "msf4j-https"
            host: "0.0.0.0"
            port: 7444
            scheme: https
            keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
            keyStorePassword: wso2carbon
            certPass: wso2carbon

        # Configuration used for the databridge communication
      databridge.config:
          # No of worker threads to consume events
          # THIS IS A MANDATORY FIELD
        workerThreads: 10
          # Maximum amount of messages that can be queued internally in MB
          # THIS IS A MANDATORY FIELD
        maxEventBufferCapacity: 10000000
          # Queue size; the maximum number of events that can be stored in the queue
          # THIS IS A MANDATORY FIELD
        eventBufferSize: 2000
          # Keystore file path
          # THIS IS A MANDATORY FIELD
        keyStoreLocation : ${sys:carbon.home}/resources/security/wso2carbon.jks
          # Keystore password
          # THIS IS A MANDATORY FIELD
        keyStorePassword : wso2carbon
          # Session Timeout value in mins
          # THIS IS A MANDATORY FIELD
        clientTimeoutMin: 30
          # Data receiver configurations
          # THIS IS A MANDATORY FIELD
        dataReceivers:
        -
            # Data receiver configuration
          dataReceiver:
              # Data receiver type
              # THIS IS A MANDATORY FIELD
            type: Thrift
              # Data receiver properties
            properties:
              tcpPort: '7611'
              sslPort: '7711'

        -
            # Data receiver configuration
          dataReceiver:
              # Data receiver type
              # THIS IS A MANDATORY FIELD
            type: Binary
              # Data receiver properties
            properties:
              tcpPort: '9611'
              sslPort: '9711'
              tcpReceiverThreadPoolSize: '100'
              sslReceiverThreadPoolSize: '100'
              hostName: 0.0.0.0

        # Configuration of the Data Agents - to publish events through databridge
      data.agent.config:
          # Data agent configurations
          # THIS IS A MANDATORY FIELD
        agents:
        -
            # Data agent configuration
          agentConfiguration:
              # Data agent name
              # THIS IS A MANDATORY FIELD
            name: Thrift
              # Data endpoint class
              # THIS IS A MANDATORY FIELD
            dataEndpointClass: org.wso2.carbon.databridge.agent.endpoint.thrift.ThriftDataEndpoint
              # Data publisher strategy
            publishingStrategy: async
              # Trust store path
            trustStorePath: '${sys:carbon.home}/resources/security/client-truststore.jks'
              # Trust store password
            trustStorePassword: 'wso2carbon'
              # Queue Size
            queueSize: 32768
              # Batch Size
            batchSize: 200
              # Core pool size
            corePoolSize: 1
              # Socket timeout in milliseconds
            socketTimeoutMS: 30000
              # Maximum pool size
            maxPoolSize: 1
              # Keep alive time in pool
            keepAliveTimeInPool: 20
              # Reconnection interval
            reconnectionInterval: 30
              # Max transport pool size
            maxTransportPoolSize: 250
              # Max idle connections
            maxIdleConnections: 250
              # Eviction time interval
            evictionTimePeriod: 5500
              # Min idle time in pool
            minIdleTimeInPool: 5000
              # Secure max transport pool size
            secureMaxTransportPoolSize: 250
              # Secure max idle connections
            secureMaxIdleConnections: 250
              # secure eviction time period
            secureEvictionTimePeriod: 5500
              # Secure min idle time in pool
            secureMinIdleTimeInPool: 5000
              # SSL enabled protocols
            sslEnabledProtocols: TLSv1.1,TLSv1.2
              # Ciphers
            ciphers: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
        -
            # Data agent configuration
          agentConfiguration:
              # Data agent name
              # THIS IS A MANDATORY FIELD
            name: Binary
              # Data endpoint class
              # THIS IS A MANDATORY FIELD
            dataEndpointClass: org.wso2.carbon.databridge.agent.endpoint.binary.BinaryDataEndpoint
              # Data publisher strategy
            publishingStrategy: async
              # Trust store path
            trustStorePath: '${sys:carbon.home}/resources/security/client-truststore.jks'
              # Trust store password
            trustStorePassword: 'wso2carbon'
              # Queue Size
            queueSize: 32768
              # Batch Size
            batchSize: 200
              # Core pool size
            corePoolSize: 1
              # Socket timeout in milliseconds
            socketTimeoutMS: 30000
              # Maximum pool size
            maxPoolSize: 1
              # Keep alive time in pool
            keepAliveTimeInPool: 20
              # Reconnection interval
            reconnectionInterval: 30
              # Max transport pool size
            maxTransportPoolSize: 250
              # Max idle connections
            maxIdleConnections: 250
              # Eviction time interval
            evictionTimePeriod: 5500
              # Min idle time in pool
            minIdleTimeInPool: 5000
              # Secure max transport pool size
            secureMaxTransportPoolSize: 250
              # Secure max idle connections
            secureMaxIdleConnections: 250
              # secure eviction time period
            secureEvictionTimePeriod: 5500
              # Secure min idle time in pool
            secureMinIdleTimeInPool: 5000
              # SSL enabled protocols
            sslEnabledProtocols: TLSv1.1,TLSv1.2
              # Ciphers
            ciphers: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

      # This is the main configuration for metrics
      wso2.metrics:
        # Enable Metrics
        enabled: false
        reporting:
          console:
            - # The name for the Console Reporter
              name: Console

              # Enable Console Reporter
              enabled: false

              # Polling Period in seconds.
              # This is the period for polling metrics from the metric registry and printing in the console
              pollingPeriod: 5

      wso2.metrics.jdbc:
        # Data Source Configurations for JDBC Reporters
        dataSource:
          # Default Data Source Configuration
          - &JDBC01
            # JNDI name of the data source to be used by the JDBC Reporter.
            # This data source should be defined in a *-datasources.xml file in conf/datasources directory.
            dataSourceName: java:comp/env/jdbc/WSO2MetricsDB
            # Schedule regular deletion of metrics data older than a set number of days.
            # It is recommended that you enable this job to ensure your metrics tables do not get extremely large.
            # Deleting data older than seven days should be sufficient.
            scheduledCleanup:
              # Enable scheduled cleanup to delete Metrics data in the database.
              enabled: true

              # The scheduled job will cleanup all data older than the specified days
              daysToKeep: 3

              # This is the period for each cleanup operation in seconds.
              scheduledCleanupPeriod: 86400

        # The JDBC Reporter is in the Metrics JDBC Core feature
        reporting:
          # The JDBC Reporter configurations will be ignored if the Metrics JDBC Core feature is not available in runtime
          jdbc:
            - # The name for the JDBC Reporter
              name: JDBC

              # Enable JDBC Reporter
              enabled: true

              # Source of Metrics, which will be used to identify each metric in database -->
              # Commented to use the hostname by default
              # source: Carbon

              # Alias referring to the Data Source configuration
              dataSource: *JDBC01

              # Polling Period in seconds.
              # This is the period for polling metrics from the metric registry and updating the database with the values
              pollingPeriod: 60

        # Deployment configuration parameters
      wso2.artifact.deployment:
          # Scheduler update interval
        updateInterval: 5

        # Periodic Persistence Configuration
      state.persistence:
        enabled: false
        intervalInMin: 1
        revisionsToKeep: 2
        persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
        config:
          location: siddhi-app-persistence

        # Secure Vault Configuration
      wso2.securevault:
        secretRepository:
          type: org.wso2.carbon.secvault.repository.DefaultSecretRepository
          parameters:
            privateKeyAlias: wso2carbon
            keystoreLocation: ${sys:carbon.home}/resources/security/securevault.jks
            secretPropertiesFile: ${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties
        masterKeyReader:
          type: org.wso2.carbon.secvault.reader.DefaultMasterKeyReader
          parameters:
            masterKeyReaderFile: ${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml

        # Datasource Configurations
      wso2.datasources:
        dataSources:
          # carbon metrics data source
          - name: WSO2_METRICS_DB
            description: The datasource used for dashboard feature
            jndiConfig:
              name: jdbc/WSO2MetricsDB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
                username: wso2carbon
                password: wso2carbon
                driverClassName: org.h2.Driver
                maxPoolSize: 30
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false

          - name: WSO2_PERMISSIONS_DB
            description: The datasource used for permission feature
            jndiConfig:
              name: jdbc/PERMISSION_DB
              useJndiReference: true
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_PERMISSIONS_DB?useSSL=false&allowPublicKeyRetrieval=true'
                username: wso2carbon
                password: wso2carbon
                driverClassName: com.mysql.cj.jdbc.Driver
                maxPoolSize: 10
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false

          - name: GEO_LOCATION_DATA
            description: "The data source used for geo location database"
            jndiConfig:
              name: jdbc/GEO_LOCATION_DATA
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/GEO_LOCATION_DATA;AUTO_SERVER=TRUE'
                username: wso2carbon
                password: wso2carbon
                driverClassName: org.h2.Driver
                maxPoolSize: 50
                idleTimeout: 60000
                validationTimeout: 30000
                isAutoCommit: false

          - name: APIM_ANALYTICS_DB
            description: "The datasource used for APIM statistics aggregated data."
            jndiConfig:
              name: jdbc/APIM_ANALYTICS_DB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_STATS_DB?useSSL=false&allowPublicKeyRetrieval=true'
                username: wso2carbon
                password: wso2carbon
                driverClassName: com.mysql.cj.jdbc.Driver
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false

          #Main datasource used in API Manager
          - name: AM_DB
            description: Main datasource used by API Manager
            jndiConfig:
              name: jdbc/AM_DB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_DB?useSSL=false&allowPublicKeyRetrieval=true'
                username: wso2carbon
                password: wso2carbon
                driverClassName: com.mysql.cj.jdbc.Driver
                maxPoolSize: 10
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false

          - name: WSO2AM_MGW_ANALYTICS_DB
            description: "The datasource used for APIM MGW analytics data."
            jndiConfig:
              name: jdbc/WSO2AM_MGW_ANALYTICS_DB
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/WSO2AM_MGW_ANALYTICS_DB;AUTO_SERVER=TRUE'
                username: wso2carbon
                password: wso2carbon
                driverClassName: org.h2.Driver
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false
          -
            name: WSO2_CLUSTER_DB
            description: "The datasource used by cluster coordinators in HA deployment"
            definition:
              type: RDBMS
              configuration:
                connectionTestQuery: "SELECT 1"
                driverClassName: org.h2.Driver
                idleTimeout: 60000
                isAutoCommit: false
                jdbcUrl: "jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/WSO2_CLUSTER_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE"
                maxPoolSize: 10
                password: wso2carbon
                username: wso2carbon
                validationTimeout: 30000

      siddhi:
        refs:
          - ref:
              name: 'grpcSource'
              type: 'grpc'
              properties:
                receiver.url : grpc://localhost:9806/org.wso2.grpc.EventService/consume
        extensions:
          -
            extension:
              name: 'findCountryFromIP'
              namespace: 'geo'
              properties:
                geoLocationResolverClass: org.wso2.extension.siddhi.execution.geo.internal.impl.DefaultDBBasedGeoLocationResolver
                isCacheEnabled: true
                cacheSize: 10000
                isPersistInDatabase: true
                datasource: GEO_LOCATION_DATA
          -
            extension:
              name: 'findCityFromIP'
              namespace: 'geo'
              properties:
                geoLocationResolverClass: org.wso2.extension.siddhi.execution.geo.internal.impl.DefaultDBBasedGeoLocationResolver
                isCacheEnabled: true
                cacheSize: 10000
                isPersistInDatabase: true
                datasource: GEO_LOCATION_DATA
         #Enabling GRPC Service with an Extension
          -
            extension:
              name: 'grpc'
              namespace: 'source'
              properties:
                keyStoreFile : ${sys:carbon.home}/resources/security/wso2carbon.jks
                keyStorePassword : wso2carbon
                keyStoreAlgorithm : SunX509
                trustStoreFile : ${sys:carbon.home}/resources/security/client-truststore.jks
                trustStorePassword : wso2carbon
                trustStoreAlgorithm : SunX509

        # Cluster Configuration
      cluster.config:
        enabled: false
        groupId:  sp
        coordinationStrategyClass: org.wso2.carbon.cluster.coordinator.rdbms.RDBMSCoordinationStrategy
        strategyConfig:
          datasource: WSO2_CLUSTER_DB
          heartbeatInterval: 1000
          heartbeatMaxRetry: 2
          eventPollingInterval: 1000

      # Authentication configuration
      auth.configs:
        type: 'local'        # Type of the IdP client used
        userManager:
          adminRole: admin   # Admin role which is granted all permissions
          userStore:         # User store
            users:
             -
               user:
                 username: admin
                 password: YWRtaW4=
                 roles: 1
            roles:
             -
               role:
                 id: 1
                 displayName: admin

        # Configuration to enable apim alerts
      #analytics.solutions:
      #  APIM-alerts.enabled: true


        # Sample of deployment.config for Two node HA
      #deployment.config:
      #  type: ha
      #  eventSyncServer:
      #    host: localhost
      #    port: 9893
      #    advertisedHost: localhost
      #    advertisedPort: 9893
      #    bossThreads: 10
      #    workerThreads: 10
      #  eventSyncClientPool:
      #    maxActive: 10
      #    maxTotal: 10
      #    maxIdle: 10
      #    maxWait: 60000
      #    minEvictableIdleTimeMillis: 120000

        # Sample of deployment.config for Distributed deployment
      #deployment.config:
      #  type: distributed
      #  httpsInterface:
      #    host: 192.168.1.3
      #    port: 9443
      #    username: admin
      #    password: admin
      #  leaderRetryInterval: 10000
      #  resourceManagers:
      #    - host: 192.168.1.1
      #      port: 9543
      #      username: admin
      #      password: admin
      #    - host: 192.168.1.2
      #      port: 9543
      #      username: admin
      #      password: admin
---

apiVersion: v1
kind: Service
metadata:
  name: wso2am-pattern-1-analytics-worker-service
  namespace: wso2
spec:
  # label keys and values that must match in order to receive traffic for this service
  selector:
    deployment: wso2am-pattern-1-analytics-worker
    product: api-manager
  ports:
    # ports that this service should serve on
    -
      name: 'thrift'
      port: 7612
      protocol: TCP
    -
      name: 'thrift-ssl'
      port: 7712
      protocol: TCP
    -
      name: 'rest-api-port-1'
      protocol: TCP
      port: 9444
    -
      name: 'rest-api-port-2'
      protocol: TCP
      port: 9091
    -
      name: 'rest-api-port-3'
      protocol: TCP
      port: 7071
    -
      name: 'rest-api-port-4'
      protocol: TCP
      port: 7444
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wso2am-pattern-1-analytics-worker-deployment
  namespace: wso2
spec:
  replicas: 1
  minReadySeconds: 75
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  selector:
    matchLabels:
      deployment: wso2am-pattern-1-analytics-worker
      product: api-manager
  template:
    metadata:
      labels:
        deployment: wso2am-pattern-1-analytics-worker
        product: api-manager
    spec:
      initContainers:
        - name: init-apim-analytics-db
          image: busybox:1.31
          command: ['sh', '-c', 'echo -e "Checking for the availability of MySQL Server deployment"; while ! nc -z wso2apim-rdbms-service-mysql 3306; do sleep 1; printf "-"; done; echo -e "  >> MySQL Server has started";']
      containers:
        - name: wso2am-pattern-1-analytics-worker
          image: "$image.pull.@.wso2"/wso2am-analytics-worker:3.0.0
          livenessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 9444
            initialDelaySeconds: 100
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 9444
            initialDelaySeconds: 100
            periodSeconds: 10
          lifecycle:
            preStop:
              exec:
                command:  ['sh', '-c', '${WSO2_SERVER_HOME}/bin/worker.sh stop']
          resources:
            requests:
              memory: 4Gi
              cpu: 2000m
            limits:
              memory: 4Gi
              cpu: 2000m
          imagePullPolicy: Always
          securityContext:
            runAsUser: 802
          ports:
            -
              containerPort: 9764
              protocol: "TCP"
            -
              containerPort: 9444
              protocol: "TCP"
            -
              containerPort: 7612
              protocol: "TCP"
            -
              containerPort: 7712
              protocol: "TCP"
            -
              containerPort: 9091
              protocol: "TCP"
            -
              containerPort: 7071
              protocol: "TCP"
            -
              containerPort: 7444
              protocol: "TCP"
          volumeMounts:
            - name: wso2am-pattern-1-am-analytics-worker-conf
              mountPath: /home/wso2carbon/wso2-config-volume/conf/worker/deployment.yaml
              subPath: deployment.yaml
      serviceAccountName: wso2am-pattern-1-svc-account
      imagePullSecrets:
        - name: wso2am-pattern-1-creds
      volumes:
        - name: wso2am-pattern-1-am-analytics-worker-conf
          configMap:
            name: wso2am-pattern-1-am-analytics-worker-conf
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wso2am-pattern-1-am-1-conf
  namespace: wso2
data:
  deployment.toml: |
    [server]
    hostname = ""ip.node.k8s.&.wso2.apim""
    node_ip = "$env{NODE_IP}"
    offset=22850
    mode = "single" #single or ha
    base_path = "${carbon.protocol}://${carbon.host}:${carbon.management.port}"
    #discard_empty_caches = false
    server_role = "default"

    [super_admin]
    username = "admin"
    password = "admin"
    create_admin_account = true

    [user_store]
    type = "database"

    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_DB?autoReconnect=true&amp;useSSL=false"
    username = "wso2carbon"
    password = "wso2carbon"
    driver = "com.mysql.cj.jdbc.Driver"

    [database.shared_db]
    type = "mysql"
    url = "jdbc:mysql://wso2apim-rdbms-service-mysql:3306/WSO2AM_SHARED_DB?autoReconnect=true&amp;useSSL=false"
    username = "wso2carbon"
    password = "wso2carbon"
    driver = "com.mysql.cj.jdbc.Driver"

    [keystore.tls]
    file_name =  "wso2carbon.jks"
    type =  "JKS"
    password =  "wso2carbon"
    alias =  "wso2carbon"
    key_password =  "wso2carbon"

    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    username= "${admin.username}"
    password= "${admin.password}"
    ws_endpoint = "ws://"ip.node.k8s.&.wso2.apim":9099"
    wss_endpoint = "wss://"ip.node.k8s.&.wso2.apim":8099"
    http_endpoint = "http://"ip.node.k8s.&.wso2.apim":30280"
    https_endpoint = "https://"ip.node.k8s.&.wso2.apim":30243"

    #[apim.cache.gateway_token]
    #enable = true
    #expiry_time = "900s"

    #[apim.cache.resource]
    #enable = true
    #expiry_time = "900s"

    #[apim.cache.km_token]
    #enable = false
    #expiry_time = "15m"

    #[apim.cache.recent_apis]
    #enable = false

    #[apim.cache.scopes]
    #enable = true

    #[apim.cache.publisher_roles]
    #enable = true

    #[apim.cache.jwt_claim]
    #enable = true
    #expiry_time = "15m"

    #[apim.cache.tags]
    #expiry_time = "2m"

    [apim.analytics]
    enable = true
    store_api_url = "https://wso2am-pattern-1-analytics-worker-service:7444"
    #username = "$ref{super_admin.username}"
    #password = "$ref{super_admin.password}"
    #event_publisher_type = "default"
    #event_publisher_type = "custom"
    #event_publisher_impl = "org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageDataBridgeDataPublisher"
    #publish_response_size = true

    [[apim.analytics.url_group]]
    analytics_url =["tcp://wso2am-pattern-1-analytics-worker-service:7612"]
    analytics_auth_url =["ssl://wso2am-pattern-1-analytics-worker-service:7712"]
    #type = "loadbalance"

    #[[apim.analytics.url_group]]
    #analytics_url =["tcp://analytics1:7612","tcp://analytics2:7612"]
    #analytics_auth_url =["ssl://analytics1:7712","ssl://analytics2:7712"]
    #type = "failover"

    #[apim.key_manager]
    #service_url = "https://localhost:${mgt.transport.https.port}/services/"
    #username = "$ref{super_admin.username}"
    #password = "$ref{super_admin.password}"
    #pool.init_idle_capacity = 50
    #pool.max_idle = 100
    #key_validation_handler_type = "default"
    #key_validation_handler_type = "custom"
    #key_validation_handler_impl = "org.wso2.carbon.apimgt.keymgt.handlers.DefaultKeyValidationHandler"

    #[apim.jwt]
    #enable = true
    #encoding = "base64" # base64,base64url
    #generator_impl = "org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"
    #claim_dialect = "http://wso2.org/claims"
    #header = "X-JWT-Assertion"
    #signing_algorithm = "SHA256withRSA"
    #enable_user_claims = true
    #claims_extractor_impl = "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"

    #[apim.oauth_config]
    #enable_outbound_auth_header = false
    #auth_header = "Authorization"
    #revoke_endpoint = "https://localhost:${https.nio.port}/revoke"
    #enable_token_encryption = false
    #enable_token_hashing = false

    [apim.devportal]
    url = "https://"ip.node.k8s.&.wso2.apim":32293/devportal"
    #enable_application_sharing = false
    #if application_sharing_type, application_sharing_impl both defined priority goes to application_sharing_impl
    #application_sharing_type = "default" #changed type, saml, default #todo: check the new config for rest api
    #application_sharing_impl = "org.wso2.carbon.apimgt.impl.SAMLGroupIDExtractorImpl"
    #display_multiple_versions = false
    #display_deprecated_apis = false
    #enable_comments = true
    #enable_ratings = true
    #enable_forum = true

    [apim.cors]
    allow_origins = "*"
    allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
    allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
    allow_credentials = false

    #[apim.throttling]
    #enable_data_publishing = true
    #enable_policy_deploy = true
    #enable_blacklist_condition = true
    #enable_persistence = true
    #throttle_decision_endpoints = ["tcp://localhost:5672","tcp://localhost:5672"]

    #[apim.throttling.blacklist_condition]
    #start_delay = "5m"
    #period = "1h"

    #[apim.throttling.jms]
    #start_delay = "5m"

    #[apim.throttling.event_sync]
    #hostName = "0.0.0.0"
    #port = 11224

    #[apim.throttling.event_management]
    #hostName = "0.0.0.0"
    #port = 10005

    #[[apim.throttling.url_group]]
    #traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
    #traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
    #type = "loadbalance"

    #[[apim.throttling.url_group]]
    #traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
    #traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
    #type = "failover"

    #[apim.workflow]
    #enable = false
    #service_url = "https://localhost:9445/bpmn"
    #username = "$ref{super_admin.username}"
    #password = "$ref{super_admin.password}"
    #callback_endpoint = "https://localhost:${mgt.transport.https.port}/api/am/publisher/v0.15/workflows/update-workflow-status"
    #token_endpoint = "https://localhost:${https.nio.port}/token"
    #client_registration_endpoint = "https://localhost:${mgt.transport.https.port}/client-registration/v0.15/register"
    #client_registration_username = "$ref{super_admin.username}"
    #client_registration_password = "$ref{super_admin.password}"

    #data bridge config
    #[transport.receiver]
    #type = "binary"
    #worker_threads = 10
    #session_timeout = "30m"
    #keystore.file_name = "$ref{keystore.tls.file_name}"
    #keystore.password = "$ref{keystore.tls.password}"
    #tcp_port = 9611
    #ssl_port = 9711
    #ssl_receiver_thread_pool_size = 100
    #tcp_receiver_thread_pool_size = 100
    #ssl_enabled_protocols = ["TLSv1","TLSv1.1","TLSv1.2"]
    #ciphers = ["SSL_RSA_WITH_RC4_128_MD5","SSL_RSA_WITH_RC4_128_SHA"]

    #[apim.notification]
    #from_address = "APIM.com"
    #username = "APIM"
    #password = "APIM+123"
    #hostname = "localhost"
    #port = 3025
    #enable_start_tls = false
    #enable_authentication = true

    #[apim.token.revocation]
    #notifier_impl = "org.wso2.carbon.apimgt.keymgt.events.TokenRevocationNotifierImpl"
    #enable_realtime_notifier = true
    #realtime_notifier.ttl = 5000
    #enable_persistent_notifier = true
    #persistent_notifier.hostname = "https://localhost:2379/v2/keys/jti/"
    #persistent_notifier.ttl = 5000
    #persistent_notifier.username = "root"
    #persistent_notifier.password = "root"

    [[event_handler]]
    name="userPostSelfRegistration"
    subscriptions=["POST_ADD_USER"]

    [service_provider]
    sp_name_regex = "^[\\sa-zA-Z0-9._-]*$"

    #[transport.passthru_https.sender.parameters]
    #HostnameVerifier = "AllowAll"
---

apiVersion: v1
kind: Service
metadata:
  name: wso2am-pattern-1-am-1-service
  namespace: wso2
spec:
  # label keys and values that must match in order to receive traffic for this service
  selector:
    deployment: wso2am-pattern-1-am
    product: api-manager
  type: NodePort
  ports:
    # ports that this service should serve on
    -
      name: pass-through-http
      protocol: TCP
      # for 8280 with a offset of 22850
      port: 31130
      targetPort: 31130
      nodePort: 30280
    -
      name: pass-through-https
      protocol: TCP
      # for 8243 with a offset of 22850
      port: 31093
      targetPort: 31093
      nodePort: 30243
    -
      name: servlet-http
      protocol: TCP
      # for 9763 with a offset of 22850
      port: 32613
      targetPort: 32613
      nodePort: 30763
    -
      name: servlet-https
      protocol: TCP
      # for 9443 with a offset of 22850
      port: 32293
      targetPort: 32293
      nodePort: 32293
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: wso2am-pattern-1-am-1-deployment
  namespace: wso2
spec:
  replicas: 1
  minReadySeconds: 75
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  selector:
    matchLabels:
      deployment: wso2am-pattern-1-am
      product: api-manager
  template:
    metadata:
      labels:
        deployment: wso2am-pattern-1-am
        product: api-manager
    spec:
      hostAliases:
        - ip: "127.0.0.1"
          hostnames:
            - "wso2apim"
      initContainers:
        - name: init-db
          image: busybox:1.31
          command: ['sh', '-c', 'echo -e "Checking for the availability of MySQL Server deployment"; while ! nc -z wso2apim-rdbms-service-mysql 3306; do sleep 1; printf "-"; done; echo -e "  >> MySQL Server has started";']
        - name: init-am-analytics-worker
          image: busybox:1.31
          command: ['sh', '-c', 'echo -e "Checking for the availability of WSO2 API Manager Analytics Worker deployment"; while ! nc -z wso2am-pattern-1-analytics-worker-service 7712; do sleep 1; printf "-"; done; echo -e "  >> WSO2 API Manager Analytics Worker has started";']
      containers:
        - name: wso2am-pattern-1-am
          image: "$image.pull.@.wso2"/wso2am:3.0.0
          livenessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 32293
            initialDelaySeconds: 250
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                - /bin/sh
                - -c
                - nc -z localhost 32293
            initialDelaySeconds: 250
            periodSeconds: 10
          lifecycle:
            preStop:
              exec:
                command:  ['sh', '-c', '${WSO2_SERVER_HOME}/bin/wso2server.sh stop']
          resources:
            requests:
              memory: 2Gi
              cpu: 2000m
            limits:
              memory: 3Gi
              cpu: 3000m
          imagePullPolicy: Always
          ports:
            -
              containerPort: 31130
              protocol: "TCP"
            -
              containerPort: 31093
              protocol: "TCP"
            -
              containerPort: 32613
              protocol: "TCP"
            -
              containerPort: 32293
              protocol: "TCP"
          env:
            - name: HOST_NAME
              value: "wso2apim"
            - name: NODE_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
          volumeMounts:
            - name: wso2am-pattern-1-am-1-conf
              mountPath: /home/wso2carbon/wso2-config-volume/repository/conf/deployment.toml
              subPath: deployment.toml
      serviceAccountName: wso2am-pattern-1-svc-account
      imagePullSecrets:
        - name: wso2am-pattern-1-creds
      volumes:
        - name: wso2am-pattern-1-am-1-conf
          configMap:
            name: wso2am-pattern-1-am-1-conf
---
EOF
}

# bash functions
function usage(){
  echo "Usage: "
  echo -e "-d, --deploy     Deploy WSO2 API Manager"
  echo -e "-u, --undeploy   Undeploy WSO2 API Manager"
  echo -e "-h, --help       Display usage instrusctions"
}
function undeploy(){
  echo "Undeploying WSO2 API Manager ..."
  kubectl delete ns $namespace
  echo "Done."
  exit 0
}
function echoBold () {
    echo -en  $'\e[1m'"${1}"$'\e[0m'
}

function display_msg(){
    msg=$@
    echoBold "${msg}"
    exit 1
}

function viewLicenseText(){

  echo "PLEASE READ THE BELOW \"WSO2 SOFTWARE LICENSE AGREEMENT\" CAREFULLY BEFORE COMPLETING THE INSTALLATION PROCESS AND USING THE SOFTWARE."

  sleep 2s

  less ${license_text}

  while [[ -z ${isAgree} ]]
  do
  read -p "Do you accept license terms ? (Y|n): " isAgree
      if [[ ${isAgree} == Y || ${isAgree} == y ]]; then
          echo "Continuing with installation ..."
      elif [[ ${isAgree} == N || ${isAgree} == n ]]; then
          echo "Installation aborted since you didn't accept the license terms"
          echo "Aborting Installation ..."
          sleep 1s
          exit 0
      else
          echo "Please enter Y or N to continue"
          isAgree=""
      fi
  done

}

function st(){
  cycles=${1}
  i=0
  while [[ i -lt $cycles ]]
  do
    echoBold "* "
    let "i=i+1"
  done
}
function sp(){
  cycles=${1}
  i=0
  while [[ i -lt $cycles ]]
  do
    echoBold " "
    let "i=i+1"
  done
}
function product_name(){
  #wso2apim
  echo -e "\n"
  st 1; sp 8; st 1; sp 2; sp 1; st 3; sp 3; sp 2; st 3; sp 4; sp 1; st 3; sp 3; sp 8; sp 2; st 3; sp 1; sp 3; st 3; sp 3; st 5; sp 2; st 1; sp 8; st 1;
  echo ""
  st 1; sp 8; st 1; sp 2; st 1; sp 4; st 1; sp 2; st 1; sp 6; st 1; sp 2; st 1; sp 4; st 1; sp 2; sp 8; sp 1; st 1; sp 4; st 1; sp 3; st 1; sp 4; st 1; sp 2; sp 3; st 1; sp 6; st 2; sp 4; st 2;
  echo ""
  st 1; sp 3; st 1; sp 3; st 1; sp 2; st 1; sp 8; st 1; sp 6; st 1; sp 2; sp 6; st 1; sp 2; sp 8; st 1; sp 6; st 1; sp 2; st 1; sp 4; st 1; sp 2; sp 3; st 1; sp 6; st 1; sp 1; st 1; sp 2; st 1; sp 1; st 1;
  echo ""
  st 1; sp 2; st 1; st 1; sp 2; st 1; sp 2; sp 1; st 3; sp 3; st 1; sp 6; st 1; sp 2; sp 4; st 1; sp 4; st 3; sp 2; st 5; sp 2; st 3; sp 3; sp 4; st 1; sp 6; st 1; sp 2; st 2; sp 2; st 1;
  echo ""
  st 1; sp 1; st 1; sp 2; st 1; sp 1; st 1; sp 2; sp 6; st 1; sp 2; st 1; sp 6; st 1; sp 2; sp 2; st 1; sp 6; sp 8; st 1; sp 6; st 1; sp 2; st 1; sp  7; sp 4; st 1; sp 6; st 1; sp 3; st 1; sp 3; st 1;
  echo ""
  st 2; sp 4; st 2; sp 2; st 1; sp 4; st 1; sp 2; st 1; sp 6; st 1; sp 2; st 1; sp 8; sp 8; st 1; sp 6; st 1; sp 2; st 1; sp 7; sp 4; st 1; sp 6; st 1; sp 8; st 1;
  echo ""
  st 1; sp 8; st 1; sp 2; sp 1; st 3; sp 3; sp 2; st 3; sp 4; st 4; sp 2; sp 8; st 1; sp 6; st 1; sp 2; st 1; sp 7; st 5; sp 2; st 1; sp 8; st 1;
  echo -e "\n"
}
function get_creds(){
  while [[ -z "$WUMUsername" ]]
  do
        read -p "$(echoBold "Enter your WSO2 subscription username: ")" WUMUsername
        if [[ -z "$WUMUsername" ]]
        then
           echo "wso2-subscription-username cannot be empty"
        fi
  done

  while [[ -z "$WUMPassword" ]]
  do
        read -sp "$(echoBold "Enter your WSO2 subscription password: ")" WUMPassword
        echo ""
        if [[ -z "$WUMPassword" ]]
        then
          echo "wso2-subscription-password cannot be empty"
        fi
  done
}
function validate_ip(){
    ip_check=$1
    if [[ $ip_check =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
      IFS='.'
      ip=$ip_check
      set -- $ip
      if [[ $1 -le 255 ]] && [[ $2 -le 255 ]] && [[ $3 -le 255 ]] && [[ $4 -le 255 ]]; then
        IFS=''
        NODE_IP=$ip_check
      else
        IFS=''
        echo "Invalid IP. Please try again."
        NODE_IP=""
      fi
    else
      echo "Invalid IP. Please try again."
      NODE_IP=""
    fi
}
function get_node_ip(){
  NODE_IP=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}')

  if [[ -z $NODE_IP ]]
  then
      if [[ $(kubectl config current-context)="minikube" ]]
      then
          NODE_IP=$(minikube ip)
      else
        echo "We could not find your cluster node-ip."
        while [[ -z "$NODE_IP" ]]
        do
              read -p "$(echo "Enter one of your cluster Node IPs to provision instant access to server: ")" NODE_IP
              if [[ -z "$NODE_IP" ]]
              then
                echo "cluster node ip cannot be empty"
              else
                validate_ip $NODE_IP
              fi
        done
      fi
  fi
  set -- $NODE_IP; NODE_IP=$1
}

function progress_bar(){

  dep_status=$(kubectl get deployments -n wso2 -o jsonpath='{.items[?(@.spec.selector.matchLabels.product=="api-manager")].status.conditions[?(@.type=="Available")].status}')
  pod_status=$(kubectl get pods -n wso2 -o jsonpath='{.items[?(@.metadata.labels.product=="api-manager")].status.conditions[*].status}')

  num_true_const=0; progress_unit="";num_true=0; time_proc=0;

  arr_dep=($dep_status); arr_pod=($pod_status)

  let "length_total= ${#arr_pod[@]} + ${#arr_dep[@]}";

  echo ""

  while [[ $num_true -lt $length_total ]]
  do

      sleep 4

      num_true=0
      dep_status=$(kubectl get deployments -n wso2 -o jsonpath='{.items[?(@.spec.selector.matchLabels.product=="api-manager")].status.conditions[?(@.type=="Available")].status}')
      pod_status=$(kubectl get pods -n wso2 -o jsonpath='{.items[?(@.metadata.labels.product=="api-manager")].status.conditions[*].status}')

      arr_dep=($dep_status); arr_pod=($pod_status); let "length_total= ${#arr_pod[@]} + ${#arr_dep[@]}";

      for ele_dep in $dep_status
      do
          if [ "$ele_dep" = "True" ]
          then
              let "num_true=num_true+1"
          fi
      done

      for ele_pod in $pod_status
      do
          if [ "$ele_pod" = "True" ]
          then
              let "num_true=num_true+1"
          fi
      done

      printf "Processing WSO2 API Manager ... |"

      printf "%-$((5 * ${length_total-1}))s| $(($num_true_const * 100/ $length_total))"; echo -en ' % \r'

      printf "Processing WSO2 API Manager ... |"
      s=$(printf "%-$((5 * ${num_true_const}))s" "H")
      echo -en "${s// /H}"

      printf "%-$((5 * $(($length_total - $num_true_const))))s| $((100 * $(($num_true_const))/ $length_total))"; echo -en ' %\r '

      if [ $num_true -ne $num_true_const ]
      then
          i=0
          while [[ $i -lt  $((5 * $((${num_true} - ${num_true_const})))) ]]
          do
              let "i=i+1"
              progress_unit=$progress_unit"H"
              printf "Processing WSO2 API Manager ... |"
              echo -n $progress_unit
              printf "%-$((5 * $((${length_total} - ${num_true_const})) - $i))s| $(($(( 100 * $(($num_true_const))/ $length_total)) +  $((20 * $i/$length_total)) ))"; echo -en ' %\r '
              sleep 0.25
          done
          num_true_const=$num_true
          time_proc=0
        else
            let "time_proc=time_proc + 5"
      fi

      printf "Processing WSO2 API Manager ... |"

      printf "%-$((5 * ${length_total-1}))s| $(($num_true_const * 100/ $length_total))"; echo -en ' %\r '

      printf "Processing WSO2 API Manager ... |"
      s=$(printf "%-$((5 * ${num_true_const}))s" "H")
      echo -en "${s// /H}"

      printf "%-$((5 * $(($length_total - $num_true_const))))s| $((100 * $(($num_true_const))/ $length_total))"; echo -en ' %\r '

      sleep 1

      if [[ $time_proc -gt 250 ]]
      then
          echoBold "\n\nSomething went wrong! Please Follow \"https://wso2.com/products/install/faq/#Kubernetes\" for more information\n"
          exit 2
      fi

  done

  echo -e "\n"

}

function deploy(){
    #checking for required command line tools
    if [[ ! $(which kubectl) ]]
    then
       display_msg "Please install Kubernetes command-line tool (kubectl) before you start with the setup\n"
    fi

    if [[ ! $(which base64) ]]
    then
       display_msg "Please install base64 before you start with the setup\n"
    fi

    echoBold "Checking for an enabled cluster... Your patience is appreciated... "
    cluster_isReady=$(kubectl cluster-info) > /dev/null 2>&1  || true

    if [[ ! $cluster_isReady == *"DNS"* ]]
    then
        display_msg "\nPlease enable your cluster before running the setup.\n\nIf you don't have a kubernetes cluster, follow: https://kubernetes.io/docs/setup/\n\n"
    fi

    echoBold "Done\n"

    #displaying wso2 product name
    product_name

    #create and view EULA text
    createLicenseText

    get_creds #get credentials for

    # get node-ip
    get_node_ip

    # create and encode username/password pair
    auth="$WUMUsername:$WUMPassword"
    authb64=`echo -n $auth | base64`

    # create authorisation code
    authstring='{"auths":{"docker.wso2.com":{"username":"'${WUMUsername}'","password":"'${WUMPassword}'","email":"'${WUMUsername}'","auth":"'${authb64}'"}}}'

    # encode in base64
    secdata=`echo -n $authstring | base64`

    for i in $secdata; do
      str_sec=$str_sec$i
    done

    # create kubernetes object yaml
    create_yaml

    # replace necessary variables
    sed -i.bak 's/"k8s.apim.&.auth.wso2"/'$str_sec'/g' $k8s_obj_file
    sed -i.bak 's/"ip.node.k8s.&.wso2.apim"/'$NODE_IP'/g' $k8s_obj_file
    sed -i.bak 's/"$image.pull.@.wso2"/'$IMG_DEST'/g' $k8s_obj_file

    rm deployment.yaml.bak

    echoBold "\nDeploying WSO2 API Manager ....\n"

    # Deploy wso2am
    kubectl create -f $k8s_obj_file

    # waiting until deployment is ready
    progress_bar

    echoBold "Successfully deployed WSO2 API Manager.\n\n"

    echoBold "1. Try navigating to\n\n"
    echoBold "\thttps://$NODE_IP:32293/carbon/\n"
    echoBold "\thttps://$NODE_IP:32293/publisher/\n"
    echoBold "\thttps://$NODE_IP:32293/devportal/\n"
    echoBold "\thttps://$NODE_IP:30643/analytics-dashboard/\n\n"
    echoBold "from your favourite browser using credentials admin/admin\n\n"

    echoBold "2. Follow \"https://apim.docs.wso2.com/en/latest/GettingStarted/quick-start-guide/\" to start using WSO2 API Manager.\n\n"
}
arg=$1
if [[ -z $arg ]]; then
    echoBold "Expected parameter is missing\n"
    usage
else
    case $arg in
      -d|--deploy)
        deploy
        ;;
      -u|--undeploy)
        undeploy
        ;;
      -h|--help)
        usage
        ;;
      *)
        echoBold "Invalid parameter : $arg\n"
        usage
        ;;
    esac
fi
