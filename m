From: Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 07/14] video: omapfb: use const pointer for fb_ops
Date: Fri, 29 Nov 2019 12:29:37 +0200
Message-ID: <dfa4376e219ffeef9175993eaff91b5fe7ecccab.1575022735.git.jani.nikula@intel.com>
References: <cover.1575022735.git.jani.nikula@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

VXNlIGNvbnN0IGZvciBmYl9vcHMgdG8gbGV0IHVzIG1ha2UgdGhlIGluZm8tPmZib3BzIHBvaW50
ZXIgY29uc3QgaW4gdGhlCmZ1dHVyZS4KCkNjOiBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnClJldmlld2VkLWJ5OiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPgpTaWduZWQtb2ZmLWJ5OiBKYW5pIE5pa3VsYSA8amFu
aS5uaWt1bGFAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vZmJkZXYvb21hcC9vbWFwZmJf
bWFpbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9vbWFwL29tYXBmYl9tYWluLmMg
Yi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvb21hcGZiX21haW4uYwppbmRleCA3MDJjY2E1OWJk
YTEuLmU4YTMwNGY4NGVhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9vbWFwL29t
YXBmYl9tYWluLmMKKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9vbWFwL29tYXBmYl9tYWluLmMK
QEAgLTEwNTIsNyArMTA1Miw3IEBAIHN0YXRpYyBpbnQgb21hcGZiX2lvY3RsKHN0cnVjdCBmYl9p
bmZvICpmYmksIHVuc2lnbmVkIGludCBjbWQsCiB7CiAJc3RydWN0IG9tYXBmYl9wbGFuZV9zdHJ1
Y3QgKnBsYW5lID0gZmJpLT5wYXI7CiAJc3RydWN0IG9tYXBmYl9kZXZpY2UJKmZiZGV2ID0gcGxh
bmUtPmZiZGV2OwotCXN0cnVjdCBmYl9vcHMJCSpvcHMgPSBmYmktPmZib3BzOworCWNvbnN0IHN0
cnVjdCBmYl9vcHMgKm9wcyA9IGZiaS0+ZmJvcHM7CiAJdW5pb24gewogCQlzdHJ1Y3Qgb21hcGZi
X3VwZGF0ZV93aW5kb3cJdXBkYXRlX3dpbmRvdzsKIAkJc3RydWN0IG9tYXBmYl9wbGFuZV9pbmZv
CXBsYW5lX2luZm87Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbA==
