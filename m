From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
Date: Fri, 1 Jun 2018 17:10:26 +0200
Message-ID: <CAK8P3a1O=pbmeNxWNmU9UHjnBVwJXUjTuxRudTZ3OHBdbiVv9A@mail.gmail.com>
References: <20180530214938.1073749-1-arnd@arndb.de>
 <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCBNYXkgMzEsIDIwMTggYXQgODowNCBBTSwgQW5keSBTaGV2Y2hlbmtvCjxhbmR5LnNo
ZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToKPiBPbiBUaHUsIE1heSAzMSwgMjAxOCBhdCAxMjo0
OSBBTSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6Cj4KPj4gZHJpdmVycy92
aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvZHNzL2hkbWk1LmM6IEluIGZ1bmN0aW9uICdoZG1pX3By
b2JlX29mJzoKPj4gZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvZHNzL2hkbWk1LmM6
NTg0OjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnb2Zfbm9kZV9w
dXQnOyBkaWQgeW91IG1lYW4gJ25vZGVfc2V0Jz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCj4+IGRyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9oZG1p
NC5jOiBJbiBmdW5jdGlvbiAnaGRtaV9wcm9iZV9vZic6Cj4+IGRyaXZlcnMvdmlkZW8vZmJkZXYv
b21hcDIvb21hcGZiL2Rzcy9oZG1pNC5jOjU1NDoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24gJ29mX25vZGVfcHV0JzsgZGlkIHlvdSBtZWFuICdub2RlX3NldCc/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+Cj4+IFJhdGhlciB0aGFuIGZp
eGluZyB1cCBlYWNoIG9uZSBpbmRpdmlkdWFsbHksIHRoaXMganVzdCBtYXJrcyBhbGwgb2YgaXQK
Pj4gYXMgZGVwZW5kaW5nIG9uIEdQSU9MSUIuCj4KPiBIbW0uLi4gQnV0IHRoZSBPRiBzdHVmZiBp
cyBub3QgcGFydCBvZiBHUElPTElCLgoKVGhlIHVuZGVybHlpbmcgaXNzdWUgaXMgdGhlIHNhbWUg
dGhvdWdoOiBsaW51eC9ncGlvLmggaW5jbHVkZXMgYQpkaWZmZXJlbnQgc2V0IG9mIGhlYWRlciBm
aWxlcwpkZXBlbmRpbmcgb24gQ09ORklHX0dQSU9MSUIgYmVpbmcgc2V0IG9yIG5vdC4gV2l0aG91
dCBpdCwgd2UgYXJlIG1pc3NpbmcgYWxsIHRoZQppbmRpcmVjdCBpbmNsdWRlcyBmcm9tIGFzbS1n
ZW5lcmljL2dwaW8uaCB0aGF0IGluY2x1ZGUgbGludXgvb2YuaCBhbmQKbGludXgvZ3Bpby9jb25z
dW1lci5oLgoKICAgICAgICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
