From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6] support for AD5820 camera auto-focus coil
Date: Wed, 14 Dec 2016 07:08:19 -0800
Message-ID: <20161214150819.GW4920@atomide.com>
References: <20160521054336.GA27123@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160808214132.GB2946@xo-6d-61-c0.localdomain>
 <201612141438.16603@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201612141438.16603@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-media@vger.kernel.org, khilman@kernel.org, mchehab@osg.samsung.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

KiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+IFsxNjEyMTQgMDU6MzhdOgo+IE9u
IE1vbmRheSAwOCBBdWd1c3QgMjAxNiAyMzo0MTozMiBQYXZlbCBNYWNoZWsgd3JvdGU6Cj4gPiBP
biBNb24gMjAxNi0wOC0wOCAxMTowOTo1NiwgU2FrYXJpIEFpbHVzIHdyb3RlOgo+ID4gPiBPbiBG
cmksIEF1ZyAwNSwgMjAxNiBhdCAxMjoyNjoxMVBNICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6
Cj4gPiA+ID4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIEFENTgyMCBhdXRvZm9jdXMgY29pbCwgZm91
bmQgZm9yIGV4YW1wbGUgaW4KPiA+ID4gPiBOb2tpYSBOOTAwIHNtYXJ0cGhvbmUuCj4gPiA+IAo+
ID4gPiBUaGFua3MsIFBhdmVsIQo+ID4gPiAKPiA+ID4gTGV0J3MgdXNlIFY0TDJfQ0lEX0ZPQ1VT
X0FCU09MVVRFLCBhcyBpcyBpbiB0aGUgcGF0Y2guIElmIHdlIGdldAo+ID4gPiBzb21ldGhpbmcg
YmV0dGVyIGluIHRoZSBmdXR1cmUsIHdlJ2xsIHN3aXRjaCB0byB0aGF0IHRoZW4uCj4gPiA+IAo+
ID4gPiBJJ3ZlIGFwcGxpZWQgdGhpcyB0byBhZDU4MjAgYnJhbmNoIGluIG15IHRyZWUuCj4gPiAK
PiA+IFRoYW5rcy4gSWYgSSB1bmRlcnN0YW5kcyB0aGluZ3MgY29ycmVjdGx5LCBib3RoIERUUyBw
YXRjaCBhbmQgdGhpcwo+ID4gcGF0Y2ggYXJlIHdhaXRpbmcgaW4geW91ciB0cmVlLCBzbyB3ZSBz
aG91bGQgYmUgZ29vZCB0byBnbyBmb3IgNC45Cj4gPiAodW5sZXNzIHNvbWUgdW5leHBlY3RlZCBw
cm9ibGVtcyBzdXJmYWNlKT8KPiA+IAo+ID4gQmVzdCByZWdhcmRzLAo+ID4gCQkJCQkJCQkJUGF2
ZWwKPiAKPiBXYXMgRFRTIHBhdGNoIG1lcmdlZCBpbnRvIDQuOT8gQXQgbGVhc3QgSSBkbyBub3Qg
c2VlIHVwZGF0ZWQgdGhhdCBkdHMgCj4gZmlsZSBvbWFwMy1uOTAwLmR0cyBpbiBsaW51cyB0cmVl
Li4uCgpJZiBpdCdzIG5vdCBpbiBjdXJyZW50IG1haW5saW5lIG9yIG5leHQsIGl0J3Mgb2ZmIG15
IHJhZGFyIHNvIHNvdW5kcwpsaWtlIEkndmUgc29tZWhvdyBtaXNzZWQgaXQgYW5kIG5lZWRzIHJl
c2VuZGluZy4uCgpUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
