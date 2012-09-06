From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT* read/write
Date: Thu, 6 Sep 2012 12:05:45 +0530
Message-ID: <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae934075bb72ae004c902b487
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38414 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab2IFGgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 02:36:07 -0400
Received: by obbwc20 with SMTP id wc20so4086665obb.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 23:36:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--14dae934075bb72ae004c902b487
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Sep 6, 2012 at 5:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
> AUXCOREBOOT1 register contents twice.  This seems like a waste of
> time, so, remove the duplicates.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Looks fine to me. Thanks Paul.
Reviewed-by: Santosh Shilimkar ,santosh.shilimkar@ti.com>

While reviewing your patch, i noticed a typo in the code.
Since the patch fixes nearby code as the subject patch, I generated
that patch on top of yours. Same is end of the email as well as
attachment. The patch applies on top of your patch.

Regards
Santosh

>From 5fcd24e5782e502aa607b73de78be68b394f9639 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 6 Sep 2012 11:51:34 +0530
Subject: [PATCH] ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT register
 save

The wakeupgen context-save code reads AUXCOREBOOT0 register
instead of AUXCOREBOOT1 register contents while saving AUXCOREBOOT1.

Fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index b55432d..567f672 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -229,7 +229,7 @@ static inline void omap4_irq_save_context(void)
 	/* Save AuxBoot* registers */
 	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-- 
1.7.9.5

--14dae934075bb72ae004c902b487
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h6rhf7s10

RnJvbSA1ZmNkMjRlNTc4MmU1MDJhYTYwN2I3M2RlNzhiZTY4YjM5NGY5NjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDYgU2VwIDIwMTIgMTE6NTE6MzQgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBBUk06IE9NQVA0OiB3YWtldXBnZW46IEZpeCB0aGUgdHlwbyBpbiBBVVhDT1JFQk9PVCBy
ZWdpc3Rlcgogc2F2ZQoKVGhlIHdha2V1cGdlbiBjb250ZXh0LXNhdmUgY29kZSByZWFkcyBBVVhD
T1JFQk9PVDAgcmVnaXN0ZXIKaW5zdGVhZCBvZiBBVVhDT1JFQk9PVDEgcmVnaXN0ZXIgY29udGVu
dHMgd2hpbGUgc2F2aW5nIEFVWENPUkVCT09UMS4KCkZpeCB0aGUgc2FtZS4KClNpZ25lZC1vZmYt
Ynk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5jb20+Ci0tLQogYXJj
aC9hcm0vbWFjaC1vbWFwMi9vbWFwLXdha2V1cGdlbi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwLXdha2V1cGdlbi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLXdh
a2V1cGdlbi5jCmluZGV4IGI1NTQzMmQuLjU2N2Y2NzIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvb21hcC13YWtldXBnZW4uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAt
d2FrZXVwZ2VuLmMKQEAgLTIyOSw3ICsyMjksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgb21hcDRf
aXJxX3NhdmVfY29udGV4dCh2b2lkKQogCS8qIFNhdmUgQXV4Qm9vdCogcmVnaXN0ZXJzICovCiAJ
dmFsID0gX19yYXdfcmVhZGwod2FrZXVwZ2VuX2Jhc2UgKyBPTUFQX0FVWF9DT1JFX0JPT1RfMCk7
CiAJX19yYXdfd3JpdGVsKHZhbCwgc2FyX2Jhc2UgKyBBVVhDT1JFQk9PVDBfT0ZGU0VUKTsKLQl2
YWwgPSBfX3Jhd19yZWFkbCh3YWtldXBnZW5fYmFzZSArIE9NQVBfQVVYX0NPUkVfQk9PVF8wKTsK
Kwl2YWwgPSBfX3Jhd19yZWFkbCh3YWtldXBnZW5fYmFzZSArIE9NQVBfQVVYX0NPUkVfQk9PVF8x
KTsKIAlfX3Jhd193cml0ZWwodmFsLCBzYXJfYmFzZSArIEFVWENPUkVCT09UMV9PRkZTRVQpOwog
CiAJLyogU2F2ZSBTeW5jUmVxIGdlbmVyYXRpb24gbG9naWMgKi8KLS0gCjEuNy45LjUKCg==
--14dae934075bb72ae004c902b487--
