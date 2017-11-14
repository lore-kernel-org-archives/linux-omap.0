From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] OMAPFB: prevent buffer underflow in omapfb_parse_vram_param()
Date: Tue, 14 Nov 2017 09:12:28 +0300
Message-ID: <20171114061228.iv5irewl6ougl4zm@mwanda>
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
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org

V2UgY2FwIHRoZSB1cHBlciBib3VuZCBvZiAiZmJudW0iIGJ1dCB3ZSBhbHNvIG5lZWQgdG8gY2hl
Y2sgZm9yCm5lZ2F0aXZlcyBvciBtYWtlIHRoZSB0eXBlIHVuc2lnbmVkLgoKU2lnbmVkLW9mZi1i
eTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvb21hcGZiL29tYXBmYi1tYWluLmMgYi9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L29tYXAyL29tYXBmYi9vbWFwZmItbWFpbi5jCmluZGV4IDFkN2MwMTJmMDlk
Yi4uZTA4ZTU2NjRlMzMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAyL29t
YXBmYi9vbWFwZmItbWFpbi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvb21hcGZi
L29tYXBmYi1tYWluLmMKQEAgLTE0NzcsNyArMTQ3Nyw3IEBAIHN0YXRpYyBpbnQgb21hcGZiX2Fs
bG9jX2ZibWVtX2Rpc3BsYXkoc3RydWN0IGZiX2luZm8gKmZiaSwgdW5zaWduZWQgbG9uZyBzaXpl
LAogc3RhdGljIGludCBvbWFwZmJfcGFyc2VfdnJhbV9wYXJhbShjb25zdCBjaGFyICpwYXJhbSwg
aW50IG1heF9lbnRyaWVzLAogCQl1bnNpZ25lZCBsb25nICpzaXplcywgdW5zaWduZWQgbG9uZyAq
cGFkZHJzKQogewotCWludCBmYm51bTsKKwl1bnNpZ25lZCBpbnQgZmJudW07CiAJdW5zaWduZWQg
bG9uZyBzaXplOwogCXVuc2lnbmVkIGxvbmcgcGFkZHIgPSAwOwogCWNoYXIgKnAsICpzdGFydDsK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
