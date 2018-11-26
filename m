From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv5 2/6] drm/omap: populate DSI platform bus earlier
Date: Mon, 26 Nov 2018 11:27:06 +0200
Message-ID: <d65157b6-59c7-7b51-d431-9f9cb5585593@ti.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-3-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181121160916.22017-3-sebastian.reichel@collabora.com>
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

T24gMjEvMTEvMTggMTg6MDksIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+IEFmdGVyIHRoZSBj
aGFuZ2VzIGZyb20gNC4yMCB0aGUgRFNJIGVuY29kZXIgdHJpZXMgdG8gZmluZCB0aGUKPiBhdHRh
Y2hlZCBwYW5lbCBiZWZvcmUgcG9wdWxhdGluZyB0aGUgRFNJIGJ1cy4gSWYgdGhlIHBhbmVsIGlz
Cj4gbm90IGZvdW5kIC1FUFJPQkVfREVGRVIgaXMgcmV0dXJuZWQsIHNvIHRoZSBEU0kgYnVzIGlz
IG5ldmVyCj4gcG9wdWxhdGVkIGFuZCB0aGUgcGFuZWwgbmV2ZXIgYWRkZWQuCj4gCj4gRml4IHRo
aXMgYnkgcG9wdWxhdGluZyB0aGUgRFNJIGJ1cyBiZWZvcmUgc2VhcmNoaW5nIGZvciB0aGUKPiB2
aWRlbyBzaW5rIGluIGRzaV9pbml0X291dHB1dCgpLgo+IAo+IEZpeGVzOiAyN2Q2MjQ1MjdkOTky
ICgiZHJtL29tYXA6IGRzczogQWNxdWlyZSBuZXh0IGRzc2RldiBhdCBwcm9iZSB0aW1lIikKPiBB
Y2tlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+Cj4gVGVzdGVkLWJ5OiBUb255IExp
bmRncmVuIDx0b255QGF0b21pZGUuY29tPgo+IFRlc3RlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZl
bEB1Y3cuY3o+Cj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5y
ZWljaGVsQGNvbGxhYm9yYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rz
cy9kc2kuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBUb21pIFZhbGtlaW5l
biA8dG9taS52YWxrZWluZW5AdGkuY29tPgoKIFRvbWkKCi0tIApUZXhhcyBJbnN0cnVtZW50cyBG
aW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVz
aW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
