From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Tue, 25 May 2010 14:39:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
References: <Tarun Kanti DebBarma <tarun.kanti@ti.com>
 <1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab0EYJJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 05:09:18 -0400
In-Reply-To: <1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

(Including ARM mailing list)

From: Tarun Kanti Debbarma <a0876346@a0876346-desktop.(none)>

This patch attempts to fix two related problems:

(1) vfp_get_double(), vfp_put_double() functions have VFPv3 specific implementation
guarded within CONFIG_VFPv3 macro. The intent is to access {d16-d31} additional registers
provided in VFPv3. However, it still wrongly refers to {d0-d15}. This has been corrected.

(2) While compiling the above changes, it produced compilation error because arch/arm/vfp/Makefile
had the -mfpu=vfp option which could not recognize VFPv3 registers. This has been corrected to
-mfpu=vfp3. With this option we are also able to compile pre-VFPv3 code.

Signed-off-by: Tarun Kanti Debbarma <tarun.kanti@ti.com>
---
 arch/arm/vfp/Makefile |    2 +-
 arch/arm/vfp/vfphw.S  |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 arch/arm/vfp/vfphw.S

diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index 39f6d8e..75855c0 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -7,7 +7,7 @@
 # EXTRA_CFLAGS := -DDEBUG
 # EXTRA_AFLAGS := -DDEBUG
 
-KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
+KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=vfp3 -mfloat-abi=softfp)
 LDFLAGS		+=--no-warn-mismatch
 
 obj-y			+= vfp.o
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
old mode 100644
new mode 100755
index 66dc2d0..b034076
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -254,8 +254,8 @@ ENTRY(vfp_get_double)
 	.endr
 #ifdef CONFIG_VFPv3
 	@ d16 - d31 registers
-	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-1:	mrrc	p11, 3, r0, r1, c\dr	@ fmrrd	r0, r1, d\dr
+	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+1:	fmrrd	r0, r1, d\dr
 	mov	pc, lr
 	.org	1b + 8
 	.endr
@@ -276,8 +276,8 @@ ENTRY(vfp_put_double)
 	.endr
 #ifdef CONFIG_VFPv3
 	@ d16 - d31 registers
-	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-1:	mcrr	p11, 3, r1, r2, c\dr	@ fmdrr	r1, r2, d\dr
+	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+1:	fmdrr	d\dr, r1, r2
 	mov	pc, lr
 	.org	1b + 8
 	.endr
-- 
1.6.0.4

