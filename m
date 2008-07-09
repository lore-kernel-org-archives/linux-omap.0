From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Wed, 9 Jul 2008 11:31:40 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BD67954@dlee02.ent.ti.com>
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
	<13B9B4C6EF24D648824FF11BE8967162035BCE28A5@dlee02.ent.ti.com>
	<87prpoxzm0.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD66B12@dlee02.ent.ti.com>
 <87y74bwo1w.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:48420 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYGIQb4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2008 12:31:56 -0400
In-Reply-To: <87y74bwo1w.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

DQo+ID4gSXQgaXMgbm90IHNvIGNsZWFyIGlmIGdwaW8gdGhhdCBoYWNrIGlzIGV2ZW4gbmVlZGVk
IG9uIE9NQVAzLiAgVGhlcmUNCj4gaXMgc29tZSB3YXJuaW5nIGFib3V0IHNwdXJpb3VzIGludGVy
cnVwdHMgd2hlbiBnb2luZyB0byBSRVQvT0ZGIGZvcg0KPiBPTUFQMi4gSSBkb24ndCByZWNhbGwg
Zm9yIE9NQVAzLiAgZGlkbid0IHRob3NlIHByZXBhcmUgZnVuY3Rpb25zIGRpbmsNCj4gd2l0aCB3
YWtlIHVwIG1hc2tzIGluIGZlYXIgb2Ygc3B1cmlvdXMgaW50ZXJydXB0cy4gIFNvLCB3YXNuJ3Qg
dGhlDQo+IHJlc3VsdCBmb3IgeW91IHRoZSBvcHBvc2l0ZSwgaXQga2VwdCB5b3UgZnJvbSB3YWtp
bmcsIGluc3RlYWQgb2YNCj4gc3VwcHJlc3NpbmcgZXh0cmEgd2FrZXM/DQo+ID4NCj4gPiBEaWQg
eW91IGZpeCB0aGUgT01BUDIgR1BJTyB3YWtldXAgbWFzayBpbiB1c2UgYXQgbGVhc3Q/ICBUaGUg
Y29kZQ0KPiA+IGhhZCBhIGhhcmRjb2RlZCBtYXNrIGJhc2VkIG9uIE9NQVAyIHdha2V1cCBjYXBh
YmxlIGdwaW9zIHdoaWNoIGRvbid0DQo+ID4gYXBwbHkgdG8gb21hcDMuDQo+DQo+IE5vIEkgaGF2
ZW4ndCBtb2RpZmllZCB0aGF0IGNvZGUuIEkgaGF2ZSBiZWd1biB0byB1c2UgaXQgYmVmb3JlDQo+
IHJldGVudGlvbiBiZWNhdXNlIGl0IGlzIHVuZGVyICNpZiBkZWZpbmVkKENPTkZJR19BUkNIX09N
QVAzNFhYKQ0KPiBzdGF0ZW1lbnQgYW5kIHVzZWQgaW4gY2FzZSBvZiBvbWFwMi4gTWF5YmUgd2Ug
Y291bGQgc3RvcCB1c2luZyBpdCBpbg0KPiBjYXNlIG9mIG9tYXAzIGF0IGxlYXN0IHRoaXMgY29t
bWVudCBpbiBncGlvLmMgc3VwcG9ydHMgdGhpczogIlNlZQ0KPiBPTUFQMjQyMCBFcnJhdGEgaXRl
bSAxLjEwMSI/IFNlZW1zIHRvIGJlIGp1c3QgbGVnYWN5IGNvZGUgZnJvbSBvbWFwMi4NCg0KWWVz
LCB0aGF0IHNlY3Rpb24gbmVlZHMgdG8gYmUgcmV3b3JrZWQuICBJdCB3YXMgcHJvYmFibHkgdGhl
IHJvb3QgY2F1c2Ugb2YgeW91ciBmYWlsdXJlLg0KDQpSZWdhcmRzLA0KUmljaGFyZCBXLg0KDQo=
