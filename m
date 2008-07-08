From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Tue, 8 Jul 2008 07:11:27 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BCE28A5@dlee02.ent.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<20080702131127.GA4404@codecarver.research.nokia.com>
	<000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	<20080702154253.GC4404@codecarver.research.nokia.com>
	<004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
	<87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
	<873amqknae.fsf@trdhcp146196.ntc.nokia.com>
	<011601c8ddba$c4031110$68bf18ac@ent.ti.com>
	<1215423520.6048.16.camel@kj-ubuntu>
	<87k5fy2f1r.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930111A74854@dbde02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BCE275B@dlee02.ent.ti.com>
 <8763rg3nqp.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:59965 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487AbYGHMLm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jul 2008 08:11:42 -0400
In-Reply-To: <8763rg3nqp.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

PiA+DQo+ID4gRm9yIHN1cmUgc2F2ZS9yZXN0b3JlIG9mIElSUUVOQUJMRSBpcyBuZWVkZWQuICBP
dXIgTGFicmFkb3IgYm9hcmQNCj4gPiB3aGljaCBoYXMgRXRoZXJuZXQgb24gcGVyLWdwaW8gd291
bGQgc3RvcCB0byBmdW5jdGlvbiBhZnRlciBhbiBPRkYNCj4gPiBtb2RlIHRyYW5zaXRpb24gd2l0
aCBvdXQgdGhpcyBzYXZlIGFuZCByZXN0b3JlICh1c2luZyBDRFAgcmVmZXJlbmNlDQo+ID4gY29k
ZSkuDQo+DQo+IEkgdGhpbmsgdGhpcyBpcyBub3QgcmVsYXRlZCB0byBPRkYgbW9kZSwgYmVjYXVz
ZSBPRkYgc3RhdGUgaXMgbm90DQo+IHVzZWQgb24gdGhlIGJvb3QuIFRoaXMgcHJvYmxlbSBzZWVt
cyB0byBkaXNhcHBlYXIgd2hlbiBib290IGlzDQo+IGRvbmUgYW5kIEM2IHN0YXRlIGlzIHN0YXJ0
ZWQgdG8gYmUgdXNlZC4gQ3VycmVudGx5IGl0IHNlZW1zIHRvIG1lIHRoYXQNCj4gdGhpcyBwcm9i
bGVtIGV4aXN0cyBpZiB1c2luZyBzdGF0ZXMgd2hlcmUgbXB1IGlzIGluIHNsZWVwIHN0YXRlIGFu
ZA0KPiBjb3JlIGlzIGFjdGl2ZSAoQzIsIEMzKS4gVGhpcyBpcyB1bmRlciBpbnZlc3RpZ2F0aW9u
LiBJcyB0aGVyZSBhbnkNCj4ga25vd24gcmVzdHJpY3Rpb25zIGluIEdQSU8xIG1vZHVsZSB3YWtl
LXVwIGNhcGFiaWxpdHkgd2hlbiBtcHUgaXMgaW4NCj4gc2xlZXAgYW5kIGNvcmUgYWN0aXZlPyBB
bnkgb3RoZXIga25vd24gcmVzdHJpY3Rpb25zPw0KDQpJZiBjb3JlIGlzIEFDVElWRSBhbmQgaXJx
IGlzIGVuYWJsZWQgYXQgTVBVIHRoZW4gZXZlcnl0aGluZyBzaG91bGQgd29yayBvbiBhbnkgZ3Bp
byBibG9jay4NCg0KSWYgdGhlIGNvcmUgaXMgSU5BQ1RJVkUgKHdoaWNoIGlzIHBvc3NpYmxlIHdp
dGggaGFyZHdhcmUgYXV0bydzIG9uKSB0aGVuIHRoZSBzYW1lIGhvbGRzIGZyb20gYWJvdmUgSUYg
eW91IGhhdmUgYWxzbyBlbmFibGVkIGFsbCB3YWtldXAgbWVjaGFuaXNtcy4NCg0KSWYgdGhlIGNv
cmUgaXMgaW4gUkVUL09GRiBvbmx5IHNlbGVjdGVkIGdwaW8ncyB3aWxsIHdha2UgdGhlIHN5c3Rl
bSB1cC4gIElJUkMgbm90IGFsbCBHUElPMSBldmVuIGFyZSBjYXBhYmxlIHRvIHdha2UgeW91IGZy
b20gdGhpcyBsZXZlbCBvZiBzbGVlcC4gIEkgZG9uJ3QgcmVjYWxsIHRoZSBsaXN0Lg0KDQpZb3Ug
ZG8gaGF2ZSB0aGUgYWJpbGl0eSB0byB1c2UgYW4gSU8gUEFEIHdha2UgdXAgdG8gd2FrZSBmcm9t
IHRob3NlIHdoaWxlIGluIFJFVC9PRkYuICBIb3dldmVyLCBJIGRvbid0IGJlbGlldmUgeW91IHdp
bGwgZ2V0IGFuIElPIHBhZCB3aGVuIHlvdSBpbiBJTkFDVElWRS9BQ1RJVkUuICBZb3UgZG8gaGF2
ZSB0byBwcm9ncmFtIGZvciB0aGlzIGV2ZW50IHRvIGJlIGdlbmVyYXRlZCBhdCB0aGUgcGFkIGFu
ZCBpbiB0aGUgd2FrZXVwIGRvbWFpbiBjb250cm9sIHJlZ2lzdGVycy4NCg0KUXVlc3Rpb25zIG1p
Z2h0IGJlOg0KICAgICAgICAtIEhhcyB0aGUgcHJjbSBpbml0IGhhcHBlbmVkIGFuZCBpcyB0aGUg
ZW50aXJlIHdha2UgdXAgcGF0aCBiZWVuIHNldHVwPw0KDQogICAgICAgIFt4XSBIYXMgYW55b25l
IGZpeGVkIHRoZSBicm9rZW4gZ3BpbyB3YWtldXAgZW5hYmxlIGNvZGU/ICBSaWdodCBub3cgdGhp
cyBtaWdodCBldmVuIGtpbGwgeW91IGFzIGl0IHdpbGwgY2xlYXIgeW91IHdha2V1cCBlbmFibGUg
cmVnaXN0ZXIuICBUaGlzIGNvdWxkIHN0b3AgeW91IGZyb20gd2FraW5nIGZyb20gYSBwYXJ0aWFs
bHkgaWRsZS9jbG9jayBzdG9wIGNvbmRpdGlvbiBvbiB0aGUgTDM/DQoNClJlZ2FyZHMsDQpSaWNo
YXJkIFcuDQoNCg==
