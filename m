From: Jean Pihet <jpihet@mvista.com>
Subject: Beagleboard rev C memory timings & suspend/resume
Date: Wed, 29 Apr 2009 15:53:48 +0200
Message-ID: <200904291553.49378.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:14061 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZD2NyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 09:54:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

The suspend/resume on Beagleboard has some problem due to bad memory timings.
Suspending for more than 5 to 10 seconds shows memory corruption.

The new chips on rev Cx boards are using 2 DDR chip selects and it looks like 
the 2nd memory part is not correctly put into self refresh. As an 
experimentation I tried the same kernel with 'mem=128M' and it resumes 
correctly after 1 min in suspend.

I could not find the latest DDR detailed specs from Micron. The part number is 
MT29C2G48MAKLCJI-6 IT. Are those available? Is this part identical to 2 1Gb 
parts?

Now for the code in the kernel, there are some changes needed to support 2 
CS'es:
- the SDRC parameters need to be updated for the new memory part
- the SDRC parameters need to include the ACTIM_CTRL_A_0, ACTIM_CTRL_A_1, 
ACTIM_CTRL_B_0, ACTIM_CTRL_B_1, RFR_CTRL_0 and RFR_CTRL_1 registers. Since 
the parameters for the 2nd CS are the same, this can be avoided by writing 
the same values to the 2 sets of registers
- is there a need to differentiate between 1Gb and 2Gb chips, or can we just 
write the same params for both CS'es even if only one is being used?
- the 'configure_sdrc' function in arch/arm/mach-omap2/sram34xx.S needs to 
program the 2 sets of registers. Here is a patch excerpt below. This patch 
only does not help the suspend/resume though.

Any idea or suggestion?

Regards,
Jean

---
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 487fa86..6d5843a 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -175,15 +175,24 @@ wait_dll_unlock:
        bne     wait_dll_unlock
        bx      lr
 configure_sdrc:
-       ldr     r11, omap3_sdrc_rfr_ctrl
+       ldr     r11, omap3_sdrc_rfr_ctrl_0
        str     r0, [r11]
-       ldr     r11, omap3_sdrc_actim_ctrla
+       ldr     r11, omap3_sdrc_rfr_ctrl_1
+       str     r0, [r11]
+       ldr     r11, omap3_sdrc_actim_ctrla_0
+       str     r1, [r11]
+       ldr     r11, omap3_sdrc_actim_ctrla_1
        str     r1, [r11]
-       ldr     r11, omap3_sdrc_actim_ctrlb
+       ldr     r11, omap3_sdrc_actim_ctrlb_0
+       str     r2, [r11]
+       ldr     r11, omap3_sdrc_actim_ctrlb_1
        str     r2, [r11]
        ldr     r11, omap3_sdrc_mr_0
        str     r6, [r11]
        ldr     r6, [r11]               @ posted-write barrier for SDRC
+       ldr     r11, omap3_sdrc_mr_1
+       str     r6, [r11]
+       ldr     r6, [r11]               @ posted-write barrier for SDRC
        bx      lr

 omap3_sdrc_power:
@@ -194,14 +203,22 @@ omap3_cm_idlest1_core:
        .word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
 omap3_cm_iclken1_core:
        .word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
-omap3_sdrc_rfr_ctrl:
+omap3_sdrc_rfr_ctrl_0:
        .word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-omap3_sdrc_actim_ctrla:
+omap3_sdrc_rfr_ctrl_1:
+       .word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
+omap3_sdrc_actim_ctrla_0:
        .word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
-omap3_sdrc_actim_ctrlb:
+omap3_sdrc_actim_ctrla_1:
+       .word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
+omap3_sdrc_actim_ctrlb_0:
        .word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_actim_ctrlb_1:
+       .word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
 omap3_sdrc_mr_0:
        .word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
+omap3_sdrc_mr_1:
+       .word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
 omap3_sdrc_dlla_status:
        .word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
