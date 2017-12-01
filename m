From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Fri, 1 Dec 2017 10:13:24 +0200
Message-ID: <6ca5f2ea-e725-9a9e-ac02-e16beca4a1a0@ti.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com> <20171130220633.imkfyeiqtftnw4j4@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171130220633.imkfyeiqtftnw4j4@earth>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gMDEvMTIvMTcgMDA6MDYsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgoKPj4+PiBIb3cgYWJv
dXQgbGV0J3MgY2FsbCBpdCBhICJ0eXBvIGZpeCIgdGhlbj8gOikKPj4+Cj4+PiBXZWxsLCBpdCBp
cyBub3QgcmVhbGx5IGEgdHlwby4KPj4KPj4gV2VsbCB3aGF0IGlmIHRoZSBzdGFibGUgcGVvcGxl
IHBpY2sgaXQgaW50byBlYXJsaWVyIHN0YWJsZSBzZXJpZXMKPj4gYmFzZWQgb24gdGhlIHdvcmQg
Zml4IGluIHRoZSBzdWJqZWN0PyBUaGF0IGhhcyBoYXBwZW5lZCBiZWZvcmUuCj4+Cj4+IEkgc3Vn
Z2VzdCB5b3UgdXBkYXRlIHRoZSBkdHMgcGF0Y2hlcyB0byB1c2Ugd29yZGluZyBsaWtlCj4+ICJ1
cGRhdGUgY29tcGF0aWJsZSB0byB1c2UgbmV3IG5hbWluZyIgb3Igc29tZXRoaW5nIHNpbWlsYXIu
Cj4gCj4gUGF0Y2ggNC80IGlzIGEgRml4IGFuZCBzaG91bGQgYmUgYXBwbGllZCB0byBzdGFibGUg
dHJlZXMuICJvbWFwZHNzLCIKPiBwcmVmaXggd2FzIG5ldmVyIHN1cHBvc2VkIHRvIGJlIGluIHRo
ZSBEVFMgZmlsZXMsIGlzIG5vdCBzdXBwb3NlZCB0bwo+IGJlIGluIHRoZXJlIG5vdyBhbmQgd2ls
bCBicmVhayBzb21lIHRpbWUgaW4gdGhlIGZ1dHVyZS4KPiAKPiBFeHBsYW5hdGlvbjogVGhlIGVh
cmx5IGluaXQgb2Ygb21hcGRzcyBhZGRzIHRoZSBwcmVmaXggYXQgcnVudGltZSwKPiBzbyB0aGF0
IHRoZSBiaW5kaW5nIGNhbiB1c2UgZ2VuZXJpYyBwcm9wZXJ0aWVzIGFuZCB0aGUga2VybmVsIGNh
bgo+IHVzZSBvbWFwZHNzIHNwZWNpZmljIGRyaXZlcnMgdW50aWwgdGhlIGdlbmVyaWMgb25lcyBj
YW4gYmUgdXNlZAoKVGhpcyBpcyB0cnVlLCBidXQgdGhlIGV4dHJhICJvbWFwZHNzIiBkb2VzIG5v
dCBjYXVzZSBhbnkgaXNzdWVzIGF0IHRoZQptb21lbnQsIGFuZCB0aGUgdGltZSB3aGVuIGl0IGNh
dXNlcyBpc3N1ZXMgaXMgc3RpbGwgbWFueSBrZXJuZWwgdmVyc2lvbnMKaW4gdGhlIGZ1dHVyZS4K
CkJ1dCwgeWVzLCB0aGlua2luZyBhYm91dCB0aGlzLCBJIGFncmVlLCBpdCdzIGJldHRlciB0byBw
aWNrIHRoaXMgb25lCnNlcGFyYXRlbHkgYXMgYSBmaXggKGFmdGVyIHJlYmFzaW5nIGl0IG9uIHRv
cCBvZiBjdXJyZW50IG1haW5lbGluZSBzbwp0aGF0IGl0IGRvZXNuJ3QgZGVwZW5kIG9uIHRoZSB0
b3Bwb2x5IG5hbWUgY2hhbmdlKSwgYW5kIGxlYXZpbmcgdGhlCnRvcHBvbHktPnRwbyBjaGFuZ2Ug
YXMgYSBjbGVhbnVwLgoKLS0gClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxh
bmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00
LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
