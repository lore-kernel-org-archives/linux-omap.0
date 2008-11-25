From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: how to force IVA2 powerdomain OFF on boot
Date: Mon, 24 Nov 2008 18:05:59 -0800
Message-ID: <8763mcr248.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:20379 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYKYCGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 21:06:08 -0500
Received: by yx-out-2324.google.com with SMTP id 8so988858yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 18:06:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

For some strange reason, some bootloaders (like u-boot on Beagle) seem
to power up the DSP/IVA2 during boot.  This of course will prevent
full-chip retention until the IVA is put into retention.

On several boards I've tested the PM branch, after kernel boot the
unused domains (like SGX, DSS, CAM, IVA2) are all in RET since the
init code sets next states to retention.  This is working except if
the bootloader has powered up the IVA2.

I'm trying to figure out why the IVA2 isn't going into RET, even when
iva2_fck is disabled during boot as part of the 'reset unused clocks'
feature.

I'm now trying to force the IVA2 into RET/OFF during boot by following
'Figure 14-46: IVA2 Power Down' in the TRM (see patch[1] below), but
that is not working.  IVA2 still stays ON.

Any ideas?

Kevin


[1] This is an attempt to implement Figure 14-46, and then
the 'reset unused clocks' will disable iva2_fck an finish the procedure.

khilman@vence:~/work/kernel/omap/dev$ git diff
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 804b3ac..5ef7cf8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -591,6 +591,24 @@ int __init omap3_pm_init(void)
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
+	{
+		struct powerdomain *iva2_pwrdm;
+		struct clockdomain *iva2_clkdm;
+
+		iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
+		iva2_clkdm = clkdm_lookup("iva2_clkdm");
+
+		if (iva2_pwrdm && iva2_clkdm) {
+			u32 pwrst;
+
+			pwrdm_set_next_pwrst(iva2_pwrdm, PWRDM_POWER_OFF);
+			cm_write_mod_reg(0x1, OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
+			prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
+			omap2_clkdm_sleep(iva2_clkdm);
+		} else 
+			printk(KERN_ERR "KJH: Cannot reset IVA2\n");
+	}
+
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");






