From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH -pm 2/2] SDRC: whitespace cleanups in DLL lock code
Date: Mon, 15 Jun 2009 15:42:55 -0700
Message-ID: <1245105775-28844-3-git-send-email-khilman@deeprootsystems.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
 <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:59721 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZFOWnC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 18:43:02 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2492642qwd.37
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 15:43:04 -0700 (PDT)
In-Reply-To: <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Chan <mikechan@google.com>, Richard Woodruff <r-woodruff2@ti.com>

From: Richard Woodruff <r-woodruff2@ti.com>

---
 arch/arm/mach-omap2/sleep34xx.S |   52 +++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index c469bbe..263fb1e 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -586,37 +586,37 @@ skip_l2_inval:
 
 /* Make sure SDRC accesses are ok */
 wait_sdrc_ok:
-        ldr     r4, cm_idlest1_core
-        ldr     r5, [r4]
-        and     r5, r5, #0x2
-        cmp     r5, #0
-        bne     wait_sdrc_ok
-        ldr     r4, sdrc_power
-        ldr     r5, [r4]
-        bic     r5, r5, #0x40
-        str     r5, [r4]
+	ldr	r4, cm_idlest1_core
+	ldr	r5, [r4]
+	and	r5, r5, #0x2
+	cmp	r5, #0
+	bne	wait_sdrc_ok
+	ldr	r4, sdrc_power
+	ldr	r5, [r4]
+	bic	r5, r5, #0x40
+	str	r5, [r4]
 is_dll_in_lock_mode:
-        ldr     r4, sdrc_dlla_ctrl
-        ldr     r5, [r4]
-        tst     r5, #0x4
-        bxne    lr
-        /* wait till dll locks */
+	ldr	r4, sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	tst	r5, #0x4
+	bxne	lr
+	/* wait till dll locks */
 wait_dll_lock_timed:
-        ldr     r4, sdrc_dlla_status
-        mov     r6, #0x2000
+	ldr	r4, sdrc_dlla_status
+	mov	r6, #0x2000
 wait_dll_lock:
-        subs    r6, r6, #0x1
-        beq     kick_dll
-        ldr     r5, [r4]
-        and     r5, r5, #0x4
-        cmp     r5, #0x4
-        bne     wait_dll_lock
-        bx      lr
+	subs	r6, r6, #0x1
+	beq	kick_dll
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x4
+	bne	wait_dll_lock
+	bx	lr
 
-        /* Kick DLL state machine if lock not started */
+	/* Kick DLL state machine if lock not started */
 kick_dll:
-	ldr     r4, sdrc_dlla_ctrl	/* get dlla addr */
-	ldr     r5, [r4]		/* grab value */
+	ldr	r4, sdrc_dlla_ctrl	/* get dlla addr */
+	ldr	r5, [r4]		/* grab value */
 	mov	r6, r5			/* save value */
 	orr	r6, r6, #0x10		/* dllidle on */
 	str	r6, [r4]
-- 
1.6.3.2

