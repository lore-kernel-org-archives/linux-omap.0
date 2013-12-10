From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 11/15] mfd: menelaus: Start to use irqdomain
Date: Tue, 10 Dec 2013 09:20:50 +0000
Message-ID: <20131210092050.GT12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-11-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386606085-26838-11-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

PiBJbnRyb2R1Y2UgYW4gaXJxX2NoaXAgYW5kIGlycV9kb21haW4gZm9yIG1lbmVsYXVzIGRyaXZl
ci4gRm9sbG93aW5nCj4gcGF0Y2hlcyB3aWxsIGNvbnZlcnQgdXNlcyB0byB0cmFkaXRpb25hbCBy
ZXF1ZXN0X3RocmVhZGVkX2lycSgpLgo+IAo+IFdoaWxlIGF0IHRoYXQsIHNvbWUgYmV0dGVyIGVy
cm9yIGhhbmRsaW5nIGhhZCB0byBiZSBhZGRlZCwgc28gd2UgY291bGQKPiBmcmVlIGlycSBkZXNj
cyB3ZSBhbGxvY2F0ZWQuCj4gCj4gVGVzdGVkLWJ5OiBBYXJvIEtvc2tpbmVuIDxhYXJvLmtvc2tp
bmVuQGlraS5maT4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQmFsYmkgPGJhbGJpQHRpLmNvbT4K
PiAtLS0KPiAgZHJpdmVycy9tZmQvbWVuZWxhdXMuYyB8IDEyNyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCgo8c25pcD4KCj4gKwlpcnFfZG9tYWluX2Fk
ZF9sZWdhY3kobm9kZSwgTUVORUxBVVNfTlJfSVJRUywgaXJxX2Jhc2UsIDAsCj4gKwkJCSZpcnFf
ZG9tYWluX3NpbXBsZV9vcHMsIG0pOwoKV2hlbiB3aWxsIHRoaXMgZHJpdmVyIGJlY29tZSBEVCBj
b21wbGlhbnQ/CgpJIHRoaW5rIHlvdSBzaG91bGQgdXNlIGlycV9kb21haW5fYWRkX3NpbXBsZSgp
IHRvIGZ1dHVyZSBwcm9vZgp5b3Vyc2VsZiBhIGxpdHRsZS4KCj4gKwltLT5pcnFfYmFzZSA9IGly
cV9iYXNlOwo+ICsKPiArCWZvciAoaSA9IGlycV9iYXNlOyBpIDwgaXJxX2Jhc2UgKyBNRU5FTEFV
U19OUl9JUlFTOyBpKyspIHsKPiArCQlpcnFfc2V0X2NoaXBfZGF0YShpLCBtKTsKPiArCQlpcnFf
c2V0X2NoaXBfYW5kX2hhbmRsZXIoaSwgJm1lbmVsYXVzX2lycV9jaGlwLAo+ICsJCQkJaGFuZGxl
X3NpbXBsZV9pcnEpOwo+ICsJCWlycV9zZXRfbmVzdGVkX3RocmVhZChpLCAxKTsKPiArCQlzZXRf
aXJxX2ZsYWdzKGksIElSUUZfVkFMSUQpOwoKVGhpcyBhc3N1bWVzIHRoYXQgdGhpcyBoL3cgb25s
eSBleGlzdHMgb24gQVJNIHBsYXRmb3Jtcy4gSXMgdGhhdCB0cnVlPwoKPiArCX0KClRoaXMgaXMg
dXN1YWxseSBjb21wbGV0ZWQgaW4gYW4gKl9pcnFfbWFwKCkgb3BlcmF0aW9uIGNhbGwtYmFjay4K
CkkgY2FuJ3Qgc2VlIHdoZXJlIHlvdSByZXZlcnNlIHRoaXMgcHJvY2VzcyBlaXRoZXIgKHVzdWFs
bHkgKl9pcnFfdW5tYXAoKSkKCjxzbmlwPgoKPiAtCW11dGV4X2luaXQoJm0tPmxvY2spOwo+IC0K
ClRoaXMgZG9lc24ndCBiZWxvbmcgaW4gdGhpcyBwYXRjaC4KCkl0IHNob3VsZCBoYXZlIGJlZW4g
cmVtb3ZlZCB3aXRoIHRoZSBmaW5hbCB1c2Ugb2YgdGhlIGxvY2sgd2FzLgoKPHNuaXA+CgotLSAK
TGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGlu
YXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5h
cm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
