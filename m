From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 09/10] fbdev: omap2: connector-dvi: use
 of_get_i2c_adapter_by_node interface
Date: Wed, 8 Jul 2015 16:00:16 +0300
Message-ID: <1436360416-9556-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Markus Elfring <elfring@users.sourceforge.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

VGhpcyBjaGFuZ2UgaXMgbmVlZGVkIHRvIHByb3Blcmx5IGxvY2sgSTJDIGJ1cyBkcml2ZXIsIHdo
aWNoIHNlcnZlcyBEREMuCgpQcmlvciB0byB0aGlzIGNoYW5nZSBpMmNfcHV0X2FkYXB0ZXIoKSBp
cyBtaXN1c2VkLCB3aGljaCBtYXkgbGVhZCB0bwphbiBvdmVyZmxvdyBvdmVyIHplcm8gb2YgSTJD
IGJ1cyBkcml2ZXIgdXNlciBjb3VudGVyLgoKU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgWmFwb2xz
a2l5IDx2bGFkaW1pcl96YXBvbHNraXlAbWVudG9yLmNvbT4KLS0tCiBkcml2ZXJzL3ZpZGVvL2Zi
ZGV2L29tYXAyL2Rpc3BsYXlzLW5ldy9jb25uZWN0b3ItZHZpLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L29tYXAyL2Rpc3BsYXlzLW5ldy9jb25uZWN0b3ItZHZpLmMgYi9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L29tYXAyL2Rpc3BsYXlzLW5ldy9jb25uZWN0b3ItZHZpLmMKaW5kZXggYThj
ZTkyMC4uZDgxMWU2ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9kaXNw
bGF5cy1uZXcvY29ubmVjdG9yLWR2aS5jCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIv
ZGlzcGxheXMtbmV3L2Nvbm5lY3Rvci1kdmkuYwpAQCAtMjk0LDcgKzI5NCw3IEBAIHN0YXRpYyBp
bnQgZHZpY19wcm9iZV9vZihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCiAJYWRhcHRl
cl9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShub2RlLCAiZGRjLWkyYy1idXMiLCAwKTsKIAlpZiAo
YWRhcHRlcl9ub2RlKSB7Ci0JCWFkYXB0ZXIgPSBvZl9maW5kX2kyY19hZGFwdGVyX2J5X25vZGUo
YWRhcHRlcl9ub2RlKTsKKwkJYWRhcHRlciA9IG9mX2dldF9pMmNfYWRhcHRlcl9ieV9ub2RlKGFk
YXB0ZXJfbm9kZSk7CiAJCWlmIChhZGFwdGVyID09IE5VTEwpIHsKIAkJCWRldl9lcnIoJnBkZXYt
PmRldiwgImZhaWxlZCB0byBwYXJzZSBkZGMtaTJjLWJ1c1xuIik7CiAJCQlvbWFwX2Rzc19wdXRf
ZGV2aWNlKGRkYXRhLT5pbik7Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
