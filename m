From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] omapfb: reduce stack usage
Date: Sat, 19 Oct 2019 10:11:54 +0100
Message-ID: <20191019091154.qlmb7abqoqdmtz7f@debian>
References: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
 <20191018172728.GA11857@lenoch>
 <20191018223012.tkpwbo3mg5mthlnz@debian>
 <184cdd47d4064420b05c16f10588595c65f789e5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <184cdd47d4064420b05c16f10588595c65f789e5.camel@perches.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gRnJpLCBPY3QgMTgsIDIwMTkgYXQgMDY6MTk6MTVQTSAtMDcwMCwgSm9lIFBlcmNoZXMgd3Jv
dGU6Cj4gT24gRnJpLCAyMDE5LTEwLTE4IGF0IDIzOjMwICswMTAwLCBTdWRpcCBNdWtoZXJqZWUg
d3JvdGU6Cj4gPiBPbiBGcmksIE9jdCAxOCwgMjAxOSBhdCAwNzoyNzoyOFBNICswMjAwLCBMYWRp
c2xhdiBNaWNobCB3cm90ZToKPiA+ID4gT24gRnJpLCBPY3QgMTgsIDIwMTkgYXQgMDU6MzA6MDRQ
TSArMDEwMCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOgo+ID4gPiA+IFRoZSBidWlsZCBvZiB4dGVu
c2EgYWxsbW9kY29uZmlnIGlzIGdpdmluZyBhIHdhcm5pbmcgb2Y6Cj4gPiA+ID4gSW4gZnVuY3Rp
b24gJ2RzaV9kdW1wX2RzaWRldl9pcnFzJzoKPiA+ID4gPiB3YXJuaW5nOiB0aGUgZnJhbWUgc2l6
ZSBvZiAxMTIwIGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMKPHNuaXA+Cj4gCj4gV2l0
aG91dCB5b3VyIHBhdGNoOgo+IAo+ICQgb2JqZHVtcCAteCBkcml2ZXJzL3ZpZGVvL2ZiZGV2L29t
YXAyL29tYXBmYi9kc3MvZHNpLm8gfCBncmVwIGRzaV9kdW1wX2RzaWRldl9pcnFzCj4gMDAwMDBk
MjAgbCAgICAgRiAudGV4dAkwMDAwMDYxYyBkc2lfZHVtcF9kc2lkZXZfaXJxcwo+IAo+IFdpdGgg
eW91ciBwYXRjaDoKPiAKPiAkIG9iamR1bXAgLXggZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9v
bWFwZmIvZHNzL2RzaS5vIHwgZ3JlcCBkc2lfZHVtcF9kc2lkZXZfaXJxcwo+IDAwMDAwZDIwIGwg
ICAgIEYgLnRleHQJMDAwMDA2MzggZHNpX2R1bXBfZHNpZGV2X2lycXMKCkkgZGlkIG9iamR1bXAg
LWQgYW5kIHRoZW4gY29tcGFyZWQgd2hlcmUgaXQgc3RhcnRlZCBhbmQgd2hlcmUgaXQgZW5kZWQu
CgpCdXQsIGluIGFueWNhc2UsIHRoaXMgZHJpdmVyIGlzIGZyYW1lYnVmZmVyIGRyaXZlciBmb3Ig
b21hcDIgYW5kIGluCnJlYWxpdHksIGNhbiBvbmx5IGJlIHVzZWQgb24gYXJtIHBsYXRmb3JtIGFu
ZCB3aGVuIEkgYnVpbGQgdGhlIGRyaXZlcgp3aXRoIGFybSBjb21waWxlciBJIGFtIG5vdCBnZXR0
aW5nIHRoaXMgd2FybmluZy4gVGhpcyBpcyBub3QgYSB2YWxpZApjb25jZXJuLCBwbGVhc2UgcmVq
ZWN0IHRoaXMgcGF0Y2guCgotLQpSZWdhcmRzClN1ZGlwCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
