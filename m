From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Wed, 10 May 2017 11:29:41 -0700
Message-ID: <20170510182940.GQ3489@atomide.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTcwNTEwIDEwOjQ0XToK
PiAKPiAKPiBPbiAxMC8wNS8xNyAxOTo0NiwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiA+ICogVG9t
aSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4gWzE3MDUxMCAwMDoyNl06Cj4gPj4g
T24gMDkvMDUvMTcgMTg6MDUsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+ID4+Cj4gPj4+IHBh
dGNoIDEwOgo+ID4+PiBJIHRoaW5rIGRzaSBwaW4gbXV4aW5nIHNob3VsZCBiZSBkb25lIGJ5IHBy
b3ZpZGluZyBwaW5tdXgKPiA+Pj4gaW5mbyB2aWEgRFQuCj4gPj4KPiA+PiBVbmZvcnR1bmF0ZWx5
IHRoZXJlJ3Mgbm8gcGlubXV4IGRyaXZlciBmb3IgdGhlIGtpbmQgb2YgcmVnaXN0ZXIgd2UgaGF2
ZQo+ID4+IGZvciBEU0kuIEF0IGxlYXN0IHRoaXMgd2FzIHRoZSBjYXNlIG5vdCB0aGF0IGxvbmcg
YWdvLgo+ID4gCj4gPiBXaGF0IGFyZSB0aGUgVFJNIG5hbWVzIGZvciB0aGUgcmVnaXN0ZXJzIHlv
dSBuZWVkIHRvIG11eD8KPiAKPiBDT05UUk9MX0RTSVBIWQoKT2gganVzdCBvbmUgcmVnaXN0ZXIg
d2l0aCBmZXcgYml0cz8gVGhhdCBzaG91bGQgYmUgZG9hYmxlIGluCmR0cyB3aXRoIHBpbmN0cmwt
c2luZ2xlLGJpdC1wZXItbXV4IGFuZCBwaW5jdHJsLXNpbmdsZSxiaXRzLgoKVGhlcmUgYXJlIGV4
YW1wbGVzIGluIHRoZSBrZXJuZWwgdHJlZToKCiQgZ2l0IGdyZXAgLWUgcGluY3RybC1zaW5nbGUs
Yml0cyAtZSBwaW5jdHJsLXNpbmdsZSxiaXQtcGVyLW11eCBcCglhcmNoL2FybS9ib290L2R0cwoK
UmVnYXJkcywKClRvbnkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
