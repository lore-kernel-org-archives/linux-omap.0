From: NAVEEN KRISHNA CHATRADHI <ch.naveen@samsung.com>
Subject: Re: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Mon, 22 Jul 2013 08:37:00 +0000 (GMT)
Message-ID: <23795036.212591374482218972.JavaMail.weblogic@epml23>
Reply-To: ch.naveen@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58574 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969Ab3GVIhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 04:37:02 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQB001PTX9IF920@mailout3.samsung.com> for
 linux-omap@vger.kernel.org; Mon, 22 Jul 2013 17:37:00 +0900 (KST)
MIME-version: 1.0
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Doug Anderson <dianders@chromium.org>, Vivek Gautam <gautam.vivek@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>

SGVsbG8gU2ViYXN0aWFuLAoKLS0tLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tLS0KU2VuZGVy
IDogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcjxiaWdlYXN5QGxpbnV0cm9uaXguZGU+IApEYXRl
ICAgOiBKdWwgMjIsIDIwMTMgMTM6NTUgKEdNVCswNTozMCkKVGl0bGUgIDogUmU6IFtQQVRDSF0g
b2Y6IHByb3ZpZGUgb2ZfcGxhdGZvcm1fdW5wb3B1bGF0ZSgpCgpPbiAwNy8yMC8yMDEzIDA3OjQy
IEFNLCBOQVZFRU4gS1JJU0hOQSBDSEFUUkFESEkgd3JvdGU6Cj4gSGVsbG8gU2ViYXN0aWFuLAoK
SGVsbG8gTmF2ZWVuLAoKPiAKPiBJIGp1c3QgZGlkIG9uZSBtb3JlIHRlc3RpbmcuCj4gCj4gSW4g
Y2FzZSBvZiBpaW8vYWRjL2V4eW5vc19hZGMuYyB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGUgcmVtb3Zl
IHBhdGguCj4gSWYgSSBmaXggdGhlIGJ1ZyBpbiB0aGUgZHJpdmVyLCB3aXRoIGJlbG93IHBhdGNo
Cj4gCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2V4eW5vc19hZGMuYwo+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy9leHlub3NfYWRjLmMKPiBAQCAtMzc1LDE0ICszNzUsMTQgQEAgc3RhdGljIGludCBl
eHlub3NfYWRjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAgICAgICAg
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwo+
ICAgICAgICAgc3RydWN0IGV4eW5vc19hZGMgKmluZm8gPSBpaW9fcHJpdihpbmRpb19kZXYpOwo+
IAo+IC0gICAgICAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKCZwZGV2LT5kZXYsIE5VTEwsCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHlub3NfYWRjX3JlbW92ZV9kZXZpY2VzKTsK
PiAgICAgICAgIHJlZ3VsYXRvcl9kaXNhYmxlKGluZm8tPnZkZCk7Cj4gICAgICAgICBjbGtfZGlz
YWJsZV91bnByZXBhcmUoaW5mby0+Y2xrKTsKPiAgICAgICAgIHdyaXRlbCgwLCBpbmZvLT5lbmFi
bGVfcmVnKTsKPiAgICAgICAgIGlpb19kZXZpY2VfdW5yZWdpc3RlcihpbmRpb19kZXYpOwo+ICAg
ICAgICAgZnJlZV9pcnEoaW5mby0+aXJxLCBpbmZvKTsKPiAgICAgICAgIGlpb19kZXZpY2VfZnJl
ZShpbmRpb19kZXYpOwo+ICsgICAgICAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKCZwZGV2LT5kZXYs
IE5VTEwsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHlub3NfYWRjX3JlbW92
ZV9kZXZpY2VzKTsKPiAKPiBFdmVuIHdpdGhvdXQgeW91ciBmaXgsIEkgY291bGQgY29uZmlndXJl
IGl0IGFzIGEgbW9kdWxlIGFuZCB0aGUgcm1tb2QsIGluc21vZCBhcmUgd29ya2luZyBmaW5lLiAo
bm8gY3Jhc2gpCgpJIGhhdmUgbm8gaWRlYSB3aHkgeW91IG1vdmVkIGl0LiBJIGhhdmVuJ3QgZm91
bmQgYW55IC5kdHMgd2l0aCB0aGlzCiAgcmVndWxhdG9yX2Rpc2FibGUoaW5mby0+dmRkKTsKaGFz
IHRvIGhhcHBlbiBiZWZvcmUgd2UgZnJlZSBhbmQgcmVtb3ZlIHRoZSBkZXZpY2VzLgpUaGUgZHRz
IHBhcnQgaXMgbm90IHVwc3RyZWFtZWQgeWV0LgoKYmluZGluZyBidXQgZnJvbSB0aGUgYmluZGlu
ZyBkb2N1bWVudCBJIHdvdWxkIGFzc3VtZSB0aGF0IHlvdSBkbyBub3QKaGF2ZSBhbnkgbWVtb3J5
IHJlc291cmNlcyBhbmQgdGhlcmVmb3JlIHlvdSBkb24ndCBzZWUgdGhhdCBjcmFzaC4KWWVzLCBt
eSBkZXZpY2VzIHVuZGVyIEFEQyBhcmUgM3JkIHBhcnR5IHRoZXJtaXN0b3JzIGFuZCB0aGV5IGRv
bid0IGhhdmUgbWVtb3J5IHJlc291cmNlcy4KTWF5IGJlIHlvdXIgZXhwbGFuYXRpb24gc2VlbXMg
cmlnaHQuCgpUaGFua3MsCk5hdmVlbgoKPiBSZWdhcmRzLAo+IE5hdmVlbgoKU2ViYXN0aWFuCg==


