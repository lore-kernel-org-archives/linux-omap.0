From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Thu, 8 Jul 2010 06:57:36 -0500
Message-ID: <1278590256.3787.14.camel@Nokia-N900>
Reply-To: "Menon, Nishanth" <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50189 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969Ab0GHLz7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 07:55:59 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "ValkeinenTomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

DQotLS0tLSBPcmlnaW5hbCBtZXNzYWdlIC0tLS0tDQo+IEhpLA0KPiANCj4gT24gV2VkLCBKdWwg
MDcsIDIwMTAgYXQgMDc6MjQ6MTZQTSArMDIwMCwgZXh0IE5pc2hhbnRoIE1lbm9uIHdyb3RlOg0K
PiA+IEkgYW0gbm90IHN1cmUuLiBpZiB5b3Ugd291bGQgbGlrZSBkcml2ZXJzIHRvIGJlIG1vZHBy
b2JhYmUsIHRoZXJlIG1heQ0KPiBiZQ0KPiA+IHF1aXJrcyB0aGF0IHlvdSdkIHdhbnQgdG8gZW5h
YmxlIGJhc2VkIG9uIGNwdV9pc19vbWFweHh4IGNoZWNrcy4gc28gaXQNCj4gPiBwcm9iYWJseSBk
b2VzIG5vdCBtYWtlIHNlbnNlIHRvIF9faW5pdGRhdGEgdGhlIHJldmlzaW9uL2ZlYXR1cmUNCj4g
dmFyaWFibGVzLg0KPiANCj4gY2FuJ3QgeW91IHBhc3MgdGhlIHF1aXJrcyB2aWEgcGRhdGEsIHRo
ZW4gPw0KDQpJZiBwZGF0YSBpcyBwYXNzZWQgYmFzZWQgb24gYm9hcmQ6IEltYWdpbmUgMzYzMCBh
bmQgdWFydCBxdWlyay4gV2h5IHNoYXJlIGVycmF0YSB4eXogb3ZlciBwZGF0YSBmb3IgZXZlcnkg
Ym9hcmQgdXNpbmcgMzYzMD8gUXVpcmtzIGFyZSBjcHUgc3BlY2lmaWMgYW5kIG5vdCByZWFsbHkg
ZG9tYWluIG9mIGJvYXJkLi4gIA0KDQpSZWdhcmRzLA0KTmlzaGFudGggTWVub24NCj4gDQo+IC0t
IA0KPiBiYWxiaQ0KPiANCj4gRGVmZWN0aXZlQnlEZXNpZ24ub3JnDQo+IA0K
