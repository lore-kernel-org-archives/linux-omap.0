From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: Alternative binding proposal for tda998x audio (Was: Re: [PATCH
 RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of ports)
Date: Tue, 1 Mar 2016 17:16:30 +0100
Message-ID: <20160301171630.630a47dc00060645f89bb8ab@free.fr>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk>
 <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk>
 <56D41F1A.2030100@ti.com> <56D5A6AA.2030907@ti.com>
 <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
 <56D5BA6D.8090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <56D5BA6D.8090904@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, peter.ujfalusi@ti.com, devicetree@vger.kernel.org, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCAxIE1hciAyMDE2IDE3OjUxOjA5ICswMjAwCkp5cmkgU2FyaGEgPGpzYXJoYUB0aS5j
b20+IHdyb3RlOgoKPiBJIGtub3cgdGhhdCBpdCB3b3JrcywgSSBoYXZlIHVzZWQgaXQgbXlzZWxm
IHVudGlsIG5vdywgYnV0IGl0IGlzIG5vdCAKPiBuZWVkZWQgYW5kIHRoZXJlIGlzIG5vIGRyaXZl
ciB0aGF0IHBhcnNlcyBhdWRpbyBwb3J0IGVuZHBvaW50cy4gSSBzZWUgbm8gCj4gcG9pbnQgc3Bl
Y2lmeWluZyBzb21ldGhpbmcgaW4gdGhlIGJpbmRpbmcgdGhhdCBpcyBub3QgdXNlZCBhbmQgdGhl
cmUgbm8gCj4gc3BlY2lmaWMgcGxhbiB0byBldmVyIHVzZSBpdC4KPiAKPiBBRkFJVSBteSBwcm9w
b3NlZCBiaW5kaW5nIHNob3VsZCB3b3JrIGVxdWFsbHkgd2VsbCB3aXRoIHNpbXBsZS1jYXJkLCAK
PiB3aXRoIG9yIHdpdGhvdXQgbXVsdGktY29kZWMgc3VwcG9ydC4KCkFzIHRvbGQgbWFueSB0aW1l
cywgdGhlIHNpbXBsZSBjYXJkIGlzIGEgcHVyZSBMaW51eCBzcGVjaWZpYyBlbnRpdHkuCkl0IGRv
ZXMgbm90IGRlc2NyaWJlIGFueSBoYXJkd2FyZS4gSXQgc2hvdWxkIG5vdCBhcHBlYXIgaW4gYSBE
VCwgb3IsCmlmIGl0IGRvZXMsIGl0cyBjb21wYXRpYmxlIHNob3VsZCBiZSAibGludXgsIHNpbXBs
ZS1hdWRpby1jYXJkIi4KVGhlbiwgaG93IGNhbiB0aGUgb3RoZXIgT1NzIGtub3cgdGhlIGxpbmtz
IGJldHdlZW4gdGhlIGF1ZGlvCmRldmljZXMgYW5kIHRoZSBhdWRpbyBlbmNvZGVycy9jb25uZWN0
b3JzPwoKT24gdGhlIG90aGVyIHdheSwgdGhlIGF1ZGlvIGdyYXBoIGRvZXMgbm90IGltcG9zZSBh
bnkgcGFydGljdWxhcgpzb2Z0d2FyZSBkZXNpZ24uIEl0IGp1c3QgZGVzY3JpYmVzIHRoZSBsaW5r
cyBiZXR3ZWVuIHRoZSBkaWZmZXJlbnQKaGFyZHdhcmUgY29tcG9uZW50cyBhbmQgZWFjaCBPUyBp
cyBmcmVlIHRvIGltcGxlbWVudCBpdHMgb3duIGxheW91dC4KCi0tIApLZW4gYXIgYydoZW50YcOx
CXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJfAkJaHR0cDovL21vaW5l
amYuZnJlZS5mci8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
