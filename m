From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/5 v3] OMAP3630: PM: Erratum i608: disable RTA
Date: Wed, 15 Dec 2010 16:13:06 -0600
Message-ID: <4D093D72.8050607@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>	<1291395818-8639-4-git-send-email-nm@ti.com> <87r5dl119k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000807070104060301030506"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55772 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753851Ab0LOWNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 17:13:13 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so1422296yxd.20
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 14:13:09 -0800 (PST)
In-Reply-To: <87r5dl119k.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ambresh K <ambresh@ti.com>, ext Paul Walmsley <paul@pwsan.com>

This is a multi-part message in MIME format.
--------------000807070104060301030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman had written, on 12/13/2010 09:28 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Erratum id: i608
>> RTA (Retention Till Access) feature is not supported and leads to device
>> stability issues when enabled. This impacts modules with embedded memories
>> on OMAP3630
>>
>> Workaround is to disable RTA on boot and coming out of core off.
>> For disabling rta coming out of off mode, we do this by overriding the
>> restore pointer for 3630 to allow us restore handler as the first point of
>> entry before caches are touched and is common for GP and HS devices.
>> to disable earlier than this could be possible by modifying the ppa for HS
>> devices, but not for GP devices.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> [ambresh@ti.com: co-developer]
>> Signed-off-by: Ambresh K <ambresh@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> [...]
> 
>> @@ -1045,6 +1057,15 @@ static int __init omap3_pm_init(void)
>>  	pm_idle = omap3_pm_idle;
>>  	omap3_idle_init();
>>  
>> +	/*
>> +	 * RTA is disabled during initialization as per erratum i608
>> +	 * it is safer to disable rta by the bootloader, but we would like
>> +	 * to be doubly sure here and prevent any mishaps.
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(RTA_ERRATUM_i608))
>> +		omap_ctrl_writel(OMAP36XX_RTA_DISABLE,
>> +			OMAP36XX_CONTROL_MEM_RTA_CTRL);
>> +
> 
> Minor nit: we've been trying to clean up control module access.  So,
> rather than directly writing control module registers, could you create
> an API for this like was done for omap3_ctrl_write_boot_mode().
looks like the cleanups are somewhere in -next and not in k.org tree. 
basing the change similar to 
http://marc.info/?l=linux-omap&m=129168623011464&w=2 does the 
attached(based on 2.6.37-rc5) looks like how you'd like to see it? If i 
need to rebase to any particular tree which already has this change 
instead of k.org, do let me know.

-- 
Regards,
Nishanth Menon

--------------000807070104060301030506
Content-Type: text/x-patch;
 name="0001-OMAP3630-PM-Erratum-i608-disable-RTA.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-OMAP3630-PM-Erratum-i608-disable-RTA.patch"

>From 5cf295fa3fe8d423323500fb8ddb49650f797edd Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Mon, 6 Sep 2010 10:26:08 +0530
Subject: [PATCH] OMAP3630: PM: Erratum i608: disable RTA

Erratum id: i608
RTA (Retention Till Access) feature is not supported and leads to device
stability issues when enabled. This impacts modules with embedded memories
on OMAP3630

Workaround is to disable RTA on boot and coming out of core off.
For disabling rta coming out of off mode, we do this by overriding the
restore pointer for 3630 to allow us restore handler as the first point of
entry before caches are touched and is common for GP and HS devices.
to disable earlier than this could be possible by modifying the ppa for HS
devices, but not for GP devices.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/control.c   |   13 ++++++++++++-
 arch/arm/mach-omap2/control.h   |    7 ++++++-
 arch/arm/mach-omap2/pm34xx.c    |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..7c415bc 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (omap_rev() != OMAP3430_REV_ES3_0 &&
+	if (cpu_is_omap3630())
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_omap3630_restore_pointer());
+	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
 					omap_rev() != OMAP3430_REV_ES3_1)
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_restore_pointer());
@@ -474,4 +477,12 @@ void omap3_control_restore_context(void)
 	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
 	return;
 }
+
+void omap3630_disable_rta(void)
+{
+	if (!cpu_is_omap36xx())
+		return;
+	omap_ctrl_writel(OMAP36XX_RTA_DISABLE, OMAP36XX_CONTROL_MEM_RTA_CTRL);
+}
+
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..13771cc 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -204,6 +204,10 @@
 #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
 #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
+/* 36xx-only RTA - Retention till Accesss control registers and bits */
+#define OMAP36XX_CONTROL_MEM_RTA_CTRL	0x40C
+#define OMAP36XX_RTA_DISABLE		0x0
+
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
@@ -347,10 +351,11 @@ extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
 extern u32 *get_es3_restore_pointer(void);
+extern u32 *get_omap3630_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
-
+extern void omap3630_disable_rta(void);
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0ec8a04..859c452 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -55,6 +55,10 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
+#define RTA_ERRATUM_i608		(1 << 0)
+static u16 pm34xx_errata;
+#define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -989,6 +993,12 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void __init pm_errata_configure(void)
+{
+	if (cpu_is_omap3630())
+		pm34xx_errata |= RTA_ERRATUM_i608;
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -998,6 +1008,8 @@ static int __init omap3_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	pm_errata_configure();
+
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
@@ -1045,6 +1057,14 @@ static int __init omap3_pm_init(void)
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
+	/*
+	 * RTA is disabled during initialization as per erratum i608
+	 * it is safer to disable rta by the bootloader, but we would like
+	 * to be doubly sure here and prevent any mishaps.
+	 */
+	if (IS_PM34XX_ERRATUM(RTA_ERRATUM_i608))
+		omap3630_disable_rta();
+
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 3fbd1e5..cc3507b 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -45,6 +45,8 @@
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
 #define SRAM_BASE_P		0x40200000
 #define CONTROL_STAT		0x480022F0
+#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
+					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
@@ -99,6 +101,14 @@ ENTRY(get_restore_pointer)
         ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
         .word   . - get_restore_pointer
+	.text
+/* Function call to get the restore pointer for 3630 resume from OFF */
+ENTRY(get_omap3630_restore_pointer)
+        stmfd   sp!, {lr}     @ save registers on stack
+	adr	r0, restore_3630
+        ldmfd   sp!, {pc}     @ restore regs and return
+ENTRY(get_omap3630_restore_pointer_sz)
+        .word   . - get_omap3630_restore_pointer
 
 	.text
 /* Function call to get the restore pointer for for ES3 to resume from OFF */
@@ -246,6 +256,20 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
+	b	restore
+
+restore_3630:
+	/*b restore_es3630*/		@ Enable to debug restore code
+	ldr	r1, pm_prepwstst_core_p
+	ldr	r2, [r1]
+	and	r2, r2, #0x3
+	cmp	r2, #0x0	@ Check if previous power state of CORE is OFF
+	bne	restore
+	/* Disable rta before giving control */
+	ldr	r1, control_mem_rta
+	mov	r2, #OMAP36XX_RTA_DISABLE
+	str	r2, [r1]
+	/* Fall thru for the remaining logic */
 restore:
 	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
@@ -650,6 +674,8 @@ cache_pred_disable_mask:
 	.word	0xFFFFE7FB
 control_stat:
 	.word	CONTROL_STAT
+control_mem_rta:
+	.word	CONTROL_MEM_RTA_CTRL
 kernel_flush:
 	.word v7_flush_dcache_all
 	/* these 2 words need to be at the end !!! */
-- 
1.6.3.3


--------------000807070104060301030506--
