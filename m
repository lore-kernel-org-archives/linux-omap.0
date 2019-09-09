From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Mon, 9 Sep 2019 14:19:10 -0500
Message-ID: <CAHCN7x+7aafrZTtDFqbYJFtrozi8jCmiFE8SyFSmEhyd_Xh6tQ@mail.gmail.com>
References: <20190828150037.2640-1-aford173@gmail.com>
 <20190905230443.GA52127@atomide.com>
 <CAHCN7xL0fbr=Sv+b=0AuGB1PPhAAFdAFLEd_iBM+ZMTkUw5sHQ@mail.gmail.com>
 <CAHCN7xL-Gfxe0qF5w7BUsHnyhcNNpmCnchdKErnmiqggXfsLWw@mail.gmail.com>
 <20190909134033.s26eiurpat3iekse@pali> <20190909163543.GQ52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190909163543.GQ52127@atomide.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBTZXAgOSwgMjAxOSBhdCAxMTozNSBBTSBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPiB3cm90ZToKPgo+ICogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPiBb
MTkwOTA5IDEzOjQxXToKPiA+IE9uIE1vbmRheSAwOSBTZXB0ZW1iZXIgMjAxOSAwODozNzowOSBB
ZGFtIEZvcmQgd3JvdGU6Cj4gPiA+IEkgYXBwbGllZCB0aGlzIG9uIDUuMyBhbmQgaXQgaXMgd29y
a2luZy4gIEkgYXNzdW1lIHRoZSBzYW1lIGlzIHRydWUgaW4gZm9yLW5leHQuCj4KPiBIbW0gSSBu
b3RpY2VkIEkgc3RvcHBlZCBnZXR0aW5nIFJORyBkYXRhIGFmdGVyIHNldmVyYWwgcm1tb2QgbW9k
cHJvYmUKPiBjeWNsZXMsIG9yIHNldmVyYWwgaGQgL2Rldi9yYW5kb20gcmVhZHMuIEFueWJvZHkg
ZWxzZSBzZWVpbmcgdGhhdD8KCk9uIHRoZSBMb2dpYyBQRCBUb3JwZWRvLCBJIHdhcyBhYmxlIHRv
IHJlYWQgZnJvbSAvZGV2L2h3cm5nIGFuZAovZGV2L3JhbmRvbSAxMHggd2l0aG91dCBpc3N1ZQpJ
IGhhdmUgaW5zdGFsbGVkIHJuZy10b29scyBhbmQgSSBoYXZlIHNzaGQgcnVubmluZyBhbmQgc29t
ZSBvdGhlcgpzdHVmZiB0aGF0IG1pZ2h0IGdldCBpbiB0aGUgd2F5IGlmIEkgZG8gYW4gcm1tb2Qg
dG9vIG11Y2gsIGJ1dCBJCnJlbW92ZWQgYW5kIG1vZHByb2JlZCB0aGUgb21hcC1ybmcgM3ggYW5k
IG5ldmVyIHNhdyBhbiBpc3N1ZSByZWFkaW5nCmVpdGhlciAvZGV2L2h3cm5nIG9yIC9kZXYvcmFu
ZG9tLgoKSSBoYXZlIGJlZW4gbWVhbmluZyB0byB0ZXN0IHRoaXMgb24gdGhlIEFNMzUxNyBhbmQg
aGF2ZW4ndCBnb3R0ZW4gdG8KaXQgeWV0LCBidXQgSSBhc3N1bWUgeW91J3ZlIG9ubHkgdGVzdGVk
IG9tYXAzNjMwLCBpcyB0aGF0IHRydWU/CgphZGFtCj4KPiA+ID4gRG8geW91IHdhbnQgdG8gc3Vi
bWl0IGEgZm9ybWFsIHBhdGNoPyAgSSAgY2FuIG1hcmsgaXQgYXMgJ3Rlc3RlZC1ieScKPiA+ID4g
VGhpcyByZWFsbHkgaGVscHMgc3BlZWQgdXAgdGhlIHN0YXJ0dXAgc2VxdWVuY2Ugb24gYm9hcmRz
IHdpdGggc3NoZAo+ID4gPiBiZWNhdXNlIGl0IGRlbGF5cyBmb3IgbmVhcmx5IDgwIHNlY29uZHMg
d2FpdGluZyBmb3IgZW50cm9weSB3aXRob3V0Cj4gPiA+IHRoZSBod3JuZy4KPiA+Cj4gPiBIaSEg
V2hlbiBhcHBseWluZyBhIHBhdGNoLCBjb3VsZCB5b3UgcGxlYXNlIGRpc2FibGUgdGhpcyBybmcg
Zm9yIG45MDA/Cj4gPgo+ID4gSW4gb21hcDMtbjkwMC5kdHMgZm9yIHJuZyBzaG91bGQgYmUgc3Rh
dHVzID0gImRpc2FibGVkIiAoYXMgVG9ueSBhbHJlYWR5Cj4gPiB3cm90ZSksIHNpbWlsYXJseSBs
aWtlIGZvciBhZXMuCj4KPiBZZWFoIEknbGwgcG9zdCBhIHByb3BlciBwYXRjaCBhZnRlciAtcmMx
Lgo+Cj4gUmVnYXJkcywKPgo+IFRvbnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
