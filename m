From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Sun, 20 Sep 2015 00:12:13 +0300
Message-ID: <CANOLnOP-WNcnDfQSDuHC_SN5vL8uNMWaeV3zNU7tcqNjGodURA@mail.gmail.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CAOCHtYh3pDg6_mdX71G=L5Vz-mOmBnerwR5pjumq5jYQ-tN5Pw@mail.gmail.com>
 <20150918165109.GB8020@atomide.com>
 <CAOCHtYisPQ2g0GCD4NF7m14TchfaZ+k3UedPoaA0Rjtpo9ug+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOCHtYisPQ2g0GCD4NF7m14TchfaZ+k3UedPoaA0Rjtpo9ug+g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gRnJpLCBTZXAgMTgsIDIwMTUgYXQgOTozOSBQTSwgUm9iZXJ0IE5lbHNvbiA8cm9iZXJ0Y25l
bHNvbkBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDE4LCAyMDE1IGF0IDExOjUxIEFN
LCBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPiB3cm90ZToKPj4gKiBSb2JlcnQgTmVs
c29uIDxyb2JlcnRjbmVsc29uQGdtYWlsLmNvbT4gWzE1MDkxOCAwOTo0NV06Cj4+PiBPbiBGcmks
IFNlcCAxOCwgMjAxNSBhdCAxMToyOSBBTSwgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNv
bT4gd3JvdGU6Cj4+PiA+IENvbW1pdCA5OWY4NGNhZTQzZGYgKCJBUk06IGR0czogYWRkIHdsMTJ4
eC93bDE4eHggYmluZGluZ3MiKSBhZGRlZAo+Pj4gPiBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3Ig
dGhlIFRJIFdMQU4gU0RJTyBvbiBtYW55IG9tYXAgdmFyaWFudHMuCj4+PiA+Cj4+PiA+IEkgcmVj
YWxsIHdvbmRlcmluZyBob3cgY29tZSBvbWFwNS11ZXZtIGRpZCBub3QgaGF2ZSB0aGUgV0xBTgo+
Pj4gPiBhZGRlZCBhbmQgdGhpcyBpc3N1ZSBoYXMgYmVlbiBidWdnaW5nIG1lIGZvciBhIHdoaWxl
IG5vdywgYW5kCj4+PiA+IEkgZmluYWxseSB0cmFja2VkIGl0IGRvd24gdG8gYSBiYWQgcGlubXV4
IHJlZ3Jlc3Npb24sIGFuZCBhIG1pc3NpbmcKPj4+ID4gZGVmZXJyZWQgcHJvYmUgaGFuZGxpbmcg
Zm9yIHRoZSAzMmsgY2xvY2sgZnJvbSBwYWxtYXMgdGhhdCdzCj4+PiA+IHJlcXVlc3RlZCBieSB0
d2w2MDQwLgo+Pj4gPgo+Pj4gPiBCYXNpY2FsbHkgMzkyYWRhZjc5NmI5ICgiQVJNOiBkdHM6IG9t
YXA1LWV2bTogQWRkIG1jc3BpIGRhdGEiKQo+Pj4gPiBhZGRlZCBwaW4gbXV4aW5nIGZvciBtY3Nw
aTQgdGhhdCBjb25mbGljdHMgd2l0aCB0aGUgb25ib2FyZAo+Pj4gPiBXTEFOLiBXaGlsZSB0aGUg
b21hcDUtdWV2bSBkb2NzIHNheSB0aGUgV0xBTiBpcyBub3QgcG9wdWxhdGVkLAo+Pj4gPiB0aGlz
IHdhcyBwcm9iYWJseSBvbmx5IHRoZSBjYXNlIGZvciBpbml0aWFsIHByb3RvdHlwZXMuIEJvdGgK
Pj4+ID4gb21hcDUtdWV2bSBib2FyZHMgSSBoYXZlIGhhdmUgV0xBTiBwb3B1bGF0ZWQuCj4+Pgo+
Pj4gUHJvZHVjdGlvbiBib2FyZHMgZnJvbSBzdnRyb25pY3MgZG9uJ3QgcG9wdWxhdGUgdGhlIHds
YW4uLgo+Pj4KPj4+IGh0dHA6Ly93d3cuc3Z0cm9uaWNzLmNvbS9FVk0vT01BUDU0MzIvNTQzMgo+
Pj4KPj4+IHF1b3RlOiAiV2lGaSBub3QgYXZhaWxhYmxlIG9uIHRoaXMgbW9kZWwiCj4KPiBPa2F5
LCBnb3QgYW4gZW1haWwgYmFjayBmcm9tIHN2dHJvbmljcywgdGhlcmUgd2FzIGEgc3BlY2lhbCBv
bWFwNV91ZXZtCj4gKyB3bGFuIG9yZGVyIG9wdGlvbiBmb3IgcHJvZHVjdGlvbiB1bml0cy4KClRo
ZSBib2FyZHMgd2UgYm91Z2h0IGNhbWUgd2l0aG91dCB3bGFuLCBzbyB0aGF0IHNlZW1zIHRvIGJl
IHRoZQoiZGVmYXVsdCIgY29uZmlndXJhdGlvbi4KCkkgdm90ZSBmb3IgdXNpbmcgc2VwYXJhdGUg
RFQgb3ZlcmxheSBmb3IgdGhlIHdsYW4gdmVyc2lvbiB0byBhdm9pZAp1bm5lY2Vzc2FyeSBwcm9i
aW5nLiBPVE9IIHRoZSBwaW5zIGFyZSBub3QgZXhwb3NlZCBvbiBleHBhbnNpb24KY29ubmVjdG9y
cyBhbmQgc2hvdWxkIG5vdCBjb25mbGljdCB3aXRoIGN1c3RvbSBwZXJpcGhlcmFscywgc28gbm8K
c3Ryb25nIG9waW5pb24gaGVyZS4KCkdyYcW+dnlkYXMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
