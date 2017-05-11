From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Thu, 11 May 2017 07:16:33 -0700
Message-ID: <20170511141632.GR3489@atomide.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
 <67e56914-0075-8009-7013-f0cf69001749@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <67e56914-0075-8009-7013-f0cf69001749@ti.com>
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

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTcwNTExIDAxOjM3XToK
PiBPbiAxMC8wNS8xNyAyMToyOSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiA+ICogVG9taSBWYWxr
ZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4gWzE3MDUxMCAxMDo0NF06Cj4gPj4KPiA+Pgo+
ID4+IE9uIDEwLzA1LzE3IDE5OjQ2LCBUb255IExpbmRncmVuIHdyb3RlOgo+ID4+PiAqIFRvbWkg
VmFsa2VpbmVuIDx0b21pLnZhbGtlaW5lbkB0aS5jb20+IFsxNzA1MTAgMDA6MjZdOgo+ID4+Pj4g
T24gMDkvMDUvMTcgMTg6MDUsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+ID4+Pj4KPiA+Pj4+
PiBwYXRjaCAxMDoKPiA+Pj4+PiBJIHRoaW5rIGRzaSBwaW4gbXV4aW5nIHNob3VsZCBiZSBkb25l
IGJ5IHByb3ZpZGluZyBwaW5tdXgKPiA+Pj4+PiBpbmZvIHZpYSBEVC4KPiA+Pj4+Cj4gPj4+PiBV
bmZvcnR1bmF0ZWx5IHRoZXJlJ3Mgbm8gcGlubXV4IGRyaXZlciBmb3IgdGhlIGtpbmQgb2YgcmVn
aXN0ZXIgd2UgaGF2ZQo+ID4+Pj4gZm9yIERTSS4gQXQgbGVhc3QgdGhpcyB3YXMgdGhlIGNhc2Ug
bm90IHRoYXQgbG9uZyBhZ28uCj4gPj4+Cj4gPj4+IFdoYXQgYXJlIHRoZSBUUk0gbmFtZXMgZm9y
IHRoZSByZWdpc3RlcnMgeW91IG5lZWQgdG8gbXV4Pwo+ID4+Cj4gPj4gQ09OVFJPTF9EU0lQSFkK
PiA+IAo+ID4gT2gganVzdCBvbmUgcmVnaXN0ZXIgd2l0aCBmZXcgYml0cz8gVGhhdCBzaG91bGQg
YmUgZG9hYmxlIGluCj4gPiBkdHMgd2l0aCBwaW5jdHJsLXNpbmdsZSxiaXQtcGVyLW11eCBhbmQg
cGluY3RybC1zaW5nbGUsYml0cy4KPiAKPiBObywgSSBkb24ndCB0aGluayBpdCB3b3Jrcy4gT3Ig
YXQgbGVhc3QgSSBjYW4ndCBmaWd1cmUgb3V0IGhvdy4KPiAKPiBwaW5jdHJsLXNpbmdsZSBkb2Vz
bid0IGFsbG93IHRvIGZyZWVseSBzZXQgdGhlIGJpdHMsIGJ1dCByZXF1aXJlcyB0aGUKPiBwaW5z
IHRvIGhhdmUgc2ltaWxhciBiaXQgc3RydWN0dXJlIChmdW5jdGlvbi1tYXNrKS4gSW4gQ09OVFJP
TF9EU0lQSFksCj4gRFNJMSBhbmQgRFNJMiBoYXZlIGRpZmZlcmVudCBiaXQgc3RydWN0dXJlcy4K
Ck9LIGlmIHRoZSByZWdpc3RlciBtaXhlcyBkaWZmZXJlbnQgdHlwZXMgb2YgY29udHJvbGxlcnMg
dGhhdApjYW4ndCBiZSBwYXJ0aXRpb25lZCBpbnRvIHNlcGFyYXRlIDggb3IgMTYgYml0IGluc3Rh
bmNlcyB0aGVuCnlvdSdyZSBvdXQgb2YgbHVjayB3aXRoIHBpbmN0cmwtc2luZ2xlLiBJZiBpdCBk
b2VzIG5vdCBmaXQsIG5vCnBvaW50IHRyeWluZyB0byBmb3JjZSBpdCwgdGhlbiB5b3UgbmVlZCBh
IGN1c3RvbSBwaW5jdHJsIGRyaXZlci4KCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBwaW5jdHJs
LXNpbmdsZSB0cmllcyBzbyBoYXJkIHRvIGZpdCB0aGluZ3MgaW50bwo+IG9uZSBtb2xkLi4uCgpC
YXNpY2FsbHkgb24gbWFueSBTb0NzIHBpbmN0cmwgaXMganVzdCB0aGUgc2FtZSBleGFjdCBjb250
cm9sCnJlZ2lzdGVyIHJlcGVhdGVkIGZvciBlYWNoIHBpbiBvbiB0aGUgU29DOgoKJCBnaXQgZ3Jl
cCAnInBpbmN0cmwtc2luZ2xlIicgYXJjaC9hcm0qL2Jvb3QvZHRzIHwgc29ydCB8IHVuaXEgfCB3
YyAtbAoyMAoKUmVnYXJkcywKClRvbnkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
