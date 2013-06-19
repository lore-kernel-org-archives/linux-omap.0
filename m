From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] arm: add bandgap DT entry for OMAP5
Date: Tue, 18 Jun 2013 22:36:38 -0400
Message-ID: <1371609398-26454-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: benoit.cousson@linaro.org
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, J Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

QWRkIGJhbmRnYXAgZGV2aWNlIERUIGVudHJ5IGZvciBPTUFQNSBkdHNpLgoKQ2M6ICJCZW5vw650
IENvdXNzb24iIDxiLWNvdXNzb25AdGkuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9t
aWRlLmNvbT4KQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4KQ2M6IGxp
bnV4LW9tYXBAdmdlci5rZXJuZWwub3JnCkNjOiBkZXZpY2V0cmVlLWRpc2N1c3NAbGlzdHMub3ps
YWJzLm9yZwpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEVkdWFyZG8gVmFsZW50aW4g
PGVkdWFyZG8udmFsZW50aW5AdGkuY29tPgpTaWduZWQtb2ZmLWJ5OiBKIEtlZXJ0aHkgPGota2Vl
cnRoeUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUuZHRzaSB8IDggKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKLS0tCgpCZW5vaXQsCgpTb3JyeSBm
b3IgdGhpcyB2ZXJ5IGxhdGUgcmVxdWVzdCwgYnV0IGNhbiB5b3UgcGxlYXNlIGNvbnNpZGVyCnRo
ZXNlIHBhdGNoZXMgZm9yIDMuMTEgc3RpbGw/CgpJIGNvbXBsZXRlbHkgZm9yZ290IHRvIHNlbmQg
dGhlc2Ugb24gbXkgIkVuYWJsZSBUSSBTb0MgdGhlcm1hbCBkcml2ZXIiIHNlcmllcy4KCkFsbCBi
ZXN0LAoKRWR1YXJkbwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LmR0c2kg
Yi9hcmNoL2FybS9ib290L2R0cy9vbWFwNS5kdHNpCmluZGV4IDJhZDYzYzQuLjVlZGU2ZTEgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvb21hcDUuZHRzaQpAQCAtNjE1LDUgKzYxNSwxMyBAQAogCQkJaW50ZXJydXB0cyA9IDww
IDgwIDB4ND47CiAJCQl0aSxod21vZHMgPSAid2RfdGltZXIyIjsKIAkJfTsKKwkJYmFuZGdhcCB7
CisJCQlyZWcgPSA8MHg0YTAwMjFlMCAweGMKKwkJCQkweDRhMDAyMzJjIDB4YworCQkJCTB4NGEw
MDIzODAgMHgyYworCQkJCTB4NGEwMDIzQzAgMHgzYz47CisJCQkJaW50ZXJydXB0cyA9IDwwIDEy
NiA0PjsgLyogdGFsZXJ0ICovCisJCQljb21wYXRpYmxlID0gInRpLG9tYXA1NDMwLWJhbmRnYXAi
OworCQl9OwogCX07CiB9OwotLSAKMS44LjIuMS4zNDIuZ2ZhNzI4NWQKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
