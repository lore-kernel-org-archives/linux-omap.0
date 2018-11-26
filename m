From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv5 1/6] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
Date: Mon, 26 Nov 2018 11:25:43 +0200
Message-ID: <e9462358-30a8-a1a3-87ec-8c120e6f101b@ti.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-2-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181121160916.22017-2-sebastian.reichel@collabora.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gMjEvMTEvMTggMTg6MDksIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+IFRoaXMgbWFjcm8g
aXMgb25seSB1c2VkIGJ5IG9tYXBkcm0sIHdoaWNoIHNob3VsZCBwcmludAo+IGRlYnVnIG1lc3Nh
Z2VzIHVzaW5nIHRoZSBEUklWRVIgY2F0ZWdvcnkgaW5zdGVhZCBvZiB0aGUKPiBkZWZhdWx0IENP
UkUgY2F0ZWdvcnkuCj4gCj4gQWNrZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6Pgo+
IFRlc3RlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KPiBUZXN0ZWQtYnk6
IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBS
ZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vb21hcGRybS9vbWFwX2Rydi5oIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9vbWFwZHJtL29tYXBfZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9vbWFw
X2Rydi5oCj4gaW5kZXggYmQ3ZjJjMjI3YTI1Li4zYjRhZjUxN2M5MmIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9kcnYuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9vbWFwZHJtL29tYXBfZHJ2LmgKPiBAQCAtMzgsOCArMzgsOCBAQAo+ICAjaW5jbHVkZSAib21h
cF9pcnEuaCIKPiAgI2luY2x1ZGUgIm9tYXBfcGxhbmUuaCIKPiAgCj4gLSNkZWZpbmUgREJHKGZt
dCwgLi4uKSBEUk1fREVCVUcoZm10IlxuIiwgIyNfX1ZBX0FSR1NfXykKPiAtI2RlZmluZSBWRVJC
KGZtdCwgLi4uKSBpZiAoMCkgRFJNX0RFQlVHKGZtdCwgIyNfX1ZBX0FSR1NfXykgLyogdmVyYm9z
ZSBkZWJ1ZyAqLwo+ICsjZGVmaW5lIERCRyhmbXQsIC4uLikgRFJNX0RFQlVHX0RSSVZFUihmbXQi
XG4iLCAjI19fVkFfQVJHU19fKQo+ICsjZGVmaW5lIFZFUkIoZm10LCAuLi4pIGlmICgwKSBEUk1f
REVCVUdfRFJJVkVSKGZtdCwgIyNfX1ZBX0FSR1NfXykgLyogdmVyYm9zZSBkZWJ1ZyAqLwo+ICAK
PiAgI2RlZmluZSBNT0RVTEVfTkFNRSAgICAgIm9tYXBkcm0iCj4gIAo+IAoKUmV2aWV3ZWQtYnk6
IFRvbWkgVmFsa2VpbmVuIDx0b21pLnZhbGtlaW5lbkB0aS5jb20+CgogVG9taQoKLS0gClRleGFz
IEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtp
LgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBI
ZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
