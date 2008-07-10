From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Thu, 10 Jul 2008 08:00:24 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BDBF07D@dlee02.ent.ti.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com>
	<1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
	<000b01c8e18f$31708610$68bf18ac@ent.ti.com>
	<87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
	<000c01c8e193$9f1f4d50$68bf18ac@ent.ti.com>
	<87tzeztpz3.fsf@trdhcp146196.ntc.nokia.com>
	<001901c8e19f$32f66f80$68bf18ac@ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD675D5@dlee02.ent.ti.com>
	<87iqves1xm.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BDBF028@dlee02.ent.ti.com>
 <87vdzdsxwi.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:52444 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbYGJNAf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2008 09:00:35 -0400
In-Reply-To: <87vdzdsxwi.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

PiA+IFRoZSBjdXJyZW50IGNoZWNrIHdpbGw6IE9uIGFjdGl2aXR5IHJhaXNlIGEgY3B1aWRsZSBi
dXMgbWFzdGVyDQo+ID4gYWN0aXZpdHkgZmFpbHVyZSBmb3Igc29tZSBudW1iZXIgb2Ygc2Vjb25k
cy4gIFRoaXMgYWxsb3dzIG5vcm1hbA0KPiA+IHR5cGluZyBmb3IgZXh0ZW5kZWQgcGVyaW9kcy4g
IEl0IGRvZXMgdGhpcyBieSBtYXJraW5nIFVBUlQgZnVuY3Rpb24NCj4gPiBJUlFzIHdpdGggYSB0
aW1lIHN0YW1wIGFuZCBpdCBjaGVja3MgaW50ZXJuYWwgc3RhdGUgdG8gbWFrZSBzdXJlDQo+ID4g
UlgvVFggZW5naW5lIGlzIG5vdCBidXN5IG9yIGhhcyBxdWV1ZWQgZGF0YSB3YWl0aW5nLg0KPg0K
PiBJc24ndCB0aGlzIGV4YWN0bHkgd2hhdCBpcyBkb25lIGluICJBZGRlZCBzbGVlcCBzdXBwb3J0
IHRvIFVBUlQiIHBhdGNoDQo+IGluIHdvcmthcm91bmQgcGF0Y2ggc2V0Pw0KDQpTZWUgbGFzdCBt
YWlsLiAgSXQgcHJvYmFibHkgaXMuICBJIGFzc3VtZWQgdGhhdCB3YXMgZGVyaXZlZCBmcm9tIG91
ciBjb2RlIHdoaWNoIGhhcyBiZWVuIGF2YWlsYWJsZSBmb3IgYSBsb25nIHRpbWUgYmVmb3JlLiAg
SSBkaWRuJ3QgYWN0dWFsbHkgbG9vayBhdCBpdCB2ZXJ5IGNsb3NlbHkgd2l0aCB0aGF0IGFzc3Vt
cHRpb24uDQoNCj4gPiBUaGlzIGFjdGl2aXR5IGFzc2VydGlvbiB3aWxsIGdhdGUgdGhlIHVzYWdl
IG9mIEMgc3RhdGVzIHdoZXJlIGl0cyBGLQ0KPiBDTE9DSyBpcyBjdXQuICBBdCB0aGUgc2FtZSB0
aW1lIGl0cyBuYXR1cmFsIHdha2UgdXAgZXZlbnRzIGFyZSBlbmFibGVkDQo+IChhbG9uZyB3aXRo
IHRoZSBhYm92ZSBoYWNrIGFzIHRoZSB0eCBldmVudHMgYXJlIG5vdCBjdXJyZW5seSBob29rZWQN
Cj4gaW50byB0aGUgd2FrZXVwIGxvZ2ljKS4NCj4gPg0KPiA+IFdoZW4gT0ZGL1JFVCBtb2RlIGlz
IHNlbGVjdGVkIElPIHBhZCBpcyBlbmFibGVkIGZvciB0aGUgcG9ydCB3YWtldXAuDQo+DQo+IEkg
aGF2ZSBzZWVuIHRoaXMgaW4gQ0RQIHJlZmVyZW5jZSBjb2RlLiBJcyB0aGVyZSBzb21lIHNwZWNp
ZmljIHJlYXNvbg0KPiB3aHkgdGhpcyBpcyBlbmFibGVkIGR5bmFtaWNhbGx5IGluIGNvZGU/DQoN
Ck5vdCB0aGF0IEkgYW0gYXdhcmUuDQoNCkRvIHlvdSB0aGluayB0aGVyZSBpcyBhIG5lZWQgdG8g
dG9nZ2xlIGl0PyAgVG9kYXkgb25seSB0aGUgZ2xvYmFsIElPUEFEIGVuYWJsZSBpcyB0b2dnbGVk
ICh3aGljaCBpcyBuZWNlc3NhcnkgZm9yIHBhZCBzdGF0ZSBsYXRjaGluZykuDQoNClJlZ2FyZHMs
DQpSaWNoYXJkIFcuDQo=
