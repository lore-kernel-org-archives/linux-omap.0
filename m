From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][RFC] OMAP3: PM: Prevent hang in prcm_interrupt_handler
Date: Mon, 22 Jun 2009 16:44:11 -0700
Message-ID: <87prcv25ro.fsf@deeprootsystems.com>
References: <1245452921-24142-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:14384 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbZFVXoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 19:44:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1572290wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 16:44:14 -0700 (PDT)
In-Reply-To: <1245452921-24142-1-git-send-email-jon-hunter@ti.com> (Jon Hunter's message of "Fri\, 19 Jun 2009 18\:08\:41 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org

Jon Hunter <jon-hunter@ti.com> writes:

> From: Jon Hunter <jon-hunter@ti.com>
>
> There are two scenarios where a race condition could result in a hang in the
> prcm_interrupt handler. These are:

IIRC, the RX51 tree has a workaround for some hangs seen in this
interrupt handler as well, so this has definitely been seen.  The fix
there though was just to no loop, I think your fix is more thorough 
and fixes the root cause.  Thanks.

No comments on the funtional changes, but a couple
cosmetic/documentation changes.

1) Would it be possible to summarize the requirements in the function
itself as part of this patch.

2) With the extra indentation, this function is getting too indented.
Looking closer, an abstraction of the 'enable clocks, poll PM_WKST,
disable clocks loop' could be done an called with the various modules
and offsets.  I've attached a hack/patch below to show what I mean.
You could just fold this into your patch.

Kevin

> 1). Waiting for PRM_IRQSTATUS_MPU register to clear.
> Bit 0 of the PRM_IRQSTATUS_MPU register indicates that a wake-up event is
> pending for the MPU. This bit can only be cleared if the all the wake-up events
> latched in the various PM_WKST_x registers have been cleared. If a wake-up event
> occurred during the processing of the prcm interrupt handler, after the
> corresponding PM_WKST_x register was checked but before the PRM_IRQSTATUS_MPU
> was cleared, then the CPU would be stuck forever waiting for bit 0 in
> PRM_IRQSTATUS_MPU to be cleared.
>
> 2). Waiting for the PM_WKST_x register to clear.
> Some power domains have more than one wake-up source. The PM_WKST_x registers
> indicate the source of a wake-up event and need to be cleared after a wake-up
> event occurs. When the PM_WKST_x registers are read and before they are cleared,
> it is possible that another wake-up event could occur causing another bit to be
> set in one of the PM_WKST_x registers. If this did occur after reading a
> PM_WKST_x register then the CPU would miss this event and get stuck forever in
> a loop waiting for that PM_WKST_x register to clear.
>
> This patch address the above race conditions that would result in a hang.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

commit 6b95e05225d5f4fa9aaf8400f5b6dd056fd8ce91
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Mon Jun 22 16:17:57 2009 -0700

    temp: merge into PRCM interrupt fix

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0545262..708816c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -194,109 +194,40 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 	}
 }
 
