From: =?UTF-8?q?Teresa=20G=C3=A1mez?= <t.gamez@phytec.de>
Subject: [PATCH] mtd: nand: omap2: Fix oobfree offset
Date: Fri, 19 Jul 2013 11:13:22 +0200
Message-ID: <1374225202-26518-1-git-send-email-t.gamez@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org
Cc: tony@atomide.com, artem.bityutskiy@linux.intel.com, afzal@ti.com, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

VGhlIGNhbGN1bGF0aW9uIG9mIHRoZSBvb2JmcmVlWzBdLm9mZnNldCBpcyB3cm9uZyB3aGVuIHVz
aW5nIEJDSDgKYW5kIGVsbS4KClRoZSBsYXlvdXQtPmVjY2J5dGVzIGlzIGFscmVhZHkgc3RlcHMq
aW5mby0+bmFuZC5lY2MuYnl0ZXMuIFRoZSBzZWNvbmQKbXVsdGlwbGljYXRpb24gd2l0aCBzdGVw
cyBpcyB0b28gbXVjaCBhbmQgd2lsbCBjcmVhdGUgYSB2YWx1ZQpsYXJnZXIgdGhhbiB0aGUgb29i
IGFyZWEuCgpGaXhlZCB0aGUgY2FsY3VsYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBUZXJlc2EgR8Oh
bWV6IDx0LmdhbWV6QHBoeXRlYy5kZT4KLS0tCiBkcml2ZXJzL210ZC9uYW5kL29tYXAyLmMgfCAg
ICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMgYi9kcml2ZXJzL210ZC9uYW5k
L29tYXAyLmMKaW5kZXggODFiODBhZi4uOTIyNzA2YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQv
bmFuZC9vbWFwMi5jCisrKyBiL2RyaXZlcnMvbXRkL25hbmQvb21hcDIuYwpAQCAtMTc5MCw3ICsx
NzkwLDcgQEAgc3RhdGljIGludCBvbWFwM19pbml0X2JjaF90YWlsKHN0cnVjdCBtdGRfaW5mbyAq
bXRkKQogCQlsYXlvdXQtPmVjY3Bvc1tpXSA9IG9mZnNldCArIGk7CiAKIAlpZiAoaW5mby0+aXNf
ZWxtX3VzZWQgJiYgKGluZm8tPm5hbmQuZWNjLmJ5dGVzID09IEJDSDhfU0laRSkpCi0JCWxheW91
dC0+b29iZnJlZVswXS5vZmZzZXQgPSAyICsgbGF5b3V0LT5lY2NieXRlcyAqIHN0ZXBzOworCQls
YXlvdXQtPm9vYmZyZWVbMF0ub2Zmc2V0ID0gMiArIGxheW91dC0+ZWNjYnl0ZXM7CiAJZWxzZQog
CQlsYXlvdXQtPm9vYmZyZWVbMF0ub2Zmc2V0ID0gMjsKIAotLSAKMS43LjAuNAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eCBNVEQg
ZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1tdGQvCg==
