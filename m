From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: drm_kms_helper cycle detected build error in next
Date: Mon, 16 Oct 2017 11:16:49 +0200
Message-ID: <20171016091649.zm5mlsa64qmf6n7k@phenom.ffwll.local>
References: <20171013145818.GG4394@atomide.com>
 <20171013150935.GH4394@atomide.com>
 <66e0cbe7-5706-4981-e06d-ce85c779e120@ti.com>
 <CAPM=9tygNrNqmYncO0uyyz=TQy8XcBaGdjWXcEAWW129DNMqyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tygNrNqmYncO0uyyz=TQy8XcBaGdjWXcEAWW129DNMqyA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBPY3QgMTYsIDIwMTcgYXQgMDU6MTU6NTBQTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gT24gMTYgT2N0b2JlciAyMDE3IGF0IDE2OjUzLCBUb21pIFZhbGtlaW5lbiA8dG9taS52
YWxrZWluZW5AdGkuY29tPiB3cm90ZToKPiA+Cj4gPiBUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5k
IE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4gWS10dW5udXMvQnVzaW5lc3Mg
SUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKPiA+Cj4gPiBPbiAx
My8xMC8xNyAxODowOSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiA+Cj4gPj4+IExvb2tzIGxpa2Ug
dG9kYXkncyBuZXh0IGJ1aWxkIGZhaWxzIGlmIG9tYXBkcm0gaXMgZW5hYmxlZCBhcyBtb2R1bGVz
Cj4gPj4+IHdpdGg6Cj4gPj4+Cj4gPj4+IGRlcG1vZDogRVJST1I6IEN5Y2xlIGRldGVjdGVkOiBk
cm1fa21zX2hlbHBlciAtPiBkcm0gLT4gZHJtX2ttc19oZWxwZXIKPiA+Pj4gZGVwbW9kOiBFUlJP
UjogRm91bmQgMiBtb2R1bGVzIGluIGRlcGVuZGVuY3kgY3ljbGVzIQo+ID4+PiBtYWtlOiAqKiog
W01ha2VmaWxlOjEyNjE6IF9tb2RpbnN0X3Bvc3RdIEVycm9yIDEKPiA+Pgo+ID4+IE1ha2luZyBD
T05GSUdfRFJNPXkgYW5kIENPTkZJR19EUk1fS01TX0hFTFBFUj15IGluc3RlYWQgb2YKPiA+PiBs
b2RhYmxlIG1vZHVsZXMgbWFrZXMgaXQgYnVpbGQuCj4gPgo+ID4gVGhlIHNhbWUgaGFwcGVucyBl
dmVuIGFmdGVyIGRpc2FibGluZyBvbWFwZHJtLCBzbyBpdCdzIHNvbWV3aGVyZSBpbiB0aGUKPiA+
IGNvbW1vbiBjb2RlLgo+ID4KPiA+IEludGVyZXN0aW5nbHksIG15IGRlcG1vZCBjcmFzaGVzIHdo
ZW4gZW5jb3VudGVyaW5nIHRoaXMuCj4gCj4gVGhlcmUgaXMgYSBmaXggZm9yIHRoaXMgaW4gZHJt
LW1pc2MsIEkgc2hvdWxkIHByb2JhYmx5IHB1bGwgaXQgb3Zlci4KPiAKPiBJZiBJIGhhdmVuJ3Qg
YmVlbiBzZW50IGEgcHVsbCB0b21vcnJvdywgSSdsbCBncmFiIGl0LgoKWW91J3JlIHRvbyBtdWNo
IGFoZWFkIGZvciBhIHB1bGwgcmVxdWVzdCBvbiB5b3VyIE1vbmRheSwgYnV0IHlvdSdsbCBnZXQg
aXQKYXNhcCA6LSkKCkNoZWVycywgRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVu
Z2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