+static void prcm_clear_mod_irqs(s16 module, u16 wkst_off,
+				u16 iclk_off, u16 fclk_off) {
+	u32 wkst, fclk, iclk;
+
+	wkst = prm_read_mod_reg(module, wkst_off);
+	if (wkst) {
+		iclk = cm_read_mod_reg(module, iclk_off);
+		fclk = cm_read_mod_reg(module, fclk_off);
+		while (wkst) {
+			cm_set_mod_reg_bits(wkst, module, iclk_off);
+			cm_set_mod_reg_bits(wkst, module, fclk_off);
+			prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = prm_read_mod_reg(module, wkst_off);
+		}
+		cm_write_mod_reg(iclk, module, iclk_off);
+		cm_write_mod_reg(fclk, module, fclk_off);
+	}
+}
+
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
-	u32 wkst, irqstatus_mpu;
-	u32 fclk, iclk;
+	u32 irqstatus_mpu;
 
 	do {
-		/* WKUP */
-		wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
-		if (wkst) {
-			iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
-			fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
-			while (wkst) {
-				cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_ICLKEN);
-				cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_FCLKEN);
-				prm_write_mod_reg(wkst, WKUP_MOD, PM_WKST);
-				wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
-			}
-			cm_write_mod_reg(iclk, WKUP_MOD, CM_ICLKEN);
-			cm_write_mod_reg(fclk, WKUP_MOD, CM_FCLKEN);
-		}
-
-		/* CORE */
-		wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-		if (wkst) {
-			iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
-			fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-			while (wkst) {
-				cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN1);
-				cm_set_mod_reg_bits(wkst, CORE_MOD, CM_FCLKEN1);
-				prm_write_mod_reg(wkst, CORE_MOD, PM_WKST1);
-				wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-			}
-			cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN1);
-			cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
-		}
-		wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
-		if (wkst) {
-			iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
-			fclk = cm_read_mod_reg(CORE_MOD,
-						OMAP3430ES2_CM_FCLKEN3);
-			while (wkst) {
-				cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
-				cm_set_mod_reg_bits(wkst, CORE_MOD,
-							OMAP3430ES2_CM_FCLKEN3);
-				prm_write_mod_reg(wkst, CORE_MOD,
-							OMAP3430ES2_PM_WKST3);
-				wkst = prm_read_mod_reg(CORE_MOD,
-							OMAP3430ES2_PM_WKST3);
-			}
-			cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
-			cm_write_mod_reg(fclk, CORE_MOD,
-						OMAP3430ES2_CM_FCLKEN3);
-		}
-
-		/* PER */
-		wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
-		if (wkst) {
-			iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
-			fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
-			while (wkst) {
-				cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD,
-							CM_ICLKEN);
-				cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD,
-							CM_FCLKEN);
-				prm_write_mod_reg(wkst, OMAP3430_PER_MOD,
-							PM_WKST);
-				wkst = prm_read_mod_reg(OMAP3430_PER_MOD,
-							PM_WKST);
-			}
-			cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
-			cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
-		}
-
-		if (omap_rev() > OMAP3430_REV_ES1_0) {
-			/* USBHOST */
-			wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-							PM_WKST);
-			if (wkst) {
-				iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-					       CM_ICLKEN);
-				fclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-					       CM_FCLKEN);
-				while (wkst) {
-					cm_set_mod_reg_bits(wkst,
-							OMAP3430ES2_USBHOST_MOD,
-							CM_ICLKEN);
-					cm_set_mod_reg_bits(wkst,
-							OMAP3430ES2_USBHOST_MOD,
-							CM_FCLKEN);
-					prm_write_mod_reg(wkst,
-							OMAP3430ES2_USBHOST_MOD,
-							PM_WKST);
-					wkst = prm_read_mod_reg(
-							OMAP3430ES2_USBHOST_MOD,
-							PM_WKST);
-				}
-				cm_write_mod_reg(iclk, OMAP3430ES2_USBHOST_MOD,
-					 CM_ICLKEN);
-				cm_write_mod_reg(fclk, OMAP3430ES2_USBHOST_MOD,
-					 CM_FCLKEN);
-			}
-		}
+		prcm_clear_mod_irqs(WKUP_MOD, PM_WKST, CM_ICLKEN, CM_FCLKEN);
+		prcm_clear_mod_irqs(CORE_MOD, PM_WKST1, CM_ICLKEN1, CM_ICLKEN1);
+		prcm_clear_mod_irqs(CORE_MOD, OMAP3430ES2_PM_WKST3,
+				    CM_ICLKEN3, OMAP3430ES2_CM_FCLKEN3);
+		prcm_clear_mod_irqs(OMAP3430_PER_MOD, PM_WKST,
+				    CM_ICLKEN, CM_FCLKEN);
+		if (omap_rev() > OMAP3430_REV_ES1_0)
+			prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, PM_WKST,
+					    CM_ICLKEN, CM_FCLKEN);
 
 		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
