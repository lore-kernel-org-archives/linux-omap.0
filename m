From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH 4/5] drm/panel: tpo-td028ttec1: Fix SPI
 alias
Date: Mon, 7 Oct 2019 19:58:49 +0200
Message-ID: <20191007195849.72562d6b@aktux>
References: <20191007170801.27647-1-laurent.pinchart@ideasonboard.com>
 <20191007170801.27647-5-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191007170801.27647-5-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, thierry.reding@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, sam@ravnborg.org
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCAgNyBPY3QgMjAxOSAyMDowODowMCArMDMwMApMYXVyZW50IFBpbmNoYXJ0IDxsYXVy
ZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+IHdyb3RlOgoKPiBUaGUgcGFuZWwtdHBvLXRk
MDI4dHRlYzEgZHJpdmVyIGluY29ycmVjdGx5IGluY2x1ZGVzIHRoZSBPRiB2ZW5kb3IKPiBwcmVm
aXggaW4gaXRzIFNQSSBhbGlhcy4gRml4IGl0Lgo+IAo+IEZpeGVzOiA0MTViOGRkMDg3MTEgKCJk
cm0vcGFuZWw6IEFkZCBkcml2ZXIgZm9yIHRoZSBUb3Bwb2x5IFREMDI4VFRFQzEgcGFuZWwiKQo+
IFJlcG9ydGVkLWJ5OiBILiBOaWtvbGF1cyBTY2hhbGxlciA8aG5zQGdvbGRlbGljby5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPgoKVGVzdGVkLWJ5OiBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5p
bmZvPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXRwby10ZDAyOHR0ZWMx
LmMgfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC10cG8tdGQw
Mjh0dGVjMS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXRwby10ZDAyOHR0ZWMxLmMK
PiBpbmRleCBkN2IyZTM0NjI2ZWYuLmYyYmFmZjgyN2Y1MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcGFuZWwvcGFuZWwtdHBvLXRkMDI4dHRlYzEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9wYW5lbC9wYW5lbC10cG8tdGQwMjh0dGVjMS5jCj4gQEAgLTM3NSw4ICszNzUsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB0ZDAyOHR0ZWMxX29mX21hdGNoW10gPSB7
Cj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHRkMDI4dHRlYzFfb2ZfbWF0Y2gpOwo+ICAKPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIHRkMDI4dHRlYzFfaWRzW10gPSB7Cj4g
LQl7ICJ0cG8sdGQwMjh0dGVjMSIsIDB9LAo+IC0JeyAidG9wcG9seSx0ZDAyOHR0ZWMxIiwgMCB9
LAo+ICsJeyAidGQwMjh0dGVjMSIsIDAgfSwKPiAgCXsgLyogc2VudGluZWwgKi8gfQo+ICB9Owo+
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
