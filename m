From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] video: omap: Delete an error message for a failed memory
 allocation in omapfb_do_probe()
Date: Sun, 26 Nov 2017 18:41:32 +0100
Message-ID: <e6b19a4a-566b-d1a0-1847-ed1167e118b6@users.sourceforge.net>
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
OiBTdW4sIDI2IE5vdiAyMDE3IDE4OjA5OjE1ICswMTAwCgpPbWl0IGFuIGV4dHJhIG1lc3NhZ2Ug
Zm9yIGEgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBpbiB0aGlzIGZ1bmN0aW9uLgoKVGhpcyBp
c3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNpbmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuCgpTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+
Ci0tLQogZHJpdmVycy92aWRlby9mYmRldi9vbWFwL29tYXBmYl9tYWluLmMgfCAyIC0tCiAxIGZp
bGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L29tYXAvb21hcGZiX21haW4uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcC9vbWFwZmJf
bWFpbi5jCmluZGV4IDM0NzlhNDdhMzA4Mi4uYjBkOTE1MjRiZjZjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L29tYXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L29tYXAvb21hcGZiX21haW4uYwpAQCAtMTY0Nyw4ICsxNjQ3LDYgQEAgc3RhdGljIGludCBv
bWFwZmJfZG9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKIAogCWZiZGV2ID0g
a3phbGxvYyhzaXplb2Yoc3RydWN0IG9tYXBmYl9kZXZpY2UpLCBHRlBfS0VSTkVMKTsKIAlpZiAo
ZmJkZXYgPT0gTlVMTCkgewotCQlkZXZfZXJyKCZwZGV2LT5kZXYsCi0JCQkidW5hYmxlIHRvIGFs
bG9jYXRlIG1lbW9yeSBmb3IgZGV2aWNlIGluZm9cbiIpOwogCQlyID0gLUVOT01FTTsKIAkJZ290
byBjbGVhbnVwOwogCX0KLS0gCjIuMTUuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
