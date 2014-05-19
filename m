From: Joachim  Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] arm/omap4: add twd clock to DT
Date: Mon, 19 May 2014 18:23:16 +0200
Message-ID: <CAGhQ9Vy-mvaXZ_=E_mmqYqxF5EiJSdN1rJayussm+AgKf94a+g@mail.gmail.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <20140418223948.GK21823@atomide.com> <5353F44F.5080400@xenomai.org>
 <535662F0.4080300@ti.com>
 <CAGhQ9Vw-QaB+OnLa3yNVvD6a=XOutSZ1ejbsuUXvEcyrxEsRcQ@mail.gmail.com>
 <20140519161319.GD4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140519161319.GD4849@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

T24gMTkgTWF5IDIwMTQgMTg6MTMsIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdy
b3RlOgo+ICogSm9hY2hpbSBFYXN0d29vZCA8bWFuYWJpYW5AZ21haWwuY29tPiBbMTQwNTE4IDA1
OjA4XToKPj4gT24gMjIgQXByaWwgMjAxNCAxNDozOSwgVGVybyBLcmlzdG8gPHQta3Jpc3RvQHRp
LmNvbT4gd3JvdGU6Cj4+ID4gT24gMDQvMjAvMjAxNCAwNzoyMiBQTSwgR2lsbGVzIENoYW50ZXBl
cmRyaXggd3JvdGU6Cj4+ID4+Cj4+ID4+IExlIDE5LzA0LzIwMTQgMDA6MzksIFRvbnkgTGluZGdy
ZW4gYSDDqWNyaXQgOgo+PiA+Pj4KPj4gPj4+ICogR2lsbGVzIENoYW50ZXBlcmRyaXggPGdpbGxl
cy5jaGFudGVwZXJkcml4QHhlbm9tYWkub3JnPiBbMTQwNDA3IDEzOjA5XToKPj4gPj4+Pgo+PiA+
Pj4+IEJvb3RpbmcgTGludXggMy4xNCBvbiBQYW5kYWJvYXJkIGN1cnJlbnRseSBnZXRzIHRoZSBm
b2xsb3dpbmcKPj4gPj4+PiBtZXNzYWdlIGRpc3BsYXllZDoKPj4gPj4+Pgo+PiA+Pj4+IHNtcF90
d2Q6IGNsb2NrIG5vdCBmb3VuZCAtMgo+PiA+Pj4+Cj4+ID4+Pj4gRGVmaW5lICJtcHVfcGVyaXBo
Y2xrIiBhcyB0aGUgdHdkIGNsb2NrIGluIG9tYXA0IGR0cyB0byBhdm9pZCB0aGlzLgo+PiA+Pj4K
Pj4gPj4+Cj4+ID4+PiBUZXJvLCBjYXJlIHRvIGFjaz8KPj4gPj4KPj4gPj4KPj4gPj4gU29ycnkg
aWYgSSBkaWQgbm90IG1haWwgdGhlIHJpZ2h0IHBlb3BsZSwgZ2V0X21haW50YWluZXIucGwgZ2F2
ZSBtZSBhCj4+ID4+IGxvbmcgbGlzdCwgYW5kIEkgZGlkIG5vdCBmZWVsIGxpa2Ugc3BhbW1pbmcg
YWxsIHRoZXNlIHBlb3BsZSBmb3Igc3VjaCBhCj4+ID4+IHNtYWxsIHBhdGNoLiBJIGRvIG5vdCBi
ZWxpZXZlIFRlcm8gd2FzIGluIHRoaXMgbGlzdC4KPj4gPj4KPj4gPj4gUmVnYXJkcy4KPj4gPgo+
PiA+Cj4+ID4gWWVhIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBteSBleHBlcnRpc2UgYXJlYSwgaG93
ZXZlciB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0bwo+PiA+IG1lLCBzbyBpZiB5b3UgcmVhbGx5IG5l
ZWQgaXQ6Cj4+ID4KPj4gPiBBY2tlZC1ieTogVGVybyBLcmlzdG8gPHQta3Jpc3RvQHRpLmNvbT4K
Pj4KPj4gVG9ueSwgY2FyZSB0byBhZGQgdGhpcyB0byB5b3VyIG9tYXAgMy4xNiBkdCBicmFuY2g/
Cj4+Cj4+IEkgYW0gc3RpbGwgZ2V0dGluZzoKPj4gWyAwLjAwMDE1Ml0gc21wX3R3ZDogY2xvY2sg
bm90IGZvdW5kIC0yCj4+Cj4+IFNvIHRoaXMgZml4IGZyb20gR2lsbGVzIHdvdWxkIGJlIG5pY2Ug
dG8gaGF2ZS4KPgo+IEJlc3QgdGhhdCBUZXJvIHBpY2tzIHRoaXMgb25lIHVwIGFsb25nIHdpdGgg
dGhlIG90aGVyIGR0IGNsb2NrIGNoYW5nZXMKPiBoZSdzIHF1ZXVlaW5nLgoKSSBraW5kYSBhc3N1
bWVkIHlvdSB3b3VsZCB0YWtlIGl0IHNpbmNlIHlvdSBhc2tlZCBUZXJvIHRvIGFjayBpdC4gQnV0
CmVpdGhlciB3YXkgaXMgZmluZSA6KQpUaGFua3MuCgpyZWdhcmRzCkpvYWNoaW0gRWFzdHdvb2QK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
