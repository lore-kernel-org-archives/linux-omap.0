From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Fri, 12 May 2017 08:03:49 -0700
Message-ID: <20170512150349.GF3489@atomide.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
 <67e56914-0075-8009-7013-f0cf69001749@ti.com>
 <20170511141632.GR3489@atomide.com>
 <4b7cadc5-f32b-f97f-29c3-a2de9927df6c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <4b7cadc5-f32b-f97f-29c3-a2de9927df6c@ti.com>
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

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTcwNTEyIDAwOjMyXToK
PiBPbiAxMS8wNS8xNyAxNzoxNiwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiAKPiA+PiBwaW5jdHJs
LXNpbmdsZSBkb2Vzbid0IGFsbG93IHRvIGZyZWVseSBzZXQgdGhlIGJpdHMsIGJ1dCByZXF1aXJl
cyB0aGUKPiA+PiBwaW5zIHRvIGhhdmUgc2ltaWxhciBiaXQgc3RydWN0dXJlIChmdW5jdGlvbi1t
YXNrKS4gSW4gQ09OVFJPTF9EU0lQSFksCj4gPj4gRFNJMSBhbmQgRFNJMiBoYXZlIGRpZmZlcmVu
dCBiaXQgc3RydWN0dXJlcy4KPiA+IAo+ID4gT0sgaWYgdGhlIHJlZ2lzdGVyIG1peGVzIGRpZmZl
cmVudCB0eXBlcyBvZiBjb250cm9sbGVycyB0aGF0Cj4gPiBjYW4ndCBiZSBwYXJ0aXRpb25lZCBp
bnRvIHNlcGFyYXRlIDggb3IgMTYgYml0IGluc3RhbmNlcyB0aGVuCj4gPiB5b3UncmUgb3V0IG9m
IGx1Y2sgd2l0aCBwaW5jdHJsLXNpbmdsZS4gSWYgaXQgZG9lcyBub3QgZml0LCBubwo+ID4gcG9p
bnQgdHJ5aW5nIHRvIGZvcmNlIGl0LCB0aGVuIHlvdSBuZWVkIGEgY3VzdG9tIHBpbmN0cmwgZHJp
dmVyLgo+IAo+IFdyaXRpbmcgYSBkcml2ZXIgZm9yIGEgc2luZ2xlIHJlZ2lzdGVyIG9uIGEgbGVn
YWN5IFNvQyBmZWVscyBsaWtlIGFuCj4gb3ZlcmtpbGwuLi4gQnV0IEkgZ3Vlc3MgYSBnZW5lcmlj
IHBpbmN0cmwgZHJpdmVyIHdoaWNoIGFsbG93cyBmcmVlCj4gd3JpdGVzIHRvIHJlZ2lzdGVycyB3
b3VsZCBkbyB0aGUgdHJpY2ssIGJ1dCwgdGhlbiBhZ2FpbiwgaWYgc28gZmFyIHdlCj4gaGF2ZSBh
IHNpbmdsZSByZWdpc3RlciBpbiBhIHNpbmdsZSBTb0MgdGhhdCBuZWVkcyB0aGlzLCBtYXliZSBp
dCdzIG5vdAo+IHdvcnRoIHRoZSBlZmZvcnQuCgpZZWFoLi4KCj4gPj4gSSBkb24ndCB1bmRlcnN0
YW5kIHdoeSBwaW5jdHJsLXNpbmdsZSB0cmllcyBzbyBoYXJkIHRvIGZpdCB0aGluZ3MgaW50bwo+
ID4+IG9uZSBtb2xkLi4uCj4gPiAKPiA+IEJhc2ljYWxseSBvbiBtYW55IFNvQ3MgcGluY3RybCBp
cyBqdXN0IHRoZSBzYW1lIGV4YWN0IGNvbnRyb2wKPiA+IHJlZ2lzdGVyIHJlcGVhdGVkIGZvciBl
YWNoIHBpbiBvbiB0aGUgU29DOgo+IAo+IFJpZ2h0LCBJIHdhcyBqdXN0IHdvbmRlcmluZyB3aHkg
aXQgZm9yY2VzIG9uZSB0byBoYXZlIGEgZnVuY3Rpb24gbWFzaywKPiB2ZXJzdXMgYWxsb3dpbmcg
aXQgdG8gYmUgbGVmdCBvdXQgYW5kIHRodXMgbWFraW5nIGl0IHBvc3NpYmxlIHRvIGhhbmRsZQo+
IGFsc28gY2FzZXMgd2hlcmUgdGhlIHBpbnMgcmVxdWlyZSBkaWZmZXJlbnQga2luZHMgb2YgYml0
IG1hc2tzLgoKU29tZSBvZiB0aGUgYml0cyBhcmUgbm90IHVzYWJsZSB0eXBpY2FsbHkuIEkgdGhp
bmsgd2hhdCB5b3UncmUKZGVzY3JpYmluZyBjb3VsZCBwcm9iYWJseSBiZSBkb25lIHdpdGggYSBj
dXN0b20gY29tcGF0aWJsZSBwbHVzCnN0cnVjdCBwY3Nfc29jX2RhdGEuCgpSZWdhcmRzLAoKVG9u
eQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
