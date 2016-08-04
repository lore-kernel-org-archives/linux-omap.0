From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] backlight: Avoid double fbcon backlight
 handling
Date: Thu, 4 Aug 2016 10:57:29 +0100
Message-ID: <20160804095729.GN12611@nuc-i3427.alporthouse.com>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
 <20160712122119.GR23520@phenom.ffwll.local>
 <87a8gsq540.fsf@intel.com>
 <20160804095027.GB6232@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160804095027.GB6232@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hennerich@analog.com>, intel-gfx@lists.f
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCBBdWcgMDQsIDIwMTYgYXQgMTE6NTA6MjdBTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBUaHUsIEF1ZyAwNCwgMjAxNiBhdCAxMjowMjoyM1BNICswMzAwLCBKYW5pIE5p
a3VsYSB3cm90ZToKPiA+IE9uIFR1ZSwgMTIgSnVsIDIwMTYsIERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgSnVuIDMwLCAyMDE2IGF0IDEyOjMwOjU2
UE0gKzAxMDAsIENocmlzIFdpbHNvbiB3cm90ZToKPiA+ID4+IEJhY2tsaWdodHMgY29udHJvbGxl
ZCBieSBpOTE1LmtvIGFuZCBvbmx5IGFzc29jaWF0ZWQgd2l0aCBpdHMgY29ubmVjdG9ycwo+ID4g
Pj4gYW5kIGFsc28gb25seSBhc3NvY2lhdGVkIHdpdGggdGhlIGludGVsX2RybWZiIGZiY29uLCBj
b250cm9sbGVkIGJ5Cj4gPiA+PiBpOTE1LmtvLiBJbiB0aGlzIHNpdHVhdGlvbiwgd2UgYWxyZWFk
eSBoYW5kbGUgYWRqdXN0aW5nIHRoZSBiYWNrbGlnaHQKPiA+ID4+IHdoZW4gdGhlIGZiY29uIGlz
IGJsYW5rZWQvdW5ibGFua2VkIGFuZCBkbyBub3QgcmVxdWlyZSBiYWNrbGlnaHQgdHJ5aW5nCj4g
PiA+PiB0byBkbyB0aGUgc2FtZS4KPiA+ID4+IAo+ID4gPj4gQXR0ZW1wdGluZyB0byByZWdpc3Rl
ciB3aXRoIHRoZSBmYmRldiBhcyBhIGNsaWVudCBjYXVzZXMgbG9ja2RlcCB0byB3YXJuCj4gPiA+
PiBhYm91dCBhIGRlcGVuZGVuY3kgY3ljbGU6Cj4gPiA+Cj4gPiA+IFRoZSBmYmRldiBub3RpZmll
ciBzdHJpa2VzIGFnYWluIQo+ID4gPgo+ID4gPiBMYXN0IHRpbWUgSSBsb29rZWQgaW50byB0aGlz
IEkgdGhpbmsgdGhlIHByb3BlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBzcGxpdAo+ID4gPiB0aGUg
YmFja2xpZ2h0IHBhcnQgZnJvbSB0aGUgb3RoZXIgZmJkZXYgbm90aWZpZXIgKHdoaWNoIGlzIHVz
ZWQgYnkgZmJjb24KPiA+ID4gZm9yIHJlYWN0aW5nIHRvIGZiZGV2IGRldmljZSByZWcvdW5yZWcg
ZXZlbnRzKS4KPiA+ID4KPiA+ID4gSSB0aGluayB0aGF0IHdvdWxkIGZpeCB0aGlzIHRvbywgd2l0
aCB0aGUgYWRkZWQgYm9udXMgb2Ygc2xpZ2h0bHkKPiA+ID4gdW50YW5nbGluZyB0aGUgZmJjb24g
bG9ja2luZyBtZXNzLiBBbmQgaXQncyBhbHNvIHRoZSBvbmUgcGFydCBvZgo+ID4gPiB1bnRhbmds
aW5nIHRoaXMgbWVzcyB3aGljaCBzaG91bGQgYmUgcG9zc2libGUgd2l0aG91dCBhbnkgdHJvdWJs
ZSAtIEkndmUKPiA+ID4gc2ltcGx5IG5ldmVyIGRvbmUgaXQgc2luY2UgZW50aXJlbHkgZ2V0dGlu
ZyByaWQgb2YgdGhlIGZiZGV2IG5vdGlmaWVyIGZvcgo+ID4gPiBmYmNvbiBpcyBhIGxvdCBtb3Jl
IHdvcmsuCj4gPiAKPiA+IFNvIHdoYXQgZG8gd2UgZG8gd2l0aCB0aGlzPyBJdCBmaXhlcyBhIHBy
b2JsZW0gdXBzdHJlYW0uIFRoZXJlJ3Mgbm8KPiA+IEZpeGVzOiB0byBpZGVudGlmeSB0aGUgYmFk
IGNvbW1pdC4gQW55IGlkZWEgb24gdGhhdD8gSXQncyBlaXRoZXIgdGhpcyBvcgo+ID4gd2UgZGln
IG91dCB0aGUgYmFkIGNvbW1pdCAoQ2hyaXMgcHJvYmFibHkga25vd3Mgd2hpY2ggb25lPykgYW5k
IHJldmVydC4KPiAKPiBUaGUgcmVhbCB0cm91YmxlIGlzIHRoZSBkcm1fZm9yX2VhY2hfY29ubmVj
dG9yIGluCj4gZHJtX2Nvbm5lY3Rvcl9yZWdpc3Rlcl9hbGwoKS4gVGhpcyBpbnRyb2R1Y2VkIHRo
ZSBuZXcgZGVwZW5jeS4gVGhlIHByb3Blcgo+IGZpeCBpbW8gaXMgdG8gZml4IHVwIHRoZSBjb25u
ZWN0b3JfbGlzdCBsb2NraW5nLCBidXQgZm9yIDQuOCB3ZSBjb3VsZCBkbwo+IHRoZSBzYW1lIGhh
Y2srY29tbWVudCBsaWtlIHdlIGRvIGluIHVucmVnaXN0ZXJfYWxsLiBJdCdzIG5vdCB0aGUgb25s
eQo+IHBsYWNlIHRoYXQncyBicm9rZW4gYW55d2F5LCBhbmQgbXVjaCBsZXNzIGludmFzaXZlIHRo
YW4gdGhpcyBoZXJlLgoKWW91IHN0aWxsIGhhdmUgdGhlIHVuZGVybHlpbmcgaXNzdWUgb2YgbXVs
dGlwbGUgZHJpdmVycyB0cnlpbmcgdG8KY29udHJvbCB0aGUgc2FtZSBwaWVjZSBvZiBoYXJkd2Fy
ZSwgY2F1c2luZyBkdXBsaWNhdGUgd29yayAoYXQgYmVzdCkuCi1DaHJpcwoKLS0gCkNocmlzIFdp
bHNvbiwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50cmUKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJ
bnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
