From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Thu, 12 Sep 2019 14:09:37 -0700
Message-ID: <20190912210937.GU52127@atomide.com>
References: <20190801012823.28730-1-neolynx@gmail.com>
 <20190801012823.28730-2-neolynx@gmail.com>
 <CAHCN7x+Vd+ECoa4fmUfoX47znag+NxKSzRt3iouQCZ2CQ2T--A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7x+Vd+ECoa4fmUfoX47znag+NxKSzRt3iouQCZ2CQ2T--A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Shweta Gulati <shweta.gulati@ti.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Thara Gopinath <thara@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

KiBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4gWzE5MDkxMiAxOTowMF06Cj4gT24gV2Vk
LCBKdWwgMzEsIDIwMTkgYXQgODoyOSBQTSBBbmRyw6kgUm90aCA8bmVvbHlueEBnbWFpbC5jb20+
IHdyb3RlOgo+ID4KPiA+IEZyb206IFRoYXJhIEdvcGluYXRoIDx0aGFyYUB0aS5jb20+Cj4gPgo+
ID4gVm9sdGFnZSBjb250cm9sIG9uIFRXTCBjYW4gYmUgZG9uZSB1c2luZyBWTU9ERS9JMkMxL0ky
Q19TUi4KPiA+IFNpbmNlIGFsbW9zdCBhbGwgcGxhdGZvcm1zIHVzZSBJMkNfU1Igb24gb21hcDMs
IG9tYXAzX3R3bF9pbml0IGJ5Cj4gPiBkZWZhdWx0IGV4cGVjdHMgdGhhdCBPTUFQJ3MgSTJDX1NS
IGlzIHBsdWdnZWQgaW4gdG8gVFdMJ3MgSTJDCj4gPiBhbmQgY2FsbHMgb21hcDNfdHdsX3NldF9z
cl9iaXQuIE9uIHBsYXRmb3JtcyB3aGVyZSBJMkNfU1IgaXMgbm90IGNvbm5lY3RlZCwKPiA+IHRo
ZSBib2FyZCBmaWxlcyBhcmUgZXhwZWN0ZWQgdG8gY2FsbCBvbWFwM190d2xfc2V0X3NyX2JpdChm
YWxzZSkgdG8KPiA+IGVuc3VyZSB0aGF0IEkyQ19TUiBwYXRoIGlzIG5vdCBzZXQgZm9yIHZvbHRh
Z2UgY29udHJvbCBhbmQgcHJldmVudAo+ID4gdGhlIGRlZmF1bHQgYmVoYXZpb3Igb2Ygb21hcDNf
dHdsX2luaXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTmlzaGFudGggTWVub24gPG5tQHRpLmNv
bT4KPiA+IFNpZ25lZC1vZmYtYnk6IFRoYXJhIEdvcGluYXRoIDx0aGFyYUB0aS5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBTaHdldGEgR3VsYXRpIDxzaHdldGEuZ3VsYXRpQHRpLmNvbT4KPiA+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6
IEtldmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+Cj4gCj4gVG9ueSwKPiAKPiBJcyB0aGVyZSBh
IHN0YXR1cyB1cGRhdGUgb24gdGhpcyBzZXJpZXM/ICBJdCdzIGJlZW4gc2V2ZXJhbCBtb250aHMs
Cj4gYW5kIEkgaGF2ZW4ndCBzZWVuIGFueSBmZWVkYmFjayBvbiBpdCwgbm9yIGRvZXMgaXQgYXBw
ZWFyIHRvIGJlIGluIGFueQo+IG9mIHlvdXIgYnJhbmNoZXMgdGhhdCBJIGNhbiBzZWUuCgpXZWxs
IGl0IHdhcyB0YWdnZWQgUkZDLi4gRG9lcyBzb21ldGhpbmcgbmVlZCB1cGRhdGluZwp3aXRoIGl0
PwoKQXQgbGVhc3QgdGhlIGZpcnN0IHR3byBwYXRjaGVzIGxvb2tlZCBPSyB0byBtZS4KClJlZ2Fy
ZHMsCgpUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
