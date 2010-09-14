From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv2 1/8] OMAP: PM: Allowing an early init of pm debugfs
 driver.
Date: Tue, 14 Sep 2010 20:26:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329441CD4@dbde02.ent.ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	 <1281707231-3026-2-git-send-email-thara@ti.com>
	 <87aaobmzby.fsf@deeprootsystems.com> <1282688503.11841.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab0INO4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:56:20 -0400
In-Reply-To: <1282688503.11841.47.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>

DQoNCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+RnJvbTogS2V2aW4gSGlsbWFuIFtt
YWlsdG86a2hpbG1hbkBkZWVwcm9vdHN5c3RlbXMuY29tXQ0KPj5TZW50OiBXZWRuZXNkYXksIEF1
Z3VzdCAyNSwgMjAxMCAzOjUyIEFNDQo+PlRvOiBHb3BpbmF0aCwgVGhhcmENCj4+Q2M6IGxpbnV4
LW9tYXBAdmdlci5rZXJuZWwub3JnOyBwYXVsQHB3c2FuLmNvbTsgQ291c3NvbiwgQmVub2l0OyBT
cmlwYXRoeSwgVmlzaHdhbmF0aDsgU2F3YW50LCBBbmFuZDsNCj4+RGVycmljaywgRGF2aWQNCj4+
U3ViamVjdDogUmU6IFtQQVRDSHYyIDEvOF0gT01BUDogUE06IEFsbG93aW5nIGFuIGVhcmx5IGlu
aXQgb2YgcG0gZGVidWdmcyBkcml2ZXIuDQo+Pg0KPj5PbiBUdWUsIDIwMTAtMDgtMjQgYXQgMTU6
MTYgLTA3MDAsIEtldmluIEhpbG1hbiB3cm90ZToNCj4+PiBUaGFyYSBHb3BpbmF0aCA8dGhhcmFA
dGkuY29tPiB3cml0ZXM6DQo+Pj4NCj4+PiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgcG1fZGJf
aW5pdCBmcm9tIGFyY2ggaW5pdGNhbGwgdG8gYSBwb3N0Y29yZQ0KPj4+ID4gaW5pdGNhbGwuIFdp
dGggYXJjaCBpbml0Y2FsbCwgaXQgaXMgaW1wb3NzaWJsZSBmb3IgcG0gZHJpdmVyIHRoYXQNCj4+
PiA+IGdldHMgaW5pdGlhbGl6ZWQgcHJpb3IgdG8gdGhpcyBkcml2ZXIgdG8gdXNlIG9uZSBvZiB0
aGUNCj4+PiA+IHBtIGRlYnVnIGZzIGVudHJpZXMgZHVyaW5nIGl0cyBpbml0LiBNYWtpbmcgaXQg
YSBwb3N0Y29yZSBpbml0Y2FsbA0KPj4+ID4gZW5zdXJlcyB0aGF0IHRoaXMgZHJ2ZXIgZ2V0cyBp
bml0aWFsaXplZCBlYXJseSBvbiBiZWZvcmUgYW55IHBtDQo+Pj4gPiBkcml2ZXJzLg0KPj4+DQo+
Pj4gSW5zdGVhZCBvZiB0aW5rZXJpbmcgd2l0aCBpbml0Y2FsbCBvcmRlcmluZywgaG93IGFib3V0
IGNhbGxpbmcgdGhlIHBtDQo+Pj4gZGVidWcgaW5pdCBmcm9tIHBtLmMNCj4+DQo+Pmlnbm9yZSB0
aGlzIGNvbW1lbnQsIHBtLmMgaXMgYSBkZXZpY2VfaW5pdGNhbGwsIHNvIHdvbnQgc29sdmUgeW91
cg0KPj5wcm9ibGVtLg0KPj4NCj4+QnV0IEknZCBzdGlsbCBsaWtlIHRvIGtub3cgd2hhdCBQTSBk
cml2ZXJzIGFyZSBiZWluZyBpbml0aWFsaXplZCBzbw0KPj5lYXJseSB0aGV5IG5lZWQgdGhpcyB0
byBiZSBhIHBvc3Rjb3JlX2luaXRjYWxsLg0KSXQgaXMgbmVlZGVkIGZyb20gdm9sdGFnZSBhbmQg
c21hcnRyZWZsZXggbGF5ZXJzIGZvciBhZGRpbmcgdGhlIGRlYnVnZnMgZW50cmllcy4NCkJ1dCBj
b25zaWRlcmluZyB0aGVzZSBpbml0cyBoYXZlIGJlZW4gbW92ZWQgdG8gZGV2aWNlX2luaXRjYWxs
IG9yIGxhdGVfaW5pdGNhbGwgbWF5IGJlDQpUaGlzIGNoYW5nZSBpcyBubyBsb25nZXIgcmVsZXZh
bnQuIFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4NCg0KUmVnYXJkcw0KVGhhcmENCg0KPj4NCj4+
S2V2aW4NCj4+DQoNCg==
