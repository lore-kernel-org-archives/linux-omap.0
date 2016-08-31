From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 0/8] drm/tilcdc: Address LCDC rev 2 color errata +
 other fixes
Date: Wed, 31 Aug 2016 21:48:24 +0300
Message-ID: <c049825a-0802-0637-3b1e-5290032e6d10@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
 <20160831180418.rte4sf5s4llyuuvn@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160831180418.rte4sf5s4llyuuvn@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, kbeldan@baylibre.com, laurent.pinchart@ideasonboard.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDgvMzEvMTYgMjE6MDQsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gKiBKeXJpIFNhcmhhIDxq
c2FyaGFAdGkuY29tPiBbMTYwODMxIDA2OjE5XToKPj4gICBBUk06IGR0czogYW0zMzV4LWJvbmVi
bGFjazogQWRkIGJsdWUtYW5kLXJlZC13aXJpbmcgLXByb3BlcnR5IHRvIExDREMKPj4gICAgIG5v
ZGUKPj4gICBBUk06IGR0czogYW0zMzV4LWV2bTogQWRkIGJsdWUtYW5kLXJlZC13aXJpbmcgLXBy
b3BlcnR5IHRvIGxjZGMgbm9kZQo+PiAgIEFSTTogZHRzOiBhbTMzNXgtZXZtc2s6IFdoaXRlc3Bh
Y2UgY2xlYW51cCBvZiBsY2RjIHJlbGF0ZWQgbm9kZXMKPj4gICBBUk06IGR0czogYW0zMzV4LWV2
bXNrOiBBZGQgYmx1ZS1hbmQtcmVkLXdpcmluZyAtcHJvcGVydHkgdG8gbGNkYyBub2RlCj4gCj4g
SWYgc29tZSBvZiB0aGVzZSBkdHMgY2hhbmdlcyBhcmUgT0sgZm9yIG1lIHRvIGFwcGx5IHNlcGFy
YXRlbHkgYWxyZWFkeSwKPiBwbGVhc2UgbGV0IG1lIGtub3cuCj4gCj4gT3RoZXJ3aXNlIEknbGwg
dGFnIHRoaXMgdGhyZWFkIGFzIHJlYWQgYW5kIGFzc3VtZSB5b3UnbGwgc2VuZCB0aGUgZHRzCj4g
Y2hhbmdlcyBzZXBhcmF0ZWx5IHdoZW4gcmVhZHkgOikKPiAKCkFjY29yZGluZyB0byBteSBwbGFu
IHRoZSBkcm0gc2lkZSBjaGFuZ2VzIHNob3VsZCBnbyBpbnRvIDQuOS4KClRoZSBjb21taXQgbWVz
c2FnZXMgYW5kIHRoZSBjb21tZW50cyBtYXkgbG9vayBjb25mdXNpbmcgd2l0aG91dCB0aGUKaW1w
bGVtZW50YXRpb24sIGJ1dCBvdGhlcndpc2UgdGhlcmUgc2hvdWxkIGJlIG5vIGhhcm0gaW4gYXBw
bHlpbmcgdGhlc2UKYWxyZWFkeS4gVGhlIG5ldyBwcm9wZXJ0aWVzIGluIGR0cyBzaW1wbHkgd29u
dCBoYXZlIGFueSBlZmZlY3QuIE9uIHRoZQpvdGhlciBoYW5kLCBub3QgaGF2aW5nIHRoZSBkdHMg
Y2hhbmdlcyB3b24ndCBoYXZlIGFueSBkcmFtYXRpYyBlZmZlY3QKZWl0aGVyLiBUaGUgc3VwcG9y
dGVkIGNvbG91ciBmb3JtYXRzIHdpbGwganVzdCByZW1haW4gaW4gdGhlIHNhbWUKaW5jb3JyZWN0
IHN0YXRlIGFzIHRoZXkgaGF2ZSBhbHdheXMgYmVlbiB1bnRpbCB0aGUgZHRzIGNoYW5nZXMgYXJl
CnRoZXJlLiBTbyB3aGF0IGV2ZXIgaXMgbW9yZSBjb252ZW5pZW50IGZvciB5b3UuCgpUaGFua3Ms
Ckp5cmkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
