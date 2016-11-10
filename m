From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Thu, 10 Nov 2016 10:37:12 +0530
Message-ID: <b7232421-10f7-2bac-0ad8-847804126bf2@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
 <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
 <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
 <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Syne <john3909@gmail.com>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Nori,
 Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiBUaHVyc2RheSAxMCBOb3ZlbWJlciAyMDE2IDA1OjIzIEFNLCBKb2huIFN5bmUgd3Jv
dGU6Cj4gT0ssIHRoZW4gYmFjayB0byBteSBvcmlnaW5hbCBxdWVzdGlvbi4gR2l2ZW4gdGhhdCB0
aGVzZSBEVCBwcm9wZXJ0aWVzIGFyZSBzdXBwb3J0ZWQgaW4gdGhlIGRyaXZlcgo+IAoKQmVsb3cg
cHJvcGVydGllcyBhcmUgc3VwcG9ydGVkIGJ5IG9ubHkgYnkgdGlfYW0zMzM1eF9hZGMgZHJpdmVy
IGFuZCBub3QKdGlfYW0zMzV4X3RzYyBkcml2ZXIuIEFzIGF1dGhvciBvZiB0aGlzIHBhdGNoIHBv
aW50ZWQgb3V0IGluIGFub3RoZXIKcmVwbHksIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2hhbmdlIHN0
ZXAtb3BlbmRlbGF5IGZvciB0c2MuIEFGQUlLLCBJIGRvbid0CnNlZSBhIHVzZSBjYXNlIHdoZXJl
IHRoZXNlIHZhbHVlcyBuZWVkcyB0byBiZSB0d2Vha2VkIGZvciB0c2MgY2hhbm5lbHMsCnRoZXJl
Zm9yZSBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIGJlIERUIHByb3BlcnRpZXMuCgo+IHNob3Vs
ZG7igJl0IHRoZSBmb2xsb3dpbmcgYmUgYWRkZWQgdG8gYW0zM3h4LmR0c2kgYW5kIGFtNDM3Mi5k
dHNpPwoKSXRzIHRvdGFsbHkgdXB0byBib2FyZCBkdHMgZmlsZXMgdG8gYWxsb2NhdGUgY2hhbm5l
bHMgZm9yIHRzYyBhbmQgYWRjLgpTbywgaG93IGNvdWxkIHRoZXNlIGJlIGFkZGVkIHRvIGR0c2kg
ZmlsZXM/Cgo+IHRpLGNoYW4tc3RlcC1hdmcgPSA8MHgxNiAweDE2IDB4MTYgMHgxNiAweDE2IDB4
MTYgMHgxNj47Cj4gdGksY2hhbi1zdGVwLW9wZW5kZWxheSA9IDwweDUwMCAweDUwMCAweDUwMCAw
eDUwMCAweDUwMCAweDUwMCAweDUwMD47Cj4gdGksY2hhbi1zdGVwLXNhbXBsZWRlbGF5ID0gPDB4
MCAweDAgMHgwIDB4MCAweDAgMHgwIDB4MD47Cj4gCj4gUmVnYXJkcywKPiBKb2huCj4+Cj4+IC0t
IAo+PiBSZWdhcmRzCj4+IFZpZ25lc2gKPiAKCi0tIApSZWdhcmRzClZpZ25lc2gKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
