From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv1 01/14] drm/omap: remove unused function defines
Date: Fri, 1 Dec 2017 14:30:37 +0200
Message-ID: <253098e7-0d9a-8367-4a39-f5c6405074c0@ti.com>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170724173311.27170-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170724173311.27170-2-sebastian.reichel@collabora.co.uk>
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
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMjQvMDcvMTcgMjA6MzIsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+IFJlbW92ZSBkcml2
ZXIgKHVuKXJlZ2lzdGVyIEFQSSBkZWZpbmVzLiBUaGV5IGRvIG5vdCBldmVuIGV4aXN0Cj4gYW55
bW9yZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gUmVpY2hlbCA8c2ViYXN0aWFuLnJl
aWNoZWxAY29sbGFib3JhLmNvLnVrPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vb21hcGRybS9k
c3Mvb21hcGRzcy5oIHwgMyAtLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9vbWFwZHNzLmggYi9k
cml2ZXJzL2dwdS9kcm0vb21hcGRybS9kc3Mvb21hcGRzcy5oCj4gaW5kZXggODU5NTNhMGJjN2My
Li40ZTYxOWZmMzYwYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNz
L29tYXBkc3MuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9vbWFwZHNzLmgK
PiBAQCAtNTc1LDkgKzU3NSw2IEBAIHN0cnVjdCBvbWFwX2Rzc19kcml2ZXIgewo+ICBlbnVtIG9t
YXBkc3NfdmVyc2lvbiBvbWFwZHNzX2dldF92ZXJzaW9uKHZvaWQpOwo+ICBib29sIG9tYXBkc3Nf
aXNfaW5pdGlhbGl6ZWQodm9pZCk7Cj4gIAo+IC1pbnQgb21hcF9kc3NfcmVnaXN0ZXJfZHJpdmVy
KHN0cnVjdCBvbWFwX2Rzc19kcml2ZXIgKik7Cj4gLXZvaWQgb21hcF9kc3NfdW5yZWdpc3Rlcl9k
cml2ZXIoc3RydWN0IG9tYXBfZHNzX2RyaXZlciAqKTsKPiAtCj4gIGludCBvbWFwZHNzX3JlZ2lz
dGVyX2Rpc3BsYXkoc3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNzZGV2KTsKPiAgdm9pZCBvbWFw
ZHNzX3VucmVnaXN0ZXJfZGlzcGxheShzdHJ1Y3Qgb21hcF9kc3NfZGV2aWNlICpkc3NkZXYpOwoK
SSBwaWNrZWQgdGhpcyBhbmQgdGhlIHBhdGNoIDIgZm9yIHY0LjE2LgoKIFRvbWkKCi0tIApUZXhh
cyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5r
aS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTog
SGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
