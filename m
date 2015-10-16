From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
Date: Fri, 16 Oct 2015 07:57:07 -0700
Message-ID: <20151016145707.GU10113@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Pau Pajuel <ppajuel@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, =?utf-8?Q?Agust=C3=AD?= Fontquerni i Gorchs <afontquerni@iseebcn.com>, egavin@iseebcn.com, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

KiBFbnJpYyBCYWxsZXRibyBTZXJyYSA8ZWJhbGxldGJvQGdtYWlsLmNvbT4gWzE1MTAxNiAwMToy
Nl06Cj4gSGkgVG9ueSwKPiAKPiBNYW55IHRoYW5rcyBmb3IgdGhlIHBhdGNoCj4gCj4gMjAxNS0x
MC0xMyAxOToxOCBHTVQrMDI6MDAgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT46Cj4g
PiBXaXRoIG9tYXA1LWJvYXJkLWNvbW1vbi5kdHNpLCB3ZSBjYW4gbm93IGVhc2lseSBhZGQgc3Vw
cG9ydCBmb3IgdmFyaW91cyBvbWFwNQo+ID4gYm9hcmQgdmFyaWFudHMuIExldCdzIGFkZCBtaW5p
bWFsIHN1cHBvcnQgZm9yIGlzZWUgaWdlcHY1Lgo+ID4KPiA+IFNvIGZhciBJJ3ZlIHRlc3RlZCB0
aGF0IGJhc2ljIHRoaW5ncyB3b3JrLCBzdWNoIGFzIHNlcmlhbCwgVVNCIEV0aGVybmV0LCBIRE1J
Cj4gPiBhbmQgV0xBTi4KPiA+Cj4gPiBOb3RlIHRoYXQgbGlrZSBvbWFwNS11ZXZtLCB0aGVzZSBi
b2FyZHMgc2VlbSB0byBuZWVkIHRvIHJlc2VydmUgMTZNQiBmb3IgYQo+ID4gdHJhcCBzZWN0aW9u
IGFzIGluIGNvbW1pdCAwMzE3OGM2NmQyODkgKCJBUk06IGR0czogb21hcDUtZXZtOiBVcGRhdGUK
PiA+IGF2YWlsYWJsZSBtZW1vcnkgdG8gMjAzMiBNQiIpIGFuZCBhbHNvIG5vdGVkIGluIGEgdS1i
b290IGNvbW1pdCBhdAo+ID4gaHR0cDovL21hcmMuaW5mby8/bD11LWJvb3QmbT0xMzQzNzY4NTI2
MDMyNTUgYW5kIGFsc28gYXQKPiA+IGh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8x
NTk4ODEvLgo+ID4KPiA+IE5vdCBzdXJlIHdoeSB0aGlzIGlzIG5vdCBuZWVkZWQgZm9yIG9tYXA1
LWNtLXQ1NC5kdHMsIG1heWJlIGJlY2F1c2Ugb2YKPiA+IGRpZmZlcmVudCB1LWJvb3QgY29uZmln
dXJhdGlvbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPgo+ID4gLS0tCj4gPgo+ID4gRW5yaWMsIGNhbiB5b3UgcGxlYXNlIGNoZWNrIGlmIHRo
ZXJlIGFyZSBzb21lIGNyaXRpY2FsIHBpZWNlcyBjb21wYXJlZAo+ID4gdG8gb21hcDUtdWV2bSB0
aGF0IHNob3VsZCBiZSB1cGRhdGVkIGZvciB0aGlzIHBhdGNoPwo+ID4KPiAKPiBVbmZvcnR1bmF0
ZWx5IEkgZG9uJ3QgaGF2ZSB0aGUgc2NoZW1hdGljIGFuZCBhbnkgSUdFUHY1IHRvIHZlcmlmeSB5
b3VyCj4gcGF0Y2hlcy4gRnJvbSBhIHF1aWNrIHZpZXcgSSBjYW4gc2F5IHRoYXQgaXQncyBvayBi
dXQgbGV0IG1lIGNjCj4gQWd1c3TDrSwgRWR1YXJkIGFuZCBQYXUgdGhhdCB3aWxsIGhhdmUgYWNj
ZXNzIHRvIHRoZSBoYXJkd2FyZSBhbmQgdGhlCj4gc2NoZW1hdGljcy4KCk9LIHRoYW5rcy4gVGhl
IHRoaW5nIHRvIGRvIGlzIGNoZWNrIGFnYWluc3QgdGhlIG9tYXA1LWJvYXJkLWNvbW1vbi5kdHNp
IGluCnRoaXMgcGF0Y2ggc2VyaWVzIHNvIHRoZXJlJ3Mgbm90aGluZyB1bnN1aXRhYmxlIGluIG9t
YXA1LWJvYXJkLWNvbW1vbi5kdHNpCnRoYXQgbmVlZHMgYW4gb3ZlcnJpZGUgaW4gb21hcDUtaWdl
cDAwNTAuZHRzLgoKUmVnYXJkcywKClRvbnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
