From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] video: omap: Delete an error message for a failed memory
 allocation in mipid_spi_probe()
Date: Sun, 26 Nov 2017 18:43:17 +0100
Message-ID: <62f8d5bb-64cd-487f-6ef4-e3aa7a8b5fd5@users.sourceforge.net>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBTdW4sIDI2IE5vdiAyMDE3IDE4OjIxOjI1ICswMTAwCgpPbWl0IGFuIGV4dHJhIG1lc3NhZ2Ug
Zm9yIGEgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBpbiB0aGlzIGZ1bmN0aW9uLgoKVGhpcyBp
c3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNpbmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuCgpTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+
Ci0tLQogZHJpdmVycy92aWRlby9mYmRldi9vbWFwL2xjZF9taXBpZC5jIHwgNCArLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aWRlby9mYmRldi9vbWFwL2xjZF9taXBpZC5jIGIvZHJpdmVycy92aWRlby9mYmRl
di9vbWFwL2xjZF9taXBpZC5jCmluZGV4IGUzYTg1NDMyZjkyNi4uZTcxYjY3NGI0N2Q4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvbGNkX21pcGlkLmMKKysrIGIvZHJpdmVy
cy92aWRlby9mYmRldi9vbWFwL2xjZF9taXBpZC5jCkBAIC01NjQsMTAgKzU2NCw4IEBAIHN0YXRp
YyBpbnQgbWlwaWRfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCiAJaW50IHI7CiAK
IAltZCA9IGt6YWxsb2Moc2l6ZW9mKCptZCksIEdGUF9LRVJORUwpOwotCWlmIChtZCA9PSBOVUxM
KSB7Ci0JCWRldl9lcnIoJnNwaS0+ZGV2LCAib3V0IG9mIG1lbW9yeVxuIik7CisJaWYgKCFtZCkK
IAkJcmV0dXJuIC1FTk9NRU07Ci0JfQogCiAJc3BpLT5tb2RlID0gU1BJX01PREVfMDsKIAltZC0+
c3BpID0gc3BpOwotLSAKMi4xNS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
