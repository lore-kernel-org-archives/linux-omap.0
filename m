From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCHv2 8/9] ARM: dts: keystone-k2g: add DSS node
Date: Mon, 18 Jun 2018 16:22:41 +0300
Message-ID: <20180618132242.8673-9-tomi.valkeinen@ti.com>
References: <20180618132242.8673-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180618132242.8673-1-tomi.valkeinen@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

QWRkIERTUyBub2RlIHRvIGsyZy5kdHNpLgoKU2lnbmVkLW9mZi1ieTogVG9taSBWYWxrZWluZW4g
PHRvbWkudmFsa2VpbmVuQHRpLmNvbT4KQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnCi0t
LQogYXJjaC9hcm0vYm9vdC9kdHMva2V5c3RvbmUtazJnLmR0c2kgfCAyMSArKysrKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMva2V5c3RvbmUtazJnLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9r
ZXlzdG9uZS1rMmcuZHRzaQppbmRleCBkYTc4YzAwMzQ0MjcuLmQ3NjFmZTdkNDZlNyAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMva2V5c3RvbmUtazJnLmR0c2kKKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMva2V5c3RvbmUtazJnLmR0c2kKQEAgLTYwOSw1ICs2MDksMjYgQEAKIAkJCXJlZyA9
IDwweDIxMDEwMDAwIDB4MjAwPjsKIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMjMgSVJRX1RZ
UEVfRURHRV9SSVNJTkc+OwogCQl9OworCisJCWRzczogZHNzQDAyNTQwMDAwIHsKKwkJCWNvbXBh
dGlibGUgPSAidGksazJnLWRzcyI7CisKKwkJCXJlZyA9IDwweDAyNTQwMDAwIDB4NDAwPiwKKwkJ
CSAgICAgIDwweDAyNTUwMDAwIDB4MTAwMD4sCisJCQkgICAgICA8MHgwMjU1NzAwMCAweDEwMDA+
LAorCQkJICAgICAgPDB4MDI1NWE4MDAgMHgxMDA+LAorCQkJICAgICAgPDB4MDI1NWFjMDAgMHgx
MDA+OworCisJCQlyZWctbmFtZXMgPSAiY2ZnIiwgImNvbW1vbiIsICJ2aWQxIiwgIm92cjEiLCAi
dnAxIjsKKworCQkJY2xvY2tzID0gPCZrMmdfY2xrcyAweDIgMD4sIDwmazJnX2Nsa3MgMHgyIDE+
OworCQkJY2xvY2stbmFtZXMgPSAiZmNrIiwgInZwMSI7CisKKwkJCXBvd2VyLWRvbWFpbnMgPSA8
JmsyZ19wZHMgMHgyPjsKKworCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDI0NyBJUlFfVFlQRV9F
REdFX1JJU0lORz47CisKKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CisJCX07CiAJfTsKIH07Ci0t
IApUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBI
ZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21p
Y2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
