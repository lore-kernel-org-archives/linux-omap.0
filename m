From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power domain addition.
Date: Wed, 21 Jun 2006 14:04:00 -0700
Message-ID: <20060621210359.GN4257@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A5064652ED@dlee02.ent.ti.com>
	<20060621151357.21663.qmail@web37913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060621151357.21663.qmail@web37913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Komal Shah <komal_shah802003@yahoo.com> [060621 08:14]:
> --- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:
> 
> > Yes, see below for the reasons.  I guess the basic point is it still
> > won't boot with out an Irda fix up.  I only highlighted the problem
> > and
> > supplied a rough hack.  Whoever looks after Irda should get it fixed,
> > or
> > have it removed from the default configuration. 
> > It is possible its
> > just
> > a compiler bug which then make it a little less clear.  The bug is
> > from
> > a union structure of a u8 and u16 generating only byte aligned code
> > which is a no-no when used with a lrdh.
> 
> I can submit the patch for removing IrDA from the defconfig, but before
> that I will build the latest omap git tree, with code-sourcery 2005Q1B
> release and will see that it stops at the same point or not.
> 
> > 
> > This is because you can't just change MT_DEVICE to MT_MEMORY with out
> > changing the mapping size.  Templates are not given for PTE
> > generation
> > only section entries.  That is why I changed the size to 1024*1024.
> > As
> > indicated I tried a quick extension to make my own type but found it
> > must also change the code which sets the EXEC bit and didn't want to
> > do
> > that, so just increased the to something which would generate what I
> > want.
> 
> I had just compiled and boot the latest pull from omap git tree, and
> _not_ changed anything, so mapping size was 1024*1024 as per that
> commited patch. But I think you had tested that setup with power
> management enabled, which works in my case except IrDA.

Here's some stuff that was missing from my earlier patch. Still no
wake-up though. Oh well, have to look at it a bit later.

Regards,

Tony

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap24xx-suspend-hacks

--- a/arch/arm/mach-omap2/sleep.S
+++ b/arch/arm/mach-omap2/sleep.S
@@ -30,6 +30,13 @@ #include <asm/arch/pm.h>
 #define A_32KSYNC_CR_V		IO_ADDRESS(OMAP_TIMER32K_BASE+0x10)
 #define A_PRCM_VOLTCTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x50)
 #define A_PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x80)
+#define A_PM_PWSTCTR_MPU_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x1e4)
+#define A_CM_FCLKEN1_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x200)
+#define A_CM_FCLKEN2_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x204)
+#define A_CM_ICLKEN1_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x210)
+#define A_CM_ICLKEN2_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x214)
+#define A_CM_ICLKEN3_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x218)
+#define A_CM_ICLKEN4_CORE_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x21c)
 #define A_CM_CLKEN_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x500)
 #define A_CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x520)
 #define A_CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x540)
@@ -91,6 +98,12 @@ ENTRY(omap24xx_idle_loop_suspend_sz)
 ENTRY(omap24xx_cpu_suspend)
 	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
 	mov	r3, #0x0		@ clear for mrc call
+
+	ldr	r8, A_CM_FCLKEN2_CORE	@ addr of register to save
+	ldr	r9, [r8]		@ load value
+	str	r9, SAVE_REG1		@ save value
+	str	r3, [r8]		@ reset register
+
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
 	nop
 	nop
@@ -123,9 +136,18 @@ loop:
 loop2:
 	subs	r5, r5, #0x1
 	bne	loop2
+
+	ldr	r8, A_CM_FCLKEN2_CORE	@ addr of fck
+	ldr	r9, SAVE_REG1		@ load saved value
+	str	r9, [r8]		@ restore saved value
+
 	/* resume*/
 	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
 
+SAVE_REG1:
+	.word 0x0
+A_CM_FCLKEN2_CORE:
+	.word A_CM_FCLKEN2_CORE_V
 A_SDRC_POWER:
 	.word A_SDRC_POWER_V
 A_SDRC0:
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1060,6 +1060,7 @@ #ifdef CONFIG_ARCH_OMAP24XX
 		if (bank->method == METHOD_GPIO_24XX) {
 			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
 			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
+			__raw_writel(0x00000014, bank->base + OMAP24XX_GPIO_SYSCONFIG);
 
 			gpio_count = 32;
 		}

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--YiEDa0DAkWCtVeE4--
