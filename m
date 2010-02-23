From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 10/11] omap: musb: get rid of dyn_fifo
Date: Tue, 23 Feb 2010 20:50:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A20527@dbde02.ent.ti.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
	 <20100219233036.10559.29778.stgit@baageli.muru.com>
	 <4B83EC7C.6020406@corscience.de>
 <f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0BWPVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 10:21:13 -0500
In-Reply-To: <f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>, Thomas Weber <weber@corscience.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

PiA+IEkgdGhpbmsgdGhpcyBwYXRjaCBicmVha3MgbXVzYl9oZHJjLg0KPiA+DQo+ID4gSW4gbXVz
Yl9jb3JlX2luaXQgaXMgbXVzYi0+Y29uZmlnLT5keW5fZmlmbyBjaGVja2VkIGJ1dCBpcyBuZXZl
ciBzZXQuDQo+ID4NCj4gPiBTbyBJIGdldCB0aGUgZm9sbG93aW5nIGRtZXNnIG91dHB1dDoNCj4g
Pg0KPiA+IG11c2JfaGRyYzogQ29uZmlnRGF0YT0weGRlIChVVE1JLTgsIGR5biBGSUZPcywgYnVs
ayBjb21iaW5lLCBidWxrIHNwbGl0LA0KPiA+IEhCLUlTTyBSeCwgSEItSVNPIFR4LCBTb2Z0Q29u
bikNCj4gPiBtdXNiX2hkcmM6IE1IRFJDIFJUTCB2ZXJzaW9uIDEuNDAwDQo+ID4gbXVzYl9jb3Jl
X2luaXQgMTQwNTogcmVjb25maWd1cmUgc29mdHdhcmUgZm9yIER5bmFtaWMgRklGT3MNCj4gPiBt
dXNiX2hkcmMgbXVzYl9oZHJjOiBtdXNiX2luaXRfY29udHJvbGxlciBmYWlsZWQgd2l0aCBzdGF0
dXMgLTE5DQo+ID4NCj4gPiBUaG9tYXMNCj4gDQo+IEkgdGhpbmsgSSBoYXZlIHRoZSBzYW1lIHBy
b2JsZW0uDQo+IFRoZXJlIGFyZSBvdGhlciBwcm9ibGVtcyByaWdodCBub3cgKEknbSB0cnlpbmcg
c2V2ZXJhbCBkaWZmZXJlbnQgYnJhbmNoL2RlZmNvbmZpZw0KPiBjb21iaW5hdGlvbnMpIHNvIEkg
Y2FuJ3QgYmUgMTAwJSBzdXJlLg0KPiANCg0KQWpheSByZXBvcnRlZCBlYXJsaWVyIHRvZGF5IFsx
XSB0aGF0IHRoZXJlIGlzIGEgZGVwZW5kZW5jeSBwYXRjaCBbMl0NCnRoYXQgbmVlZHMgdG8gYmUg
dGFrZW4gaW4uIExvb2tzIGxpa2UgaXQgd2FzIG1pc3NlZCB3aGVuIHRoZSBNVVNCDQpwYXRjaHNl
dCB3YXMgYWRkZWQgdG8gbGludXgtb21hcCBmb3IgZXh0cmEgdGVzdGluZy4NCg0KLSBBbmFuZA0K
DQpbMV0gaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1vbWFwJm09MTI2NjkxNTc4ODMxMzAxJnc9
Mg0KWzJdIGh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtb21hcCZtPTEyNjA4ODM5MzEzMDE3NyZ3
PTINCg==
