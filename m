From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 22 Oct 2019 07:13:00 -0500
Message-ID: <CAHCN7xJjMNOLT5oPn8CArApM5b2ksPon8eALq=gUi0ZqoLjGHQ@mail.gmail.com>
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
ZWxzZSBzZWVpbmcgdGhhdD8KPgo+ID4gPiBEbyB5b3Ugd2FudCB0byBzdWJtaXQgYSBmb3JtYWwg
cGF0Y2g/ICBJICBjYW4gbWFyayBpdCBhcyAndGVzdGVkLWJ5Jwo+ID4gPiBUaGlzIHJlYWxseSBo
ZWxwcyBzcGVlZCB1cCB0aGUgc3RhcnR1cCBzZXF1ZW5jZSBvbiBib2FyZHMgd2l0aCBzc2hkCj4g
PiA+IGJlY2F1c2UgaXQgZGVsYXlzIGZvciBuZWFybHkgODAgc2Vjb25kcyB3YWl0aW5nIGZvciBl
bnRyb3B5IHdpdGhvdXQKPiA+ID4gdGhlIGh3cm5nLgo+ID4KPiA+IEhpISBXaGVuIGFwcGx5aW5n
IGEgcGF0Y2gsIGNvdWxkIHlvdSBwbGVhc2UgZGlzYWJsZSB0aGlzIHJuZyBmb3IgbjkwMD8KPiA+
Cj4gPiBJbiBvbWFwMy1uOTAwLmR0cyBmb3Igcm5nIHNob3VsZCBiZSBzdGF0dXMgPSAiZGlzYWJs
ZWQiIChhcyBUb255IGFscmVhZHkKPiA+IHdyb3RlKSwgc2ltaWxhcmx5IGxpa2UgZm9yIGFlcy4K
Pgo+IFllYWggSSdsbCBwb3N0IGEgcHJvcGVyIHBhdGNoIGFmdGVyIC1yYzEuCgpUb255LAoKSSBh
bSBqdXN0IGZvbGxvd2luZyB1cCBvbiB0aGlzLiAgV2l0aG91dCB0aGUgSFdSTkcgdGhlcmUgYXJl
IHNvbWUKdG9vbHMgYW5kIGRhZW1vbnMgbGlrZSBzc2hkIHdoaWNoIHdhaXQgYSBsb25nIHRpbWUg
YXQgc3RhcnR1cC4gIFRoZQpwYXRjaCB5b3Ugc2VudCByZWFsbHkgaGVscHMgc3BlZWQgdXAgdGhl
IHN0YXJ0dXAgdGltZSBpbiB0aGVzZSBjYXNlcy4KQXQgbGVhc3QgaW4gbXkgY2FzZSwgaXQgc2hh
dmVzIDgwIHNlY29uZHMgb2ZmIGJ5IGVsaW1pbmF0aW5nIHRoZQpkZWxheXMuCgpEbyB5b3UgdGhp
bmsgeW91J2xsIGhhdmUgdGltZSB0byBwb3N0IGEgbW9yZSBmb3JtYWwgcGF0Y2g/ICBJZiBub3Qs
IEkKY2FuIGRvIGl0LiAgSSBqdXN0IGRvbid0IGtub3cgd2hpY2ggbWFpbGluZyBsaXN0IGlzIHRo
ZSBtb3JlCmFwcHJvcHJpYXRlLiAgSSB3YXMgYWJsZSB0byB2ZXJpdHkgeW91ciBwYXRjaCBvbiBh
IERNMzczMCBhbmQgT01BUDM1MzAKClRoYW5rcywKCmFkYW0KCgo+Cj4gUmVnYXJkcywKPgo+IFRv
bnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
