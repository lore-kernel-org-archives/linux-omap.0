From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Thu, 12 Oct 2017 12:10:01 +0300
Message-ID: <78eff2f9-1fe5-66f8-e754-344cb1ea0d97@ti.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
 <20171011165850.jnaievrgcszcawh3@earth>
 <da8d1d7f-f16d-8d71-cf49-acff79614610@ti.com>
 <20171012084030.lshobr3ewu3t5goc@squirrel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171012084030.lshobr3ewu3t5goc@squirrel.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

77u/CgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAx
ODAgSGVsc2lua2kuIFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2Ev
RG9taWNpbGU6IEhlbHNpbmtpCgpPbiAyMDE3LTEwLTEyIDExOjQwLCBNYXR0aGlqcyB2YW4gRHVp
biB3cm90ZToKPiBPbiBUaHUsIE9jdCAxMiwgMjAxNyBhdCAwOTowNzo1NUFNICswMzAwLCBQZXRl
ciBVamZhbHVzaSB3cm90ZToKPj4gSSBkb24ndCBzZWUgbXVjaCBiZW5lZml0IG9mIHVzaW5nIE1j
QVNQIG9uIE9NQVA0LCBvbmx5IGRyYXdiYWNrcy4uLiBJdAo+PiBsYWNrcyBBRklGTyBzbyBpdCBp
cyBwcm9uZSB0byB1bmRlcnJ1biBhbmQgaWYgaXQgdW5kZXJydW5zIHlvdSBuZWVkIHRvCj4+IHJl
c2V0IE1jQVNQLiBCZWVuIHRoZXJlIHdpdGggdGhlIFNhbXN1bmcgR2FsYXh5IE5leHVzLgo+IAo+
IEFFU1MvQVRDIGlzbid0IGFibGUgdG8gY29uc2lzdGVudGx5IHJlc3BvbmQgdG8gYSBETUEgcmVx
dWVzdCB3aXRoaW4gMjAKPiB1cyA/ICBTdHJhbmdlLi4gSSB3b3VsZCBoYXZlIGV4cGVjdGVkIGl0
IHRvIGhhdmUgbm8gdHJvdWJsZSB3aXRoIHRoYXQuCj4gKEFuZCBwcmVzdW1hYmx5IHNvIGRpZCBU
SSwgb3IgdGhleSB3b3VsZCBoYXZlIGluY2x1ZGVkIEFGSUZPPykKPiAKPj4gSSB3b25kZXIgaG93
IE1vdG9yb2xhIGlzIHVzaW5nIHRoZSBNY0FTUCBhcyB0aGUgT01BUDQgdmVyc2lvbgo+PiAob2Zm
aWNpYWxseSkgZG9lcyBub3Qgc3VwcG9ydCBJMlMuCj4gCj4gSG1tPyBJIGNoZWNrZWQgdGhlIG9t
YXA0NDMwIFRSTSBhbmQgSSBkb24ndCBzZWUgdGhhdCBtZW50aW9uZWQuIEl0IHNlZW1zCj4gdG8g
aGF2ZSBwaW5zIGZvciBpMnMgdHJhbnNtaXQ6Cj4gCj4gCWFiZV9tY2FzcF9heHIgICAgICAgICAg
ICAgIE8gICAgIEF1ZGlvIHRyYW5zbWl0IGRhdGEKPiAJYWJlX21jYXNwX2FjbGt4ICAgICAgICAg
ICAgTyAgICAgVHJhbnNtaXQgYml0IGNsb2NrCj4gCWFiZV9tY2FzcF9haGNsa3ggICAgICAgICAg
IE8gICAgIFRyYW5zbWl0IGhpZ2gtZnJlcXVlbmN5IG1hc3RlciBjbG9jawo+IAlhYmVfbWNhc3Bf
YWZzeCAgICAgICAgICAgICBPICAgICBUcmFuc21pdCBmcmFtZSBzeW5jaHJvbml6YXRpb24KPiAJ
YWJlX21jYXNwX2FtdXRlICAgICAgICAgICAgTyAgICAgTXV0ZSBvdXQgdG8gZXh0ZXJuYWwKPiAJ
YWJlX21jYXNwX2FtdXRlaW4gICAgICAgICAgSSAgICAgTXV0ZSBpbiBmcm9tIGV4dGVybmFsCj4g
Cj4gSWYgaXQgc3VwcG9ydGVkIHMvcGRpZiB0eCBvbmx5LCB0aGVuIGFsbCBvZiB0aGVzZSBleGNl
cHQgYXhyIHdvdWxkIGJlCj4gdXNlbGVzcy4KClRoZSBNY0FTUCB0cmFuc21pdCBzZWN0aW9uIHVz
ZXMgdGhlIFMvUERJRiBpbmR1c3RyeSBmb3JtYXQsIHdoaWNoIGlzCnN1cHBvcnRlZCBieSB0aGUg
RElUIHRyYW5zZmVyIG1vZGUgb2YgdGhlIG1vZHVsZS4KCkFuZCBsb29rIGZvciBUcmFuc2ZlciBN
b2RlcyBjaGFwdGVyIG9mIE1jU1NQIGluIHRoZSBPTUFQNCBUUk0uCgpJdCBpcyBESVQgb25seS4K
Cj4gCj4gTWF0dGhpanMKPiAKCi0gUMOpdGVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
