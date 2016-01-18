From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] drm/i2c: tda998x: Choose between atomic or non atomic
 dpms helper
Date: Mon, 18 Jan 2016 11:15:05 +0000
Message-ID: <20160118111504.GG5783@n2100.arm.linux.org.uk>
References: <1452975474-17058-1-git-send-email-jsarha@ti.com>
 <20160118095226.GK13633@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160118095226.GK13633@e106497-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Liviu.Dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBKYW4gMTgsIDIwMTYgYXQgMDk6NTI6MjdBTSArMDAwMCwgTGl2aXUuRHVkYXVAYXJt
LmNvbSB3cm90ZToKPiBPbiBTYXQsIEphbiAxNiwgMjAxNiBhdCAxMDoxNzo1NFBNICswMjAwLCBK
eXJpIFNhcmhhIHdyb3RlOgo+ID4gSXQganVzdCBtYWtlcyBtZSB3b25kZXIgaWYgZHJtX2F0b21p
Y19oZWxwZXJfY29ubmVjdG9yX2RwbXMoKSBzaG91bGQKPiA+IGNhbGwgdGhlIGxlZ2FjeSBjYWxs
YmFjayBhdXRvbWF0aWNhbGx5IGlmIERSSVZFUl9BVE9NSUMgaXMgbm90IHNldCBvcgo+ID4gYXQg
bGVhc3QgYmFpbCBvdXQgZ3JhY2VmdWxseSB3aXRoIGFuIGVycm9yIG1lc3NhZ2UuIFRoZW4gYWdh
aW4gaXQgbWF5Cj4gPiBiZSBvdmVya2lsbCBpZiB0aGUgdGRhOTk4eCBpcyB0aGUgb25seSBkcml2
ZXIgdGhhdCBuZWVkIHRvIHN1cHBvcnQKPiA+IGJvdGggc2l0dWF0aW9ucy4KPiAKPiBJIHdvdWxk
IGd1ZXNzIHRoYXQgaW4gZ2VuZXJhbCBpdCBtYWtlcyBzZW5zZSBmb3IgdGhlIGNvcmUgY29kZSB0
byBkbyB3aGF0Cj4geW91IHN1Z2dlc3QsIGJ1dCB0aGUgaWRlYSBpcyB0byB0cnkgdG8gZW5jb3Vy
YWdlIHRoZSBkcml2ZXJzIHRvIGNvbnZlcnQKPiB0byBhdG9taWMgb3BzIHJhdGhlciB0aGFuIGdp
dmUgdGhlbSB0b28gbWFueSBjcnV0Y2hlcy4gQW5kIHRoZSB0ZGE5OTh4IHdpbGwKPiBuZWVkIHRo
aXMgZm9yIGEgc2hvcnQgcGVyaW9kIG9mIHRpbWUgdW50aWwgdGlsY2RjIGNvbnZlcnRzIGFzIHdl
bGwuCgpJdCdzIG5vdCBqdXN0IHRpbGNkYyB0aGF0IHRoaXMgZHJpdmVyIGlzIHVzZWQgYnkuCgpJ
IGhhdmUgbm8gcGxhbnMgYXQgcHJlc2VudCB0byBjb252ZXJ0IGFybWFkYSB0byBhdG9taWMgbW9k
ZSBzZXR0aW5nLAphbHRob3VnaCBJIG9jY2FzaW9uYWxseSBwdXNoIGl0IChJIGhvcGUpIHRvd2Fy
ZHMgdGhhdCBnb2FsLiAgVGhpcwppc24ndCBnb2luZyB0byBoYXBwZW4gcXVpY2tseSwgYmVjYXVz
ZSBJJ3ZlIG90aGVyIGFyZWFzIHRoYXQgbmVlZAp3b3JrIHRvby4KCi0tIApSTUsncyBQYXRjaCBz
eXN0ZW06IGh0dHA6Ly93d3cuYXJtLmxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8KRlRU
QyBicm9hZGJhbmQgZm9yIDAuOG1pbGUgbGluZTogY3VycmVudGx5IGF0IDkuNk1icHMgZG93biA0
MDBrYnBzIHVwCmFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0LgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
