From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: 3430SDP: Build break in pm-2.6.29 branch
Date: Thu, 13 Aug 2009 07:25:15 -0700
Message-ID: <87skfviyes.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050762@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:50605 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbZHMOZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:25:20 -0400
Received: by pzk34 with SMTP id 34so584275pzk.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 07:25:21 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050762@dbde02.ent.ti.com> (Anand Gadiyar's message of "Thu\, 13 Aug 2009 11\:10\:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

> With the omap_3430sdp_pm_defconfig, I get the following build break
>
>   CC      arch/arm/mach-omap2/pm34xx.o
> arch/arm/mach-omap2/pm34xx.c: In function 'prcm_interrupt_handler':
> arch/arm/mach-omap2/pm34xx.c:286: error: 'OMAP3_PRM_IRQSTATUS_MPU_OFFSET' undeclared (first use in this function)
> arch/arm/mach-omap2/pm34xx.c:286: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/pm34xx.c:286: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-omap2/pm34xx.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

Thanks for the report.  This is a problem with my backport of Jon
Hunter's PRCM IRQ rework.

Just pushed the fix below to pm-2.6.29.

Kevin


commit e63cf0710a4fb639d91d3e8b05aa485fbfa381b3
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Thu Aug 13 07:21:15 2009 -0700

    OMAP3: PM: PRCM IRQ rework: fix backport error.
    
    Reported-by: Anand Gadiyar <gadiyar@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1fee053..a064605 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -283,7 +283,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 
 	do {
 		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+					OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
 			c = _prcm_int_handle_wakeup();
@@ -301,9 +301,9 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		}
 
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+					OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 
-	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
+	} while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));
 
 	return IRQ_HANDLED;
 }
