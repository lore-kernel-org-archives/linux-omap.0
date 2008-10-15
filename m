From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 07:56:15 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365CA783B@dlee02.ent.ti.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com>
 <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
 <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net>
 <20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
 <1224018598.4977.27.camel@localhost> <20081014212409.GL8150@atomide.com>
 <87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
 <alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47714 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbYJOM4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2008 08:56:31 -0400
In-Reply-To: <alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, =?utf-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

PiBSaWNoYXJkIGlzIHJlYWxseSB0aGUgYmVzdCBwZXJzb24gdG8gYXNrIGFib3V0IHRoaXMsIHNv
IGhlJ3MgYmVlbiBhZGRlZA0KPiB0bw0KPiB0aGUgY2MuICBNeSBjdXJyZW50IHVuZGVyc3RhbmRp
bmcgaXMgYmVsb3cuICBQZXJoYXBzIGhlIGNhbiByZXNwb25kIHdpdGgNCj4gbW9yZSBkZXRhaWwg
YW5kIGNvcnJlY3QgYW55IGVycm9ycy4NCj4NCj4gSW4gdGVybXMgb2Ygb3JpZ2luYWwgbW90aXZh
dGlvbiwgeW91IG1pZ2h0IHdhbnQgdG8gbG9vayBhdCAzNHh4IFRSTQ0KPiA0LjEyLjIuNC4zLiAg
SSBkb24ndCB0aGluayB0aGlzIGFjdHVhbGx5IHdvcmtzIGluIHByYWN0aWNlIG9uIE9NQVAzLg0K
DQpTZWUgb3RoZXIgbWFpbCByZXNwb25zZS4NCg0KUGF1bCBoaXQgc29tZSBtYWpvciBwb2ludHMu
DQoNCldlIGRvIHRhcmdldCBhdXRvIGhhbmRsaW5nIG9uIEktQ2xvY2tzIGZvciBhY3RpdmUgdXNl
IGNhc2VzLiAgV2UgZGVwZW5kIG9uIGl0IHRvIGhpdCBvdXIgZ2l2ZW4gcG93ZXIgdGFyZ2V0cyBm
b3IgdGhpbmdzIGxpa2UgTVAzLiAgWW91IGNhbid0IGhhbmRsZSBpbiBzb2Z0d2FyZSBhbGwgSSBj
bG9ja3MgYW5kIGV2ZW4gZ2V0IGNsb3NlLiAgQWxsIGRyaXZlcnMgaGF2ZSB0byBiZSBqdXN0IHNv
IHRvIG1ha2UgaXQgd29yay4gIEhhdmluZyBpbmRpdmlkdWFsIGNvbnRyb2wgbWFrZXMgaXQgcG9z
c2libGUgZXNwZWNpYWxseSBmb3Igb25lcyB3aGljaCBhcmUgYnVnZ2VkIGluIHNvbWUgZmFzaGlv
biAoaHcgb3Igc29mdHdhcmUpLg0KDQpNb3ZpbmcgdG8gc29tZSBjb21iaW5lZCBjbG9jayBmb3Ig
dGhlIGdlbmVyYWwgY2FzZSBhbmQgaGF2aW5nIHNwZWNpZmljIGNvbnRyb2wgb2Ygb3RoZXJzIHNl
ZW1zIGxpa2UgYSBnb29kIGZ1dHVyZSBnb2FsLg0KDQpCYWNrIGluIG9tYXAyIHRpbWUgdGhlIGhh
cmR3YXJlIGRlc2lnbmVycyBkaWQgaW5kaWNhdGUgdGhleSBhZGRlZCBhbGwgdGhpcyBmbGV4aWJp
bGl0eSBhcyBhIHdheSB0byBjb21wZW5zYXRlIGZvciBwb3NzaWJsZSBkZXNpZ24gZXJyb3JzLiAg
VGhpcyB3YXMgYSBjb3JyZWN0IGFuZCBuZWVkZWQgYSBsb3QgaW4gb21hcDIgYW5kIHNvbWV3aGF0
IGluIG9tYXAzIHRvIG1lZXQgYWdncmVzc2l2ZSBwb3dlciB0YXJnZXRzLiAgT3VyIGZlZWQgYmFj
ayBhdCB0aGUgdGltZSB3YXMgdGhhdOKAmXMgYWxsIGZpbmUsIGJ1dCBpdCB3b3VsZCBoYXZlIGJl
dHRlciB0byBoYXZlIGEgc3RhbmRhcmQgJ3NpbXBsZScgaW50ZXJmYWNlIHdoaWNoIGNvdWxkIGJl
IGJ5cGFzc2VkIGZvciBkaXJlY3QgdXNhZ2UgaWYgYnVncy9mbGV4aWJpbGl0eSB3ZXJlIG5lZWRl
ZC4gIEFsbCB0aGUgdmFyaWFibGVzIHdoaWNoIGV4aXN0IGNhbiBiZSBjb25mdXNpbmcgd2l0aCBv
dXQgYSBsb3Qgb2YgZXhwbGFpbmluZy4NCg0KUmVnYXJkcywNClJpY2hhcmQgVy4NCg0K
