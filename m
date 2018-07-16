From: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Mon, 16 Jul 2018 16:30:36 +0100
Message-ID: <5B4CBA1C.3060408@hisilicon.com>
References: <20180711110037.12928-1-bigeasy@linutronix.de>
 <20180711110037.12928-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180711110037.12928-2-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Frank Rowand <frank.rowand@am.sony.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, David Brown <david.brown@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>, tglx@linutronix.de, linux-omap@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

Ck9uIDIwMTgvNy8xMSAxMjowMCwgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToKPiBG
cm9tOiBGcmFuayBSb3dhbmQgPGZyYW5rLnJvd2FuZEBhbS5zb255LmNvbT4KPiAKPiBUaGUgYXJt
IGJvb3RfbG9jayBpcyB1c2VkIGJ5IHRoZSBzZWNvbmRhcnkgcHJvY2Vzc29yIHN0YXJ0dXAgY29k
ZS4gIFRoZSBsb2NraW5nCj4gdGFzayBpcyB0aGUgaWRsZSB0aHJlYWQsIHdoaWNoIGhhcyBpZGxl
LT5zY2hlZF9jbGFzcyA9PSAmaWRsZV9zY2hlZF9jbGFzcy4KPiBpZGxlX3NjaGVkX2NsYXNzLT5l
bnF1ZXVlX3Rhc2sgPT0gTlVMTCwgc28gaWYgdGhlIGlkbGUgdGFzayBibG9ja3Mgb24gdGhlCj4g
bG9jaywgdGhlIGF0dGVtcHQgdG8gd2FrZSBpdCB3aGVuIHRoZSBsb2NrIGJlY29tZXMgYXZhaWxh
YmxlIHdpbGwgZmFpbDoKPiAKPiB0cnlfdG9fd2FrZV91cCgpCj4gICAgLi4uCj4gICAgICAgYWN0
aXZhdGVfdGFzaygpCj4gICAgICAgICAgZW5xdWV1ZV90YXNrKCkKPiAgICAgICAgICAgICBwLT5z
Y2hlZF9jbGFzcy0+ZW5xdWV1ZV90YXNrKHJxLCBwLCBmbGFncykKPiAKPiBGaXggYnkgY29udmVy
dGluZyBib290X2xvY2sgdG8gYSByYXcgc3BpbiBsb2NrLgo+IAo+IENjOiAiQW5kcmVhcyBGw6Ry
YmVyIiA8YWZhZXJiZXJAc3VzZS5kZT4KPiBDYzogS3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9y
Zz4KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgo+IENjOiBXZWkg
WHUgPHh1d2VpNUBoaXNpbGljb24uY29tPgo+IENjOiBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPgo+IENjOiBCYXJyeSBTb25nIDxiYW9odWFAa2VybmVsLm9yZz4KPiBDYzogQW5keSBH
cm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPgo+IENjOiBEYXZpZCBCcm93biA8ZGF2aWQuYnJv
d25AbGluYXJvLm9yZz4KPiBDYzogVmlyZXNoIEt1bWFyIDx2aXJlc2hrQGtlcm5lbC5vcmc+Cj4g
Q2M6IFNoaXJheiBIYXNoaW0gPHNoaXJhei5saW51eC5rZXJuZWxAZ21haWwuY29tPgo+IENjOiBQ
YXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+Cj4gQ2M6IE1heGltZSBSaXBh
cmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+Cj4gQ2M6IENoZW4tWXUgVHNhaSA8d2Vuc0Bj
c2llLm9yZz4KPiBDYzogbGludXgtc2Ftc3VuZy1zb2NAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxp
bnV4LW9tYXBAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwu
b3JnCj4gQ2M6IGxpbnV4LXNvY0B2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBGcmFu
ayBSb3dhbmQgPGZyYW5rLnJvd2FuZEBhbS5zb255LmNvbT4KPiBMaW5rOiBodHRwOi8vbGttbC5r
ZXJuZWwub3JnL3IvNEU3N0I5NTIuMzAxMDYwNkBhbS5zb255LmNvbQo+IFNpZ25lZC1vZmYtYnk6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IFRlc3RlZC1ieTogVG9ueSBM
aW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6a0BrZXJuZWwub3JnPgo+IFRlc3RlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPiBbRXh5bm9zNTQyMiBMaW5hcm8gUE0tUUFdCj4gU2lnbmVkLW9mZi1ieTog
U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPgo+IC0tLQo+
ICBhcmNoL2FybS9tYWNoLWFjdGlvbnMvcGxhdHNtcC5jICAgfCAgNiArKystLS0KPiAgYXJjaC9h
cm0vbWFjaC1leHlub3MvcGxhdHNtcC5jICAgIHwgMTIgKysrKysrLS0tLS0tCj4gIGFyY2gvYXJt
L21hY2gtaGlzaS9wbGF0bWNwbS5jICAgICB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0KClRo
YW5rcyEKQWNrZWQtYnk6IFdlaSBYdSA8eHV3ZWk1QGhpc2lsaWNvbi5jb20+IChmb3IgbWFjaC1o
aXNpKQoKQmVzdCBSZWdhcmRzLApXZWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
