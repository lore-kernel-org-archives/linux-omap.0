From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Thu, 12 Oct 2017 09:07:55 +0300
Message-ID: <da8d1d7f-f16d-8d71-cf49-acff79614610@ti.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
 <20171011165850.jnaievrgcszcawh3@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171011165850.jnaievrgcszcawh3@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Matthijs van Duin <matthijsvanduin@gmail.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

77u/SGkgU2ViYXN0aWFuLAoKClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxh
bmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLiBZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00
LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQoKT24gMjAxNy0xMC0xMSAxOTo1OCwgU2Vi
YXN0aWFuIFJlaWNoZWwgd3JvdGU6Cj4+IEknbGwgbG9vayBhdCB0aGUgc2NoZW1hIG9mIFBhbmRh
Qm9hcmQgdG8gc2VlIGlmIEkgY2FuIHJvdXRlIG91dCB0aGUgTWNBU1AKPj4gbGluZXMgdG8gc29t
ZXdoZXJlIHRoZW4gSSBjYW4gYWRkIHN1cHBvcnQgZm9yIHRoaXMgcmV2aXNpb24gdG8gZGF2aW5j
aS1tY2FzcAo+PiBkcml2ZXIuCj4gCj4gTm90IHN1cmUgaWYgdGhpcyBpcyBoZWxwZnVsIGluZm9y
bWF0aW9uOgo+IAo+IE1vdG9yb2xhIERyb2lkIDQgaXMgT01BUDQ0MzAgYmFzZWQgYW5kIGhhcyBN
Y0FTUCBsaW5lcyByb3V0ZWQKPiB0byB0aGUgYXVkaW8gY29kZWMgKGVpdGhlciBNY0FTUCBvciBN
Y0JTUCBjYW4gYmUgdXNlZCkuIENvZGVjCj4gaXMgYSBjdXN0b20gb25lLCB3aGljaCBpcyBub3Qg
eWV0IHN1cHBvcnRlZCBtYWlubGluZSwgYnV0Cj4gcGF0Y2hlcyBhcmUgV0lQICgqKToKPiAKPiBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy83LzEyLzM2OAoKUmVhbGx5IGNvb2whCkkgZG9uJ3Qg
c2VlIG11Y2ggYmVuZWZpdCBvZiB1c2luZyBNY0FTUCBvbiBPTUFQNCwgb25seSBkcmF3YmFja3Mu
Li4gSXQKbGFja3MgQUZJRk8gc28gaXQgaXMgcHJvbmUgdG8gdW5kZXJydW4gYW5kIGlmIGl0IHVu
ZGVycnVucyB5b3UgbmVlZCB0bwpyZXNldCBNY0FTUC4gQmVlbiB0aGVyZSB3aXRoIHRoZSBTYW1z
dW5nIEdhbGF4eSBOZXh1cy4KCkkgd29uZGVyIGhvdyBNb3Rvcm9sYSBpcyB1c2luZyB0aGUgTWNB
U1AgYXMgdGhlIE9NQVA0IHZlcnNpb24KKG9mZmljaWFsbHkpIGRvZXMgbm90IHN1cHBvcnQgSTJT
LiBJdCBtaWdodCB3b3JrLCBJIGhhdmUgbm90IHRyaWVkIGl0LgoKSSBkbyBoYXZlIG9uZSBHYWxh
eHkgTmV4dXMsIGJ1dCB0aGVyZSB0aGUgTWNBU1AgaXMgdXNlZCBmb3IgdGhlIFMvUElESUYKb24g
dGhlIGRvY2sgKHRoZSB0aHJlZSBwaW5zIG9uIHRoZSBzaWRlKS4gWWVzLCBJIGRvIG5vdCBoYXZl
IHRoZSBkb2NrCmFuZCBteSBHYWxheHkgTmV4dXMgaXMgc3RpbGwgaW4gYWN0aXZlIHVzZSAtPiBu
b3Qgcm9vdGVkLCBhbmQgbmV2ZXIgcnVuCm1haW5saW5lIExpbnV4LgoKPiAoKikgTXkgcGF0Y2hl
cyB1c2UgTWNCU1AgaW5zdGVhZCBvZiBNY0FTUCwgc2luY2UgTWNBU1AgbG9va2VkCj4gbW9zdGx5
IHVuc3VwcG9ydGVkLiBNb3Rvcm9sYSdzIGtlcm5lbCB1c2VzIE1jQVNQLgoKSWYgSSBoYXZlIHNv
bWV0aGluZyBJIG1pZ2h0IGFzayB5b3UgZm9yIHRlc3RpbmcsIGlmIGl0IGlzIE9LLgoKPiAKPiAt
LSBTZWJhc3RpYW4KPiAKCi0gUMOpdGVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
