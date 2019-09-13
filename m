From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/3] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Fri, 13 Sep 2019 10:11:22 -0500
Message-ID: <CAHCN7xLh+6rdfjaXJJxv_s82OhPiVGhksu2L+krZAnYCTnpijw@mail.gmail.com>
References: <20190801012823.28730-1-neolynx@gmail.com>
 <20190801012823.28730-2-neolynx@gmail.com>
 <CAHCN7x+Vd+ECoa4fmUfoX47znag+NxKSzRt3iouQCZ2CQ2T--A@mail.gmail.com>
 <20190912210937.GU52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190912210937.GU52127@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Shweta Gulati <shweta.gulati@ti.com>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Thara Gopinath <thara@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCBTZXAgMTIsIDIwMTkgYXQgNDowOSBQTSBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPiB3cm90ZToKPgo+ICogQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+IFsxOTA5
MTIgMTk6MDBdOgo+ID4gT24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgODoyOSBQTSBBbmRyw6kgUm90
aCA8bmVvbHlueEBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBGcm9tOiBUaGFyYSBHb3Bp
bmF0aCA8dGhhcmFAdGkuY29tPgo+ID4gPgo+ID4gPiBWb2x0YWdlIGNvbnRyb2wgb24gVFdMIGNh
biBiZSBkb25lIHVzaW5nIFZNT0RFL0kyQzEvSTJDX1NSLgo+ID4gPiBTaW5jZSBhbG1vc3QgYWxs
IHBsYXRmb3JtcyB1c2UgSTJDX1NSIG9uIG9tYXAzLCBvbWFwM190d2xfaW5pdCBieQo+ID4gPiBk
ZWZhdWx0IGV4cGVjdHMgdGhhdCBPTUFQJ3MgSTJDX1NSIGlzIHBsdWdnZWQgaW4gdG8gVFdMJ3Mg
STJDCj4gPiA+IGFuZCBjYWxscyBvbWFwM190d2xfc2V0X3NyX2JpdC4gT24gcGxhdGZvcm1zIHdo
ZXJlIEkyQ19TUiBpcyBub3QgY29ubmVjdGVkLAo+ID4gPiB0aGUgYm9hcmQgZmlsZXMgYXJlIGV4
cGVjdGVkIHRvIGNhbGwgb21hcDNfdHdsX3NldF9zcl9iaXQoZmFsc2UpIHRvCj4gPiA+IGVuc3Vy
ZSB0aGF0IEkyQ19TUiBwYXRoIGlzIG5vdCBzZXQgZm9yIHZvbHRhZ2UgY29udHJvbCBhbmQgcHJl
dmVudAo+ID4gPiB0aGUgZGVmYXVsdCBiZWhhdmlvciBvZiBvbWFwM190d2xfaW5pdC4KPiA+ID4K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTmlzaGFudGggTWVub24gPG5tQHRpLmNvbT4KPiA+ID4gU2ln
bmVkLW9mZi1ieTogVGhhcmEgR29waW5hdGggPHRoYXJhQHRpLmNvbT4KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogU2h3ZXRhIEd1bGF0aSA8c2h3ZXRhLmd1bGF0aUB0aS5jb20+Cj4gPiA+IENjOiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+ID4gU2lnbmVkLW9mZi1ieTogS2V2
aW4gSGlsbWFuIDxraGlsbWFuQHRpLmNvbT4KPiA+Cj4gPiBUb255LAo+ID4KPiA+IElzIHRoZXJl
IGEgc3RhdHVzIHVwZGF0ZSBvbiB0aGlzIHNlcmllcz8gIEl0J3MgYmVlbiBzZXZlcmFsIG1vbnRo
cywKPiA+IGFuZCBJIGhhdmVuJ3Qgc2VlbiBhbnkgZmVlZGJhY2sgb24gaXQsIG5vciBkb2VzIGl0
IGFwcGVhciB0byBiZSBpbiBhbnkKPiA+IG9mIHlvdXIgYnJhbmNoZXMgdGhhdCBJIGNhbiBzZWUu
Cj4KPiBXZWxsIGl0IHdhcyB0YWdnZWQgUkZDLi4gRG9lcyBzb21ldGhpbmcgbmVlZCB1cGRhdGlu
Zwo+IHdpdGggaXQ/CgpJIGRpZG4ndCBub3RpY2UgdGhlIFJUQyB1bnRpbCB5b3UgcG9pbnRlZCBv
dXQgdGhlIDAvMyBmaWxlIHNob3dlZCB0aGUgUkZDLgoKQW5kcmUgLSAgc2luY2UgeW91IGhhdmUg
c2lnbi1vZmYgYnkgdmFyaW91cyBUSSBwZW9wbGUgYW5kIFRvbnkgc2VlbXMKc2F0aXNmaWVkLCB3
b3VsZCB5b3UgYmUgd2lsbCB0byByZS1iYXNlIGFuZCBwdXNoIHRoZSBwYXRjaCBzZXJpZXMKd2l0
aG91dCB0aGUgUkZDPwoKSSB0aGluayBzb21lIG9mIHRoZSB3b3JrIHRoYXQgSCBOaWtvbGF1cyBT
Y2hhbGxlciBpcyBkb2luZyB3aWxsCmJlbmVmaXQgZnJvbSB0aGlzLgoKVGhhbmsgeW91LAoKYWRh
bQo+Cj4gQXQgbGVhc3QgdGhlIGZpcnN0IHR3byBwYXRjaGVzIGxvb2tlZCBPSyB0byBtZS4KPgo+
IFJlZ2FyZHMsCj4KPiBUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
