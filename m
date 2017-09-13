From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Wed, 13 Sep 2017 09:31:27 -0700
Message-ID: <20170913163126.GS5024@atomide.com>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913075516.GA25036@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [170913 00:54]:
> On Thu, Sep 07, 2017 at 09:16:51AM -0700, Tony Lindgren wrote:
> > I doubt that QEMU n900 boots in secure mode but instead shows
> > the SoC as general purpose SoC. If so, you'd have to patch the
> > omap3_save_secure_ram_context() to attempt to save secure RAM
> > context in all cases. If that works then debugging with any
> > omap3 board like beagleboard in QEMU should work.
> 
> Sorry for late response.
> 
> I tried to emulate beagle board by using QEMU and now I find the way
> and it works. However, it doesn't call omap3_save_secure_ram_context()
> due to different omap_type(). And, even if I call it forcibly, the
> system dies with prefetch abort regardless of commit 9caf25f996e8.

OK

> Could you let me know the better way to test your situation?

Hmm yeah it seems to always return 0x19 on GP devices at least
with the following test hack. But maybe that's enough for you
to still see some differences with your patches.

> Anyway, could you test linux-next with 'CONFIG_HIGHMEM = n'?
> I'd like to know if the issue is related to the change that
> all CMA memory is managed like as highmem.

Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
you need to remove it from arch/arm/mach-omap2/Kconfig that
selects it if ARCH_OMAP2PLUS_TYPICAL is selected.

Regards,

Tony

8< ------
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -114,7 +114,7 @@ static void omap3_save_secure_ram_context(void)
 	u32 ret;
 	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+	if (1 || omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		/*
 		 * MPU next state must be set to POWER_ON temporarily,
 		 * otherwise the WFI executed inside the ROM code
@@ -440,7 +440,7 @@ void omap_push_sram_idle(void)
 {
 	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
 
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+	if (1 || omap_type() != OMAP2_DEVICE_TYPE_GP)
 		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
 				save_secure_ram_context_sz);
 }
@@ -551,7 +551,7 @@ int __init omap3_pm_init(void)
 		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+	if (1 || omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -114,7 +114,7 @@ ENTRY(save_secure_ram_context)
 	mov	r6, #0xff
 	dsb				@ data write barrier
 	dmb				@ data memory barrier
-	smc	#1			@ call SMI monitor (smi #1)
+	@smc	#1			@ call SMI monitor (smi #1)
 	nop
 	nop
 	nop
-- 
2.14.1
