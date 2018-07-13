From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fbdev: omapfb: off by one in omapfb_register_client()
Date: Fri, 13 Jul 2018 18:05:17 +0300
Message-ID: <20180713150235.yxksf4iw7snuerze@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Imre Deak <imre.deak@solidboot.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

VGhlIG9tYXBmYl9yZWdpc3Rlcl9jbGllbnRbXSBhcnJheSBoYXMgT01BUEZCX1BMQU5FX05VTSBl
bGVtZW50cyBzbyB0aGUKPiBzaG91bGQgYmUgPj0gb3Igd2UgYXJlIG9uZSBlbGVtZW50IGJleW9u
ZCB0aGUgZW5kIG9mIHRoZSBhcnJheS4KCkZpeGVzOiA4YjA4Y2YyYjY0ZjUgKCJPTUFQOiBhZGQg
VEkgT01BUCBmcmFtZWJ1ZmZlciBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9m
YmRldi9vbWFwL29tYXBmYl9tYWluLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvb21hcGZi
X21haW4uYwppbmRleCA1ODVmMzllZmNmZjYuLjFjNzVmNDgwNmVkMyAxMDA2NDQKLS0tIGEvZHJp
dmVycy92aWRlby9mYmRldi9vbWFwL29tYXBmYl9tYWluLmMKKysrIGIvZHJpdmVycy92aWRlby9m
YmRldi9vbWFwL29tYXBmYl9tYWluLmMKQEAgLTk1OCw3ICs5NTgsNyBAQCBpbnQgb21hcGZiX3Jl
Z2lzdGVyX2NsaWVudChzdHJ1Y3Qgb21hcGZiX25vdGlmaWVyX2Jsb2NrICpvbWFwZmJfbmIsCiB7
CiAJaW50IHI7CiAKLQlpZiAoKHVuc2lnbmVkKW9tYXBmYl9uYi0+cGxhbmVfaWR4ID4gT01BUEZC
X1BMQU5FX05VTSkKKwlpZiAoKHVuc2lnbmVkKW9tYXBmYl9uYi0+cGxhbmVfaWR4ID49IE9NQVBG
Ql9QTEFORV9OVU0pCiAJCXJldHVybiAtRUlOVkFMOwogCiAJaWYgKCFub3RpZmllcl9pbml0ZWQp
IHsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
