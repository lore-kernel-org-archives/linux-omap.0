From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 4/5] drm/panel: tpo-td028ttec1: Fix SPI
 alias
Date: Mon, 7 Oct 2019 21:33:29 +0200
Message-ID: <4524D803-D5C8-4201-B1B3-7EB88FE1460C@goldelico.com>
References: <20191007170801.27647-1-laurent.pinchart@ideasonboard.com>
 <20191007170801.27647-5-laurent.pinchart@ideasonboard.com>
 <20191007195849.72562d6b@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191007195849.72562d6b@aktux>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, thierry.reding@gmail.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, sam@ravnborg.org
List-Id: linux-omap@vger.kernel.org

Cj4gQW0gMDcuMTAuMjAxOSB1bSAxOTo1OCBzY2hyaWViIEFuZHJlYXMgS2VtbmFkZSA8YW5kcmVh
c0BrZW1uYWRlLmluZm8+Ogo+IAo+IE9uIE1vbiwgIDcgT2N0IDIwMTkgMjA6MDg6MDAgKzAzMDAK
PiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+IHdy
b3RlOgo+IAo+PiBUaGUgcGFuZWwtdHBvLXRkMDI4dHRlYzEgZHJpdmVyIGluY29ycmVjdGx5IGlu
Y2x1ZGVzIHRoZSBPRiB2ZW5kb3IKPj4gcHJlZml4IGluIGl0cyBTUEkgYWxpYXMuIEZpeCBpdC4K
Pj4gCj4+IEZpeGVzOiA0MTViOGRkMDg3MTEgKCJkcm0vcGFuZWw6IEFkZCBkcml2ZXIgZm9yIHRo
ZSBUb3Bwb2x5IFREMDI4VFRFQzEgcGFuZWwiKQo+PiBSZXBvcnRlZC1ieTogSC4gTmlrb2xhdXMg
U2NoYWxsZXIgPGhuc0Bnb2xkZWxpY28uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBp
bmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+Cj4gCj4gVGVzdGVkLWJ5
OiBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5pbmZvPgpUZXN0ZWQtYnk6IEguIE5p
a29sYXVzIFNjaGFsbGVyIDxobnNAZ29sZGVsaWNvLmNvbT4KPiAKPj4gLS0tCj4+IGRyaXZlcnMv
Z3B1L2RybS9wYW5lbC9wYW5lbC10cG8tdGQwMjh0dGVjMS5jIHwgMyArLS0KPj4gMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC10cG8tdGQwMjh0dGVjMS5jIGIvZHJpdmVycy9n
cHUvZHJtL3BhbmVsL3BhbmVsLXRwby10ZDAyOHR0ZWMxLmMKPj4gaW5kZXggZDdiMmUzNDYyNmVm
Li5mMmJhZmY4MjdmNTAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5l
bC10cG8tdGQwMjh0dGVjMS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC10
cG8tdGQwMjh0dGVjMS5jCj4+IEBAIC0zNzUsOCArMzc1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgdGQwMjh0dGVjMV9vZl9tYXRjaFtdID0gewo+PiBNT0RVTEVfREVWSUNF
X1RBQkxFKG9mLCB0ZDAyOHR0ZWMxX29mX21hdGNoKTsKPj4gCj4+IHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc3BpX2RldmljZV9pZCB0ZDAyOHR0ZWMxX2lkc1tdID0gewo+PiAtCXsgInRwbyx0ZDAyOHR0
ZWMxIiwgMH0sCj4+IC0JeyAidG9wcG9seSx0ZDAyOHR0ZWMxIiwgMCB9LAo+PiArCXsgInRkMDI4
dHRlYzEiLCAwIH0sCj4+IAl7IC8qIHNlbnRpbmVsICovIH0KPj4gfTsKPj4gCj4gCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
