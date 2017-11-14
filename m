From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Tue, 14 Nov 2017 09:37:19 -0800
Message-ID: <20171114173719.GA28152@atomide.com>
References: <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171114063724.GA16969@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171114 06:34]:
> On Fri, Nov 10, 2017 at 07:36:20AM -0800, Tony Lindgren wrote:
> > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171110 06:34]:
> > > On Thu, Nov 09, 2017 at 07:26:10PM -0800, Tony Lindgren wrote:
> > > > +#define OMAP34XX_SRAM_PHYS	0x40200000
> > > > +#define OMAP34XX_SRAM_VIRT	0xd0010000
> > > > +#define OMAP34XX_SRAM_SIZE	0x10000
> > > 
> > > For my testing environment, vmalloc address space is started at
> > > roughly 0xe0000000 so 0xd0010000 would not be valid.
> > 
> > Well we can map it anywhere we want, got any preferences?
> 
> My testing environment is a beagle-(xm?) for QEMU. It is configured by
> CONFIG_VMSPLIT_3G=y so kernel address space is started at 0xc0000000.
> And, it has 512 MB memory so 0xc0000000 ~ 0xdff00000 is used for
> direct mapping. See below.
> 
> [    0.000000] Memory: 429504K/522240K available (11264K kernel code,
> 1562K rwdata, 4288K rodata, 2048K init, 405K bss, 27200K reserved,
> 65536K cma-reserved, 0K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xe0000000 - 0xff800000   ( 504 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xdff00000   ( 511 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0208000 - 0xc0e00000   (12256 kB)
> [    0.000000]       .init : 0xc1300000 - 0xc1500000   (2048 kB)
> [    0.000000]       .data : 0xc1500000 - 0xc1686810   (1563 kB)
> [    0.000000]        .bss : 0xc168fc68 - 0xc16f512c   ( 406 kB)
> 
> Therefore, if OMAP34XX_SRAM_VIRT is 0xd0010000, direct mapping is
> broken and the system doesn't work. I guess that we should use more
> stable address like as 0xf0000000.

OK. Let's forget about adding static mappings and my earlier
patches to attempt to fix this. Below is what I now think we should
merge as a fix before merging Joonsoo's patches. Please all review
and test, adding Tero to Cc also.

Regards,

Tony

8< -----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 13 Nov 2017 13:23:33 -0800
Subject: [PATCH] ARM: OMAP2+: Fix SRAM virt to phys translation for
 save_secure_ram_context

With the CMA changes from Joonsoo Kim <iamjoonsoo.kim@lge.com>, it
was noticed that n900 stopped booting. After investigating it turned
out that n900 save_secure_ram_context does some whacky virtual to
physical address translation for the SRAM data address.

As we now only have minimal parts of omap3 idle code copied to SRAM,
running save_secure_ram_context() in SRAM is not needed. It only gets
called on PM init. And it seems there's no need to ever call this from
SRAM idle code.

So let's just keep save_secure_ram_context() in DDR, and pass it the
physical address of the parameters. We can do everything else in
omap-secure.c like we already do for other secure code.

And since we don't have any documentation, I still have no clue what
the values for 0, 1 and 1 for the parameters might be. If somebody has
figured it out, please do send a patch to add some comments.

Debugged-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-secure.c | 19 +++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |  4 ++++
 arch/arm/mach-omap2/pm.h          |  4 ----
 arch/arm/mach-omap2/pm34xx.c      | 13 ++++---------
 arch/arm/mach-omap2/sleep34xx.S   | 26 ++++----------------------
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -73,6 +73,25 @@ phys_addr_t omap_secure_ram_mempool_base(void)
 	return omap_secure_memblock_base;
 }
 
+u32 omap3_save_secure_ram(void __iomem *addr, int size)
+{
+	u32 ret;
+	u32 param[5];
+
+	if (size != OMAP3_SAVE_SECURE_RAM_SZ)
+		return OMAP3_SAVE_SECURE_RAM_SZ;
+
+	param[0] = 4;		/* Number of arguments */
+	param[1] = __pa(addr);	/* Physical address for saving */
+	param[2] = 0;
+	param[3] = 1;
+	param[4] = 1;
+
+	ret = save_secure_ram_context(__pa(param));
+
+	return ret;
+}
+
 /**
  * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
  * @idx: The PPA API index
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -31,6 +31,8 @@
 /* Maximum Secure memory storage size */
 #define OMAP_SECURE_RAM_STORAGE	(88 * SZ_1K)
 
+#define OMAP3_SAVE_SECURE_RAM_SZ	0x803F
+
 /* Secure low power HAL API index */
 #define OMAP4_HAL_SAVESECURERAM_INDEX	0x1a
 #define OMAP4_HAL_SAVEHW_INDEX		0x1b
@@ -65,6 +67,8 @@ extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
+extern u32 save_secure_ram_context(u32 args_pa);
+extern u32 omap3_save_secure_ram(void __iomem *save_regs, int size);
 
 extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,10 +81,6 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
-/* save_secure_ram_context function pointer and size, for copy to SRAM */
-extern int save_secure_ram_context(u32 *addr);
-extern unsigned int save_secure_ram_context_sz;
-
 extern void omap3_save_scratchpad_contents(void);
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -48,6 +48,7 @@
 #include "prm3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "omap-secure.h"
 #include "sram.h"
 #include "control.h"
 #include "vc.h"
@@ -66,7 +67,6 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static int (*_omap_save_secure_sram)(u32 *addr);
 void (*omap3_do_wfi_sram)(void);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
@@ -121,8 +121,8 @@ static void omap3_save_secure_ram_context(void)
 		 * will hang the system.
 		 */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-		ret = _omap_save_secure_sram((u32 *)(unsigned long)
-				__pa(omap3_secure_ram_storage));
+		ret = omap3_save_secure_ram(omap3_secure_ram_storage,
+					    OMAP3_SAVE_SECURE_RAM_SZ);
 		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
@@ -434,15 +434,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
  *
  * The minimum set of functions is pushed to SRAM for execution:
  * - omap3_do_wfi for erratum i581 WA,
- * - save_secure_ram_context for security extensions.
  */
 void omap_push_sram_idle(void)
 {
 	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
-
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
-		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
-				save_secure_ram_context_sz);
 }
 
 static void __init pm_errata_configure(void)
@@ -553,7 +548,7 @@ int __init omap3_pm_init(void)
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
-			kmalloc(0x803F, GFP_KERNEL);
+			kmalloc(OMAP3_SAVE_SECURE_RAM_SZ, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
 			pr_err("Memory allocation failed when allocating for secure sram context\n");
 
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -93,20 +93,13 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 ENDPROC(enable_omap3630_toggle_l2_on_restore)
 
 /*
- * Function to call rom code to save secure ram context. This gets
- * relocated to SRAM, so it can be all in .data section. Otherwise
- * we need to initialize api_params separately.
+ * Function to call rom code to save secure ram context.
+ *
+ * r0 = physical address of the parameters
  */
-	.data
-	.align	3
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
-	adr	r3, api_params		@ r3 points to parameters
-	str	r0, [r3,#0x4]		@ r0 has sdram address
-	ldr	r12, high_mask
-	and	r3, r3, r12
-	ldr	r12, sram_phy_addr_mask
-	orr	r3, r3, r12
+	mov	r3, r0			@ physical address of parameters
 	mov	r0, #25			@ set service ID for PPA
 	mov	r12, r0			@ copy secure service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
@@ -120,18 +113,7 @@ ENTRY(save_secure_ram_context)
 	nop
 	nop
 	ldmfd	sp!, {r4 - r11, pc}
-	.align
-sram_phy_addr_mask:
-	.word	SRAM_BASE_P
-high_mask:
-	.word	0xffff
-api_params:
-	.word	0x4, 0x0, 0x0, 0x1, 0x1
 ENDPROC(save_secure_ram_context)
-ENTRY(save_secure_ram_context_sz)
-	.word	. - save_secure_ram_context
-
-	.text
 
 /*
  * ======================
-- 
2.15.0
