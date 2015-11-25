From: Tony Lindgren <tony@atomide.com>
Subject: Re: am35xx memory management issues
Date: Wed, 25 Nov 2015 10:37:09 -0800
Message-ID: <20151125183709.GL2517@atomide.com>
References: <5644AD53.3020303@nomovok.com> <20151112170659.GL3218@atomide.com>
 <5645E026.9010002@nomovok.com> <56546CAD.4060007@nomovok.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56546CAD.4060007@nomovok.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markku =?utf-8?Q?Ahvenj=C3=A4rvi?= <markku.ahvenjarvi@nomovok.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBNYXJra3UgQWh2ZW5qw6RydmkgPG1hcmtrdS5haHZlbmphcnZpQG5vbW92b2suY29tPiBbMTUx
MTI0IDA1OjU3XToKPiBPbiAxMy4xMS4yMDE1IDE1OjA1LCBNYXJra3UgQWh2ZW5qw6Rydmkgd3Jv
dGU6Cj4gPiBPbiAxMi4xMS4yMDE1IDE5OjA2LCBUb255IExpbmRncmVuIHdyb3RlOgo+ID4+Cj4g
Pj4gQWxzbyBwbGVhc2UgY2hlY2sgaWYgbGVhdmluZyBvdXQgQ09ORklHX1NNUF9PTl9VUCBhZmZl
Y3RzIHRoaW5ncy4KPiA+IAo+ID4gQWxyaWdodCwgd2lsbCBkby4KPiAKPiBXZSd2ZSBiZWVuIHRl
c3Rpbmcgb21hcDJwbHVzIGRlZmNvbmZpZyB3aXRob3V0IG90aGVyIG9tYXBzIGFuZCB3aXRob3V0
IENPTkZJR19TTVBfT05fVVAuIFNvIGZhciB3ZSBoYXZlbid0IHNlZW4gYW55IHBhbmljcywgYnV0
IEkndmUgaGFkIG9ubHkgYSBmZXcgdW5pdHMgdGVzdGluZyBpdC4KCk9LCgo+IE1lYW53aGlsZSB3
ZSd2ZSBiZWVuIHRlc3Rpbmcgb3VyIGN1c3RvbSBib2FyZCB3aXRoIGEgY29uZmlndXJhdGlvbiB0
aGF0IGlzIHF1aXRlIGNsb3NlIHRvIG9tYXAycGx1cywgaW5jbHVkaW5nIG90aGVyIG9tYXBzIGFu
ZCBDT05GSUdfU01QX09OX1VQLiBXZSd2ZSBoYWQgY291cGxlIG9mIHBhbmljcywgc28gaXQgc2Vl
bXMgdGhhdCB0aGVzZSBkb2Vzbid0IGFmZmVjdCB0aGUgcHJvYmxlbS4gV2UgaGFkIDE1IHVuaXRz
IHJ1bm5pbmcgc3RyZXNzLW5nIGFuZCBpdCB0b29rIH44IGRheXMgdW50aWwgd2Ugc2F3IGZpcnN0
IHBhbmljLCBzbyBpZiBvbWFwMnBsdXMgaXMgYWZmZWN0ZWQgaXQgaXMgcXVpdGUgcmFyZS4KCkht
bSBzbyB0byBjb25maXJtLi4gSXMgb21hcDJwbHVzX2RlZmNvbmZpZyBzdGFibGUgb24gYWxsIGJv
YXJkcyBpbmNsdWRpbmcgeW91ciBjdXN0b20KYm9hcmQ/Cgo+IEFueSBvdGhlciBzdWdnZXN0aW9u
cz8KCk1heWJlIHByb3ZpZGUgb3V0cHV0IG9mIHdoYXQgY2hhbmdlcyBtYWtlIHRoZSBwcm9ibGVt
IGhhcHBlbiB3aXRoIHlvdXIgY3VzdG9tCi5jb25maWcgaWYgeW91IGhhdmUgbm90IGFscmVhZHkg
ZG9uZToKCiQgbWFrZSBzYXZlZGVmY29uZmlnCiQgY3AgZGVmY29uZmlnIGFyY2gvYXJtL2NvbmZp
Z3Mvb21hcDJwbHVzX2RlZmNvbmZpZwokIGdpdCBkaWZmCgpSZWdhcmRzLAoKVG9ueQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
