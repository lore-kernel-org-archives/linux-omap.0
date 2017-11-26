From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] video: omap: Improve a size determination in
 omapfb_do_probe()
Date: Sun, 26 Nov 2017 18:42:23 +0100
Message-ID: <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
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
OiBTdW4sIDI2IE5vdiAyMDE3IDE4OjE2OjIwICswMTAwCgpSZXBsYWNlIHRoZSBzcGVjaWZpY2F0
aW9uIG9mIGEgZGF0YSBzdHJ1Y3R1cmUgYnkgYSBwb2ludGVyIGRlcmVmZXJlbmNlCmFzIHRoZSBw
YXJhbWV0ZXIgZm9yIHRoZSBvcGVyYXRvciAic2l6ZW9mIiB0byBtYWtlIHRoZSBjb3JyZXNwb25k
aW5nIHNpemUKZGV0ZXJtaW5hdGlvbiBhIGJpdCBzYWZlciBhY2NvcmRpbmcgdG8gdGhlIExpbnV4
IGNvZGluZyBzdHlsZSBjb252ZW50aW9uLgoKVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNp
bmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuCgpTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmlu
ZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Ci0tLQogZHJpdmVycy92aWRlby9mYmRl
di9vbWFwL29tYXBmYl9tYWluLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAv
b21hcGZiX21haW4uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcC9vbWFwZmJfbWFpbi5jCmlu
ZGV4IGIwZDkxNTI0YmY2Yy4uYzQ3MDU5NDMwY2E4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVv
L2ZiZGV2L29tYXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAv
b21hcGZiX21haW4uYwpAQCAtMTY0NSw3ICsxNjQ1LDcgQEAgc3RhdGljIGludCBvbWFwZmJfZG9f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKIAkJZ290byBjbGVhbnVwOwogCX0K
IAotCWZiZGV2ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG9tYXBmYl9kZXZpY2UpLCBHRlBfS0VS
TkVMKTsKKwlmYmRldiA9IGt6YWxsb2Moc2l6ZW9mKCpmYmRldiksIEdGUF9LRVJORUwpOwogCWlm
IChmYmRldiA9PSBOVUxMKSB7CiAJCXIgPSAtRU5PTUVNOwogCQlnb3RvIGNsZWFudXA7Ci0tIAoy
LjE1LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
