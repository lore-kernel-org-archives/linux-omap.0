From: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: use const and __initconst for smp_operations
Date: Tue, 24 Nov 2015 18:34:45 +0000
Message-ID: <20151124183444.GP4158@e106497-lin.cambridge.arm.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447551593-22246-3-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Emilio =?utf-8?B?TMOzcGV6?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>M
List-Id: linux-omap@vger.kernel.org

T24gU3VuLCBOb3YgMTUsIDIwMTUgYXQgMTA6Mzk6NTNBTSArMDkwMCwgTWFzYWhpcm8gWWFtYWRh
IHdyb3RlOgo+IFRoZXNlIHNtcF9vcGVyYXRpb25zIHN0cnVjdHVyZXMgYXJlIG5vdCBvdmVyLXdy
aXR0ZW4sIHNvIGFkZCAiY29uc3QiCj4gcXVhbGlmaWVyIGFuZCByZXBsYWNlIF9faW5pdGRhdGEg
d2l0aCBfX2luaXRjb25zdC4KPiAKPiBBbHNvLCBhZGQgInN0YXRpYyIgd2hlcmUgaXQgaXMgcG9z
c2libGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhp
cm9Ac29jaW9uZXh0LmNvbT4KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8ay5rb3ps
b3dza2lAc2Ftc3VuZy5jb20+Cj4gQWNrZWQtYnk6IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBh
cmRAZnJlZS1lbGVjdHJvbnMuY29tPgo+IEFja2VkLWJ5OiBNb3JpdHogRmlzY2hlciA8bW9yaXR6
LmZpc2NoZXJAZXR0dXMuY29tPgo+IC0tLQoKWy4uLi5dCgo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLXZleHByZXNzL2NvcmUuaCBiL2FyY2gvYXJtL21hY2gtdmV4cHJlc3MvY29yZS5oCj4g
aW5kZXggMmExMWQzYS4uYTE2MmFiNCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9tYWNoLXZleHBy
ZXNzL2NvcmUuaAo+ICsrKyBiL2FyY2gvYXJtL21hY2gtdmV4cHJlc3MvY29yZS5oCj4gQEAgLTEs
NSArMSw1IEBACj4gIGJvb2wgdmV4cHJlc3Nfc21wX2luaXRfb3BzKHZvaWQpOwo+ICAKPiAtZXh0
ZXJuIHN0cnVjdCBzbXBfb3BlcmF0aW9ucwl2ZXhwcmVzc19zbXBfZHRfb3BzOwo+ICtleHRlcm4g
Y29uc3Qgc3RydWN0IHNtcF9vcGVyYXRpb25zIHZleHByZXNzX3NtcF9kdF9vcHM7Cj4gIAo+ICBl
eHRlcm4gdm9pZCB2ZXhwcmVzc19jcHVfZGllKHVuc2lnbmVkIGludCBjcHUpOwo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLXZleHByZXNzL3BsYXRzbXAuYyBiL2FyY2gvYXJtL21hY2gtdmV4
cHJlc3MvcGxhdHNtcC5jCj4gaW5kZXggODMxODhjZi4uOGI4ZDA3MiAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybS9tYWNoLXZleHByZXNzL3BsYXRzbXAuYwo+ICsrKyBiL2FyY2gvYXJtL21hY2gtdmV4
cHJlc3MvcGxhdHNtcC5jCj4gQEAgLTY0LDcgKzY0LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHZl
eHByZXNzX3NtcF9kdF9wcmVwYXJlX2NwdXModW5zaWduZWQgaW50IG1heF9jcHVzKQo+ICAJdmV4
cHJlc3NfZmxhZ3Nfc2V0KHZpcnRfdG9fcGh5cyh2ZXJzYXRpbGVfc2Vjb25kYXJ5X3N0YXJ0dXAp
KTsKPiAgfQo+ICAKPiAtc3RydWN0IHNtcF9vcGVyYXRpb25zIF9faW5pdGRhdGEgdmV4cHJlc3Nf
c21wX2R0X29wcyA9IHsKPiArY29uc3Qgc3RydWN0IHNtcF9vcGVyYXRpb25zIHZleHByZXNzX3Nt
cF9kdF9vcHMgX19pbml0Y29uc3QgPSB7Cj4gIAkuc21wX3ByZXBhcmVfY3B1cwk9IHZleHByZXNz
X3NtcF9kdF9wcmVwYXJlX2NwdXMsCj4gIAkuc21wX3NlY29uZGFyeV9pbml0CT0gdmVyc2F0aWxl
X3NlY29uZGFyeV9pbml0LAo+ICAJLnNtcF9ib290X3NlY29uZGFyeQk9IHZlcnNhdGlsZV9ib290
X3NlY29uZGFyeSwKClsuLi4uXQoKRm9yIHRoZSB2ZXhwcmVzcyBwYXJ0OgoKQWNrZWQtYnk6IExp
dml1IER1ZGF1IDxMaXZpdS5EdWRhdUBhcm0uY29tPgoKLS0gCj09PT09PT09PT09PT09PT09PT09
CnwgSSB3b3VsZCBsaWtlIHRvIHwKfCBmaXggdGhlIHdvcmxkLCAgfAp8IGJ1dCB0aGV5J3JlIG5v
dCB8CnwgZ2l2aW5nIG1lIHRoZSAgIHwKIFwgc291cmNlIGNvZGUhICAvCiAgLS0tLS0tLS0tLS0t
LS0tCiAgICDCr1xfKOODhClfL8KvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QKTGludXgtbWVkaWF0ZWtA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW1lZGlhdGVrCg==
