From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] drm: omapdrm: Fix DPI on platforms using the DSI
 VDDS
Date: Tue, 21 Nov 2017 12:25:30 +0200
Message-ID: <7f34033e-4af7-f5f5-47ef-759249ddfe39@ti.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <dd2427920427440e051951071377265fc0a830d4.1510822218.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <dd2427920427440e051951071377265fc0a830d4.1510822218.git.hns@goldelico.com>
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
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMTYvMTEvMTcgMTA6NTAsIEguIE5pa29sYXVzIFNjaGFsbGVyIHdyb3RlOgo+IEZyb206IExh
dXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4KPiAKPiBD
b21taXQgZDE3OGUwMzRkNTY1ICgiZHJtOiBvbWFwZHJtOiBNb3ZlIEZFQVRfRFBJX1VTRVNfVkRE
U19EU0kgZmVhdHVyZQo+IHRvIGRwaSBjb2RlIikgcmVwbGFjZWQgdXNhZ2Ugb2YgcGxhdGZvcm0g
ZGF0YSB2ZXJzaW9uIHdpdGggU29DIG1hdGNoaW5nCj4gdG8gY29uZmlndXJlIERQSSBWRERTLiBU
aGUgU29DIG1hdGNoIGVudHJpZXMgd2VyZSBpbmNvcnJlY3QsIHRoZXkgc2hvdWxkCj4gaGF2ZSBt
YXRjaGVkIG9uIHRoZSBtYWNoaW5lIG5hbWUgaW5zdGVhZCBvZiB0aGUgU29DIGZhbWlseS4gRml4
IGl0Lgo+IAo+IFRoZSByZXN1bHQgd2FzIG9ic2VydmVkIG9uIE9wZW5QYW5kb3JhIHdpdGggT01B
UDM1MzAgd2hlcmUgdGhlIHBhbmVsIG9ubHkKPiBoYWQgdGhlIEJsdWUgY2hhbm5lbCBhbmQgUmVk
JkdyZWVuIHdlcmUgbWlzc2luZy4gSXQgd2FzIG5vdCBvYnNlcnZlZCBvbgo+IEdUQTA0IHdpdGgg
RE0zNzMwLgo+IAo+IEZpeGVzOiBkMTc4ZTAzNGQ1NjUgKCJkcm06IG9tYXBkcm06IE1vdmUgRkVB
VF9EUElfVVNFU19WRERTX0RTSSBmZWF0dXJlIHRvIGRwaSBjb2RlIikKPiBTaWduZWQtb2ZmLWJ5
OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+Cj4g
UmVwb3J0ZWQtYnk6IEguIE5pa29sYXVzIFNjaGFsbGVyIDxobnNAZ29sZGVsaWNvLmNvbT4KPiBU
ZXN0ZWQtYnk6IEguIE5pa29sYXVzIFNjaGFsbGVyIDxobnNAZ29sZGVsaWNvLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL2RwaS5jIHwgNCArKy0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9vbWFw
ZHJtL2Rzcy9kcGkuYwo+IGluZGV4IDRlZDVmZGUxMTMxMy4uYTkxZTVmMWEwNDkwIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kcGkuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9vbWFwZHJtL2Rzcy9kcGkuYwo+IEBAIC01NjYsOCArNTY2LDggQEAgc3RhdGljIGlu
dCBkcGlfdmVyaWZ5X3BsbChzdHJ1Y3QgZHNzX3BsbCAqcGxsKQo+ICB9Cj4gIAo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlIGRwaV9zb2NfZGV2aWNlc1tdID0gewo+
IC0JeyAuZmFtaWx5ID0gIk9NQVAzWzQ1Nl0qIiB9LAo+IC0JeyAuZmFtaWx5ID0gIltBRF1NMzcq
IiB9LAo+ICsJeyAubWFjaGluZSA9ICJPTUFQM1s0NTZdKiIgfSwKPiArCXsgLm1hY2hpbmUgPSAi
W0FEXU0zNyoiIH0sCj4gIAl7IC8qIHNlbnRpbmVsICovIH0KPiAgfTsKPiAgCj4gCgpJIGhhdmUg
cGlja2VkIHRoaXMgb25lLiBJIHRoaW5rIHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGFyZSBtb3Jl
IG9mIGEKY2xlYW51cCwgcmlnaHQ/IEFuZCB5b3UnbGwgYmUgc2VuZGluZyB2MyBhdCBzb21lIHBv
aW50LgoKIFRvbWkKCi0tIApUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5r
YXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4g
S290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
