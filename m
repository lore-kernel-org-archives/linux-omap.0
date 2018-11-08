From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix missing of_platform_depopulate()
Date: Thu, 8 Nov 2018 09:01:45 -0800
Message-ID: <20181108170145.GL56134@atomide.com>
References: <20181106152802.38599-1-tony@atomide.com>
 <4944470.Ta6nZRFIdO@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <4944470.Ta6nZRFIdO@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

KiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+IFsx
ODExMDcgMDU6MzBdOgo+IEhpIFRvbnksCj4gCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCj4g
Cj4gT24gVHVlc2RheSwgNiBOb3ZlbWJlciAyMDE4IDE3OjI4OjAyIEVFVCBUb255IExpbmRncmVu
IHdyb3RlOgo+ID4gV2UncmUgbWlzc2luZyBhIGNhbGwgdG8gb2ZfcGxhdGZvcm1fZGVwb3B1bGF0
ZSgpIG9uIGVycm9ycyBmb3IgZHNpLgo+ID4gTG9va3MgbGlrZSBkc3MgaXMgYWxyZWFkeSBkb2lu
ZyB0aGlzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPgo+IAo+IFRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUuIFlvdSBtYXkgaG93ZXZlciB3YW50
IHRvIG5vdGUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIAo+IHRoYXQgdGhpcyBwYXRjaCBhbHNvIHR1
cm5zIHRoZSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGZhaWx1cmVzIGludG8gZmF0YWwgCj4gZXJy
b3JzLgoKV2VsbCBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGZhaWx1cmUgc2hvdWxkIGJlIGZhdGFs
IGhlcmUscmlnaHQ/IDopClRvbWksIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGEgcmVzZW5kIHdp
dGggdXBkYXRlZCBjb21tZW50cyBvcgppZiB5b3Ugd2FudCB0byB1cGRhdGUgdGhlIG1lc3NhZ2Ug
eW91cnNlbGYgdG8geW91ciBsaWtpbmcuCgpSZWdhcmRzLAoKVG9ueQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
