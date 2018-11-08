From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix missing of_platform_depopulate()
Date: Thu, 08 Nov 2018 19:08:57 +0200
Message-ID: <2205760.spbUmrxuY7@avalon>
References: <20181106152802.38599-1-tony@atomide.com>
 <4944470.Ta6nZRFIdO@avalon> <20181108170145.GL56134@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181108170145.GL56134@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

SGkgVG9ueSwKCk9uIFRodXJzZGF5LCA4IE5vdmVtYmVyIDIwMTggMTk6MDE6NDUgRUVUIFRvbnkg
TGluZGdyZW4gd3JvdGU6Cj4gKiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlk
ZWFzb25ib2FyZC5jb20+IFsxODExMDcgMDU6MzBdOgo+ID4gT24gVHVlc2RheSwgNiBOb3ZlbWJl
ciAyMDE4IDE3OjI4OjAyIEVFVCBUb255IExpbmRncmVuIHdyb3RlOgo+ID4gPiBXZSdyZSBtaXNz
aW5nIGEgY2FsbCB0byBvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKCkgb24gZXJyb3JzIGZvciBkc2ku
Cj4gPiA+IExvb2tzIGxpa2UgZHNzIGlzIGFscmVhZHkgZG9pbmcgdGhpcy4KPiA+ID4gCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Cj4gPiAKPiA+
IFRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUuIFlvdSBtYXkgaG93ZXZlciB3YW50IHRvIG5vdGUgaW4g
dGhlIGNvbW1pdCBtZXNzYWdlCj4gPiB0aGF0IHRoaXMgcGF0Y2ggYWxzbyB0dXJucyB0aGUgb2Zf
cGxhdGZvcm1fcG9wdWxhdGUoKSBmYWlsdXJlcyBpbnRvIGZhdGFsCj4gPiBlcnJvcnMuCj4gCj4g
V2VsbCBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGZhaWx1cmUgc2hvdWxkIGJlIGZhdGFsIGhlcmUs
cmlnaHQ/IDopCgpJJ20gbm90IGNvbXBsYWluaW5nIGFib3V0IHRoZSBmdW5jdGlvbmFsIGNoYW5n
ZSwganVzdCB0aGUgbGFjayBvZiB2aXNpYmlsaXR5IAo6LSkKCj4gVG9taSwgbGV0IG1lIGtub3cg
aWYgeW91IG5lZWQgYSByZXNlbmQgd2l0aCB1cGRhdGVkIGNvbW1lbnRzIG9yCj4gaWYgeW91IHdh
bnQgdG8gdXBkYXRlIHRoZSBtZXNzYWdlIHlvdXJzZWxmIHRvIHlvdXIgbGlraW5nLgoKLS0gClJl
Z2FyZHMsCgpMYXVyZW50IFBpbmNoYXJ0CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
