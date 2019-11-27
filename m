From: Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 07/13] video: omapfb: use const pointer for
 fb_ops
Date: Wed, 27 Nov 2019 18:32:03 +0200
Message-ID: <609dbe6eefdfd0138aa5d2d4ceeb58684811dc6e.1574871797.git.jani.nikula@intel.com>
References: <cover.1574871797.git.jani.nikula@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

VXNlIGNvbnN0IGZvciBmYl9vcHMgdG8gbGV0IHVzIG1ha2UgdGhlIGluZm8tPmZib3BzIHBvaW50
ZXIgY29uc3QgaW4gdGhlCmZ1dHVyZS4KCkNjOiBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEphbmkgTmlrdWxh
IDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+Ci0tLQogZHJpdmVycy92aWRlby9mYmRldi9vbWFwL29t
YXBmYl9tYWluLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvb21hcGZiX21h
aW4uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcC9vbWFwZmJfbWFpbi5jCmluZGV4IDcwMmNj
YTU5YmRhMS4uZThhMzA0Zjg0ZWE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29t
YXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvb21hcGZiX21h
aW4uYwpAQCAtMTA1Miw3ICsxMDUyLDcgQEAgc3RhdGljIGludCBvbWFwZmJfaW9jdGwoc3RydWN0
IGZiX2luZm8gKmZiaSwgdW5zaWduZWQgaW50IGNtZCwKIHsKIAlzdHJ1Y3Qgb21hcGZiX3BsYW5l
X3N0cnVjdCAqcGxhbmUgPSBmYmktPnBhcjsKIAlzdHJ1Y3Qgb21hcGZiX2RldmljZQkqZmJkZXYg
PSBwbGFuZS0+ZmJkZXY7Ci0Jc3RydWN0IGZiX29wcwkJKm9wcyA9IGZiaS0+ZmJvcHM7CisJY29u
c3Qgc3RydWN0IGZiX29wcyAqb3BzID0gZmJpLT5mYm9wczsKIAl1bmlvbiB7CiAJCXN0cnVjdCBv
bWFwZmJfdXBkYXRlX3dpbmRvdwl1cGRhdGVfd2luZG93OwogCQlzdHJ1Y3Qgb21hcGZiX3BsYW5l
X2luZm8JcGxhbmVfaW5mbzsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vaW50ZWwtZ2Z4
