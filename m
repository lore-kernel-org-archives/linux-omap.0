From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v5 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
Date: Tue, 27 Dec 2011 20:40:31 +0800
Message-ID: <CAGsJ_4wFZHrnKv-aYkm11iHjgmjgHZQ3UJ2yofC2fPYa+RMidg@mail.gmail.com>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infra
List-Id: linux-omap@vger.kernel.org

MjAxMS8xMi8xNyBEYXZlIE1hcnRpbiA8ZGF2ZS5tYXJ0aW5AbGluYXJvLm9yZz46Cj4gTWFraW5n
IENBQ0hFX0wyWDAgZGVwZW5kIG9uIChodWdlIGxpc3Qgb2YgTUFDSF8gYW5kIEFSQ0hfIGNvbmZp
Z3MpCj4gaXMgYm90aGVyc29tZSB0byBtYWludGFpbiBhbmQgbGlrZWx5IHRvIGxlYWQgdG8gbWVy
Z2UgY29uZmxpY3RzLgo+Cj4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUga25vd2xlZGdlIG9mIHdoaWNo
IHBsYXRmb3JtcyBoYXZlIGEgTDJ4MCBvcgo+IFBMMzEwIGNhY2hlIGNvbnRyb2xsZXIgdG8gdGhl
IGluZGl2aWR1YWwgbWFjaGluZXMuIMKgVG8gZW5hYmxlIHRoaXMsCj4gYSBuZXcgTUlHSFRfSEFW
RV9DQUNIRV9MMlgwIGNvbmZpZyBvcHRpb24gaXMgaW50cm9kdWNlZCB0byBhbGxvdwo+IG1hY2hp
bmVzIHRvIGluZGljYXRlIHRoYXQgdGhleSBtYXkgaGF2ZSBzdWNoIGEgY2FjaGUgY29udHJvbGxl
cgo+IGluZGVwZW5kZW50bHkgb2YgZWFjaCBvdGhlci4KPgo+IEJvYXJkcy9Tb0NzIHdoaWNoIGNh
bm5vdCByZWxpYWJseSBvcGVyYXRlIHdpdGhvdXQgdGhlIEwyIGNhY2hlCj4gY29udHJvbGxlciBz
dXBwb3J0IHdpbGwgbmVlZCB0byBzZWxlY3QgQ0FDSEVfTDJYMCBkaXJlY3RseSBmcm9tCj4gdGhl
aXIgb3duIEtjb25maWdzIGluc3RlYWQuIMKgVGhpcyBhcHBsaWVzIHRvIHNvbWUgVHJ1c3Rab25l
LWVuYWJsZWQKPiBib2FyZHMgd2hlcmUgTGludXggcnVucyBpbiB0aGUgTm9ybWFsIFdvcmxkLCBm
b3IgZXhhbXBsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxkYXZlLm1hcnRpbkBs
aW5hcm8ub3JnPgo+IEFja2VkLWJ5OiBBbnRvbiBWb3JvbnRzb3YgPGNib3VhdG1haWxydUBnbWFp
bC5jb20+Cj4gwqAgwqAgwqAgwqAoZm9yIGNuczN4eHgpCj4gQWNrZWQtYnk6IFRvbnkgTGluZGdy
ZW4gPHRvbnlAYXRvbWlkZS5jb20+Cj4gwqAgwqAgwqAgwqAoZm9yIG9tYXApCj4gQWNrZWQtYnk6
IFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+Cj4gwqAgwqAgwqAgwqAoZm9yIGlteCkK
CkFja2VkLWJ5OiBCYXJyeSBTb25nIDxiYW9odWEuc29uZ0Bjc3IuY29tPgogICAgICAgIChmb3Ig
cHJpbWEyKQo+IC0tLQo+IMKgYXJjaC9hcm0vS2NvbmZpZyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8
IMKgIMKgOCArKysrKysrKwo+IMKgYXJjaC9hcm0vbWFjaC1leHlub3MvS2NvbmZpZyDCoCB8IMKg
IMKgMSArCj4gwqBhcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcgwqAgwqB8IMKgIMKgMSArCj4g
wqBhcmNoL2FybS9tYWNoLXJlYWx2aWV3L0tjb25maWcgfCDCoCDCoDUgKysrKysKPiDCoGFyY2gv
YXJtL21hY2gtdmV4cHJlc3MvS2NvbmZpZyB8IMKgIMKgMSArCj4gwqBhcmNoL2FybS9tbS9LY29u
ZmlnIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCAyMyArKysrKysrKysrKysrKysrLS0tLS0tLQo+IMKg
YXJjaC9hcm0vcGxhdC1teGMvS2NvbmZpZyDCoCDCoCDCoHwgwqAgwqAxICsKPiDCoDcgZmlsZXMg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
