From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Wed, 10 May 2017 01:18:58 +0300
Message-ID: <1872968.7fdiNycxOH@avalon>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SGkgVG9taSwKCk9uIFR1ZXNkYXkgMDkgTWF5IDIwMTcgMTU6MTA6NDAgVG9taSBWYWxrZWluZW4g
d3JvdGU6Cj4gT24gMDgvMDUvMTcgMTQ6MzIsIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6Cj4gPiBI
ZWxsbywKPiA+IAo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaXMgYSBzZWNvbmQsIGV4dGVuZGVkIHZl
cnNpb24gb2YgdGhlIGNvZGUgcHJldmlvdXNseQo+ID4gcG9zdGVkIGFzICJbUEFUQ0gvUkZDIDAv
N10gUmVtb3ZlIHRoZSBvbWFwZHJtIGRldmljZSBmcm9tIHBsYXRmb3JtIGNvZGUiLgo+IEFzIHRo
aXMgaXMgYSBsb25nIHNlcmllcywgSSdkIGxpa2UgdG8gcGljayBhIGJ1bmNoIG9mIHBhdGNoZXMg
ZnJvbSB0aGlzCj4gc2VyaWVzIGFscmVhZHk6Cj4gCj4gMS01LCA3LCAxOSwgMjEuCj4gCj4gSSBk
aWRuJ3QgdGVzdCB5ZXQsIGJ1dCBJIHRoaW5rIHRob3NlIHNob3VsZCBub3QgY2F1c2UgY29uZmxp
Y3RzIHdpdGggdGhlCj4gcmVzdCBvZiB0aGUgc2VyaWVzLgo+IAo+IEkgY2FuIHRoZW4gcHVzaCB0
aGUgYnJhbmNoLCB3aGljaCBjb250YWlucyBhbHNvIHRoZSBmZW5jZXMgYW5kIGNhY2hlCj4gcGF0
Y2hlcywgc28geW91IGNhbiBiYXNlIHRoZSByZXN0IG9uIHRoYXQuCj4gCj4gSXMgdGhpcyBvaz8K
ClBhdGNoIDIxIHdpbGwgY29uZmxpY3QsIHRoZSBvdGhlciBvbmVzIHNob3VsZG4ndC4gRm9yIHlv
dXIgY29udmVuaWVuY2UgSSd2ZSAKcGlja2VkIGFsbCB0aGUgUmV2aWV3ZWQtYnkgdGFncywgZml4
ZWQgYSB0eXBvIGluIHBhdGNoIDAxLzI4IHRoYXQgYnJva2UgCmNvbXBpbGF0aW9uLCByZWJhc2Vk
IHRoZSBwYXRjaGVzIHdpdGggMS01LCA3IGFuZCAxOSBtb3ZlZCB0byB0aGUgYmVnaW5uaW5nIG9m
IAp0aGUgc2VyaWVzLCB0ZXN0ZWQgdGhlIHJlc3VsdCBhbmQgcHVzaGVkIGl0IHRvCgoJZ2l0Oi8v
bGludXh0di5vcmcvcGluY2hhcnRsL21lZGlhLmdpdCBvbWFwZHJtL3BsYXRmb3JtCgpZb3UgY2Fu
IGp1c3QgcGljayB0aGUgNyBmaXJzdCBwYXRjaGVzIGZyb20gdGhlcmUuCgotLSAKUmVnYXJkcywK
CkxhdXJlbnQgUGluY2hhcnQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
