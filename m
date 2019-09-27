From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Fri, 27 Sep 2019 18:47:54 +0300
Message-ID: <eb2eb1f6-3c9b-7ecb-667e-819033af9c14@ti.com>
References: <20190510194229.20628-1-aford173@gmail.com>
 <af325707-3e42-493d-e858-77878ef06138@ti.com>
 <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
 <7ada0752-6f65-2906-cb29-a47c9490fd57@ti.com>
 <CAHCN7xJexJvh71vyb31ETgo=n_y_CupHH-AZwVK9mZe3GzJfEQ@mail.gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com>
 <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
 <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
 <CAHCN7xKocdiWOdmoWQV3POr84qte6WNt0QbQRAwxKSvU8COB_w@mail.gmail.com>
 <0473526e-df0a-94a5-5c22-debd0084ab16@ti.com>
 <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, Adam Ford <aford173@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

T24gMjcvMDkvMjAxOSAxODozNywgVGVybyBLcmlzdG8gd3JvdGU6Cgo+IElmIHlvdSBjYW4gcHJv
dmlkZSBkZXRhaWxzIGFib3V0IHdoYXQgY2xvY2sgZnJhbWV3b3JrIC8gZHJpdmVyIGRvZXMgCj4g
d3JvbmcgKHNhbXBsZSBjbGtfc2V0X3h5eiBjYWxsIHNlcXVlbmNlLCBleHBlY3RlZCByZXN1bHRz
IHZpYSAKPiBjbGtfZ2V0X3h5eiwgYW5kIHdoYXQgZmFpbHMpLCBJIGNhbiB0YWtlIGEgbG9vayBh
dCBpdC4gSnVzdCByZXBvcnRpbmcgCj4gYXJiaXRyYXJ5IGRpc3BsYXkgZHJpdmVyIGlzc3VlcyBJ
IHdvbid0IGJlIGFibGUgdG8gZGVidWcgYXQgYWxsIChJIGRvbid0IAo+IGhhdmUgYWNjZXNzIHRv
IGFueSBvZiB0aGUgZGlzcGxheXMsIG5vciBkbyBJIHdhbnQgdG8gd2FzdGUgdGltZSAKPiBkZWJ1
Z2dpbmcgdGhlbSB3aXRob3V0IGFic29sdXRlbHkgbm8ga25vd2xlZGdlIHdoYXRzb2V2ZXIuKQoK
SSB1c2VkIHlvdXIgaGFjayBwYXRjaGVzIHRvIGFsbG93IGNoYW5naW5nIHJhdGVzIHZpYSBkZWJ1
Z2ZzLiBBbmQgc2V0IApkc3MxX2Fsd29uX2Zja18zNDMwZXMyIHRvIDI3MDAwMDAwIG9yIDI3ODcw
OTY3LiBUaGUgZW5kIHJlc3VsdCB3YXMgdGhhdCAKRFNTIGdldHMgc29tZSB2ZXJ5IGhpZ2ggY2xv
Y2sgZnJvbSBkc3MxX2Fsd29uX2Zja18zNDMwZXMyLCBhcyB0aGUgZnJhbWUgCnJhdGUganVtcHMg
dG8gbWFueSBodW5kcmVkcyBmcHMuCgpTbywgdGhlc2UgbnVtYmVycyBhcmUgbm90IHJlYWwsIGJ1
dCB0byBnaXZlIHRoZSBpZGVhIHdoYXQgSSBzYXcuIFJ1bm5pbmcgCmZpcnN0IHdpdGggNTAgTUh6
LCBJIGNhbiBzZWUsIHNheSwgNDAgZnBzLiBUaGVuIEkgc2V0IHRoZSBjbG9jayB0byAzMCAKTUh6
LCBhbmQgZnBzIGRyb3BwZWQgdG8sIHNheSwgMzBmcHMsIGFzIGV4cGVjdGVkIHdpdGggbG93ZXIg
Y2xvY2suIFRoZW4gCkkgc2V0IHRoZSBjbG9jayB0byAyN01IeiAob3IgdGhlIG90aGVyIG9uZSks
IGV4cGVjdGluZyBhIGJpdCBsb3dlciBmcHMsIApidXQgaW5zdGVhZCBJIHNhdyBodW5kcmVkcyBv
ZiBmcHMuCgpJIGRvbid0IGtub3cgaWYgdGhlcmUncyBhbnkgb3RoZXIgd2F5IHRvIG9ic2VydmUg
dGhlIHdyb25nIGNsb2NrIHJhdGUgCmJ1dCBoYXZlIHRoZSBkc3MgZW5hYmxlZCBhbmQgcnVubmlu
ZyBrbXN0ZXN0IG9yIHNpbWlsYXIuIEkgY2FuIGhlbHAgeW91IApzZXQgdGhhdCB1cCBuZXh0IHdl
ZWssIHNob3VsZCBiZSB0cml2aWFsLiBZb3UgZG9uJ3QgbmVlZCBhIGRpc3BsYXkgZm9yIHRoYXQu
CgogIFRvbWkKCi0tIApUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1
IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290
aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVs
