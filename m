From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Wed, 25 Jun 2008 16:47:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
 <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
 <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37966 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYFYLSn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 07:18:43 -0400
In-Reply-To: <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, Jouni Hogander <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

PiA+IEN1cnJlbnQgb21hcCBoc21tYyBkcml2ZXIgaXMgbm90IHBtIGZyaWVuZGx5LiBCdWlsZCBp
dCBhcyBhIG1vZHVsZQ0KPiA+IGJlY2F1c2UgaXQgcHJldmVudHMgb21hcDMgcmV0ZW50aW9uLg0K
Pg0KPiBTbWFsbCBjb21tZW50Lg0KPg0KPiBBdCBsZWFzdCB0aGlzIHBhdGNoIHNob3VsZG4ndCBi
ZSByZXZlcnRlZCwgdGhlcmUncyBubyByZWFzb24NCj4gZm9yIG5vdCBidWlsZGluZyBkcml2ZXJz
IGFzIG1vZHVsZXMuIEknbGwgZG8gdGhlIHNhbWUNCj4gdG8gbXVzYi4NCg0KQWN0dWFsbHkgdGhl
cmUgaXMuIEl0IHJlYWxseSBkZXBlbmRzIG9uIHdoYXQgeW91IHdhbnQgdG8gZG8gd2l0aCB0aGUg
c3lzdGVtLg0KDQpGb3IgaW5zdGFuY2UsIHRoZSBjYXNlIHdoZXJlIHlvdSBhcmUgcnVubmluZyBh
IHRpZ2h0IGVtYmVkZGVkIHN5c3RlbSB3aXRoIGEgcmFtZGlzayBmaWxlc3lzdGVtIC0gdGhlIG1v
ZHVsZXMgd291bGQgaGF2ZSB0byBzaXQgb24gdGhlIGZpbGVzeXN0ZW0gYW5kIHdvdWxkIG9jY3Vw
eSBwcmVjaW91cyBzcGFjZSB0aGVyZS4gWW91IG1pZ2h0IGJlIGJldHRlciBvZmYgaGF2aW5nIGV2
ZXJ5dGhpbmcgYnVpbHQgaW50byB0aGUga2VybmVsLg0KDQpUaGF0IGJlaW5nIHNhaWQsIGluIG15
IG9waW5pb24gaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIGhhdmUgZXZlcnl0aGluZyBhcyBtb2R1
bGVzIHdpdGggbGl0dGxlIGRpZmZlcmVuY2UgaW4gZnVuY3Rpb25hbGl0eS4gSW4gdGhpcyBjYXNl
IGlmIHRoZSBPTUFQIEhTTU1DIGRyaXZlciBpcyBub3QgUE0tZnJpZW5kbHksIHRoZW4gdGhhdCBz
aG91bGQgYmUgZml4ZWQuIE1ha2luZyBpdCBidWlsZCBhcyBhIG1vZHVsZSBpcyBhdCBiZXN0IGEg
X190ZW1wb3JhcnlfXyBzb2x1dGlvbiBhcyBKb3VuaSBwb2ludHMgb3V0Lg0KDQpUaGUgY2hvaWNl
IG9mIGJ1aWxkaW5nIGRyaXZlcnMgaW50byB0aGUga2VybmVsIG9yIGFzIG1vZHVsZXMgc2hvdWxk
IGJlIGxlZnQgdG8gd2hvZXZlciBidWlsZHMgdGhlIGtlcm5lbC4gVGhlIGRlZmNvbmZpZ3MgbWFr
ZSBsaWZlIGVhc3kgZHVyaW5nIHRlc3RpbmcgYnV0IG90aGVyd2lzZSB0aGVyZSBpcyBsaXR0bGUg
cmVhc29uIHRvIGNoYW5nZSB0aGVtLg0KDQpNeSAkMC4wMiwNCkFuYW5kDQo=
