From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2 v2] gpio: omap: make gpio numbering deterministical
 by using of aliases
Date: Tue, 21 Jun 2016 04:28:59 -0700
Message-ID: <20160621112858.GO22406@atomide.com>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, kernel@pengutronix.de, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiBbMTYw
NjE0IDEyOjAzXToKPiBUcmFkaXRpb25hbGx5IHRoZSBuLXRoIGdwaW8gZGV2aWNlIHByb2JlZCBi
eSB0aGUgb21hcCBncGlvIGRyaXZlciBnb3QKPiB0aGUgZ3BpbyBudW1iZXIgcmFuZ2UgW24qMzIg
Li4gbiozMiszMV0uCj4gV2hlbiBvcmRlciBvZiB0aGUgZGV2aWNlcyBwcm9iZWQgYnkgdGhlIGRy
aXZlciBjaGFuZ2VzICh3aGljaCBjYW4gaGFwcGVuCj4gYWxyZWFkeSBub3cgd2hlbiBzb21lIGRl
dmljZXMgaGF2ZSBhIHBpbmN0cmwgYW5kIHNvIHRoZSBmaXJzdCBwcm9iZQo+IGF0dGVtcHQgcmV0
dXJucyAtRU5PREVWKSB0aGUgbnVtYmVyaW5nIGNoYW5nZXMuCj4gCj4gVG8gZW5zdXJlIGEgZGV0
ZXJtaW5pc3RpY2FsIG51bWJlcmluZyB1c2Ugb2ZfYWxpYXNfZ2V0X2lkIHRvIGRldGVybWluZQo+
IHRoZSBiYXNlIGZvciBhIGdpdmVuIGRldmljZS4gSWYgbm8gcmVzcGVjdGl2ZSBhbGlhcyBleGlz
dHMgZmFsbCBiYWNrIHRvCj4gdGhlIHRyYWRpdGlvbmFsIG51bWJlcmluZy4KPiAKPiBGb3IgdGhl
IHVudXN1YWwgY2FzZSB3aGVyZSBvbmx5IGEgcGFydCBvZiB0aGUgZ3BpbyBkZXZpY2VzIGhhdmUg
YQo+IG1hdGNoaW5nIGFsaWFzIHNvbWUgb2YgdGhlbSBtaWdodCBmYWlsIHRvIHByb2JlLiBCdXQg
aWYgbm9uZSBvZiB0aGVtIGhhcwo+IGFuIGFsaWFzIG9yIGFsbCwgdGhlcmUgaXMgbm8gY29uZmxp
Y3Qgd2hpY2ggc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvCj4gbWFpbnRhaW4gYmFja3dhcmQgY29t
cGF0aWJpbGl0eS4KCkkgdGhpbmsgZG9pbmcgdGhpcyBpcyBhIGdvb2QgaWRlYSB0byBwcmV2ZW50
IG5hc3R5IHN1cHJpc2VzIHdoZW4KdXBncmFkaW5nIGEga2VybmVsIG9uIHNvbWUgZGV2aWNlOgoK
QWNrZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
