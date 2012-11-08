From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 1/3] omap gpmc : add support of setting CYCLE2CYCLEDELAY
 and BUSTURNAROUND
Date: Thu, 8 Nov 2012 12:54:48 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA0ED9E@DBDE01.ent.ti.com>
References: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com>
 <5099478A.50901@ti.com> <5099504A.5060505@parrot.com>
 <5099743B.3040804@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA0E2D6@DBDE01.ent.ti.com>
 <20121107214014.GM6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab2KHMzA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 07:55:00 -0500
In-Reply-To: <20121107214014.GM6801@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Matthieu CASTET <matthieu.castet@parrot.com>, Daniel Mack <zonque@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>

SGkgVG9ueSwNCg0KT24gVGh1LCBOb3YgMDgsIDIwMTIgYXQgMDM6MTA6MTQsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6DQo+ICogTW9oYW1tZWQsIEFmemFsIDxhZnphbEB0aS5jb20+IFsxMjExMDcgMDE6
MDBdOg0KDQo+ID4gQW5kIERhbmllbCBoYXMgc3RhcnRlZCB3b3JraW5nIG9uIGdwbWMgZHQuIExl
dCB1cyB0YWtlIFRvbnkncw0KPiA+IG9waW5pb24gb24gaG93IHRvIGRlYWwgd2l0aCB0aGlzLCBU
b255ID8NCg0KPiBVcCB0byB5b3UgdG8gZmlndXJlIG91dCB0aGUgb3JkZXJpbmcuDQoNCj4gTWF5
YmUgc2VuZCBwdWxsIHJlcXVlc3RzIGZvciB0aGUgb25lcyB0aGF0IGFyZSByZWFkeSB0byBnbz8N
Cg0KUGVuZGluZyB0aW1pbmcgcmVsYXRlZCBwYXRjaGVzLA0KDQphLiBBUk06IE9NQVAyKzogbmFu
ZDogcmVtb3ZlIHJlZHVuZGFudCByb3VuZGluZw0KYi4gQVJNOiBPTUFQMis6IGdwbWM6IGhhbmRs
ZSBhZGRpdGlvbmFsIHRpbWluZ3MNCmMuIEFSTTogT01BUDIrOiBncG1jOiBnZW5lcmljIHRpbWlu
ZyBjYWxjdWxhdGlvbg0KZC4gQVJNOiBPTUFQMis6IG9uZW5hbmQ6IGdlbmVyaWMgdGltaW5nIGNh
bGN1bGF0aW9uDQplLiBBUk06IE9NQVAyKzogc21jOTF4OiBnZW5lcmljIHRpbWluZyBjYWxjdWxh
dGlvbg0KZi4gQVJNOiBPTUFQMis6IHR1c2I2MDEwOiBnZW5lcmljIHRpbWluZyBjYWxjdWxhdGlv
bg0KDQpjYW4gYmUgZGl2aWRlZCB0byB0d28gY2F0ZWdvcmllcywNCg0KMS4gdGltaW5nIGNsZWFu
dXAgKGEsYikNCjIuIG1pZ3JhdGUgdG8gZ2VuZXJpYyB0aW1pbmcgcm91dGluZSAoYy1mKQ0KDQon
MScgaGFzIGJlZW4gdGVzdGVkIG9uIG9tYXAzZXZtIChhbHNvIHdpdGggdGhlIGhlbHAgb2YgYSBs
b2NhbCBwYXRjaA0KYWRkaW5nIG9uZW5hbmQgc3VwcG9ydCkuDQoNCicyJyBoYXMgYmVlbiB2ZXJp
ZmllZCBvbiBvbWFwM2V2bSBvbmVuYW5kIGFzeW5jIG9wZXJhdGlvbiAoc3VwcG9ydCBmb3INCm9t
YXAzZXZtIG9uZW5hbmQgaXMgbm90IHByZXNlbnQgaW4gbWFpbmxpbmUpIGFuZCBieSBzaW11bGF0
aW9uLiBUaGVzZQ0KY2hhbmdlcyBjb3VsZCBub3QgYmUgdmFsaWRhdGVkIG9uIGJvYXJkcyBzdXBw
b3J0ZWQgaW4gbWFpbmxpbmUgdGhhdA0KbWFrZSB1c2Ugb2YgcnVudGltZSB0aW1pbmcgY2FsY3Vs
YXRpb24gYXMgSSBkbyBub3QgaGF2ZSB0aG9zZSBib2FyZHMuDQoNCkkgd2lsbCBiZSBzZW5kaW5n
IHB1bGwgcmVxdWVzdCBjb250YWluaW5nIGJvdGggc2V0cyAxICYgMiwgcGxlYXNlIGxldA0KbWUg
a25vdyBpbiBjYXNlIHlvdSBoYXZlIGEgZGlmZmVyZW50IG9waW5pb24uDQoNClJlZ2FyZHMNCkFm
emFsDQoNCg==
