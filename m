From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Fix port lookup for SDI output
Date: Fri, 23 Aug 2019 11:04:14 +0300
Message-ID: <45a226f3-7a31-2109-8f01-1628b3d61654@ti.com>
References: <20190818140838.GC30291@darkstar.musicnaut.iki.fi>
 <20190821183226.13784-1-laurent.pinchart@ideasonboard.com>
 <20190821202627.GD30291@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190821202627.GD30291@darkstar.musicnaut.iki.fi>
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
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gMjEvMDgvMjAxOSAyMzoyNiwgQWFybyBLb3NraW5lbiB3cm90ZToKPiBIaSwKPiAKPiBPbiBX
ZWQsIEF1ZyAyMSwgMjAxOSBhdCAwOTozMjoyNlBNICswMzAwLCBMYXVyZW50IFBpbmNoYXJ0IHdy
b3RlOgo+PiBXaGVuIHJlZmFjdG9yaW5nIHBvcnQgbG9va3VwIGZvciBEU1Mgb3V0cHV0cywgY29t
bWl0IGQxN2ViNDUzN2E3ZQo+PiAoImRybS9vbWFwOiBGYWN0b3Igb3V0IGNvbW1vbiBpbml0L2Ns
ZWFudXAgY29kZSBmb3Igb3V0cHV0IGRldmljZXMiKQo+PiBpbmNvcnJlY3RseSBoYXJkY29kZWQg
dXNhZ2Ugb2YgRFQgcG9ydCAwLiBUaGlzIGJyZWFrcyBvcGVyYXRpb24gZm9yIFNESQo+PiAod2hp
Y2ggdXNlcyB0aGUgRFQgcG9ydCAxKSBhbmQgRFBJIG91dHB1dHMgb3RoZXIgdGhhbiBEUEkwICh3
aGljaCBhcmUKPj4gbm90IHVzZWQgaW4gbWFpbmxpbmUgRFQgc291cmNlcykuCj4+Cj4+IEZpeCB0
aGlzIGJ5IHVzaW5nIHRoZSBwb3J0IG51bWJlciBmcm9tIHRoZSBvdXRwdXQgb21hcF9kc3NfZGV2
aWNlCj4+IG9mX3BvcnRzIGZpZWxkLgo+Pgo+PiBGaXhlczogZDE3ZWI0NTM3YTdlICgiZHJtL29t
YXA6IEZhY3RvciBvdXQgY29tbW9uIGluaXQvY2xlYW51cCBjb2RlIGZvciBvdXRwdXQgZGV2aWNl
cyIpCj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRA
aWRlYXNvbmJvYXJkLmNvbT4KPiAKPiBUZXN0ZWQtYnk6IEFhcm8gS29za2luZW4gPGFhcm8ua29z
a2luZW5AaWtpLmZpPgo+IAo+IFRoYW5rcywgdGhpcyBmaXhlcyB0aGUgZGlzcGxheSBpc3N1ZSBv
biBOOTAwLgoKVGhhbmtzLCBwdXNoZWQgdG8gZHJtLW1pc2MtZml4ZXMuCgogIFRvbWkKCi0tIApU
ZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxz
aW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2ls
ZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
