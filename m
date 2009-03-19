From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Thu, 19 Mar 2009 00:08:33 +0000
Message-ID: <20090319000833.GE30132@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com> <20090316171008.GF31868@n2100.arm.linux.org.uk> <49BE8F08.3000100@solidboot.com> <20090316222146.GA8150@n2100.arm.linux.org.uk> <20090318182805.GA29546@atomide.com> <20090318192626.GC30132@n2100.arm.linux.org.uk> <20090318201003.GB29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54941 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZCSAIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 20:08:54 -0400
Content-Disposition: inline
In-Reply-To: <20090318201003.GB29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Wed, Mar 18, 2009 at 01:10:04PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090318 12:26]:
> > On Wed, Mar 18, 2009 at 11:28:06AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090316 15:22]:
> > > > On Mon, Mar 16, 2009 at 07:40:24PM +0200, Juha Yrjola wrote:
> > > > > Russell King - ARM Linux wrote:
> > > > >
> > > > >> Right.  You are aware that there is already a mechanism for doing this
> > > > >> in the generic kernel (obviously not)?
> > > > >
> > > > > I am. Unfortunately, glibc fails to support this mechanism, as you say.  
> > > > > I didn't want to start making such intrusive changes for our trivial 
> > > > > need.
> > > > 
> > > > Yes, glibc sucks with that - they hide the Linux reboot syscall.
> > > > Luckily, it is accessible via the syscall() interface:
> > > > 
> > > > #include <linux/reboot.h>
> > > > 
> > > > int sys_reboot(const char *cmd)
> > > > {
> > > > 	return syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2C,
> > > > 			LINUX_REBOOT_CMD_RESTART2, cmd);
> > > > }
> > > > 
> > > > >> sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
> > > > >> to the standard parameters.  This string is passed into machine_restart()
> > > > >> which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
> > > > >> string is NULL.
> > > > >>
> > > > >> We could change machine_restart() to pass this parameter through to
> > > > >> arm_pm_restart() and ultimately down to arch_reset().
> > > > >
> > > > > Sure. With RESTART2, I could've even used the reboot notifier chain with  
> > > > > an OMAP3-specific driver to store the string.
> > > > 
> > > > The notifier chain is called in any case.
> > > > 
> > > > > Are you suggesting to get rid of reboot_mode altogether? If not, could  
> > > > > we still have the sysfs mechanism? A one-character reboot_mode would be  
> > > > > plenty enough for us.
> > > > 
> > > > No, reboot mode tells _how_ to perform the reboot - whether that be
> > > > by hardware reset, gpio reset or a soft call via the reset address.
> > > > It's not supposed to tell the boot loader what to do.
> > > 
> > > So if the reboot mode can't be used for this.. Should we change Juha's
> > > sysfs interface patch to store something else like bootloader_mode?
> > > 
> > > I guess we cannot use kexec for this either?
> > 
> > Why not use the mechanism that's already there as I've already pointed
> > out?
> 
> Sorry I misunderstood, I thought you did not want to use reboot_mode
> for this at all..

I don't want to use reboot_mode for this.  machine_restart() and the
reboot syscall has a way of passing a string to the platform specific
code, and I'm suggesting that if you want the boot loader to do some
magic, that's the way to do it.  Use the 'cmd' argument provided to
arch_reset() by the patch below - this will either be NULL if the
standard reboot call is used, or a string if the alternative version
is used.

> To recap, so we change machine_restart() like you described above, and then
> this patch is still valid, except to update the description.

No, you've still got the wrong end of the stick.

 arch/arm/include/asm/system.h                     |    4 ++--
 arch/arm/kernel/process.c                         |   10 +++++-----
 arch/arm/mach-aaec2000/include/mach/system.h      |    2 +-
 arch/arm/mach-at91/include/mach/system.h          |    2 +-
 arch/arm/mach-clps711x/include/mach/system.h      |    2 +-
 arch/arm/mach-davinci/include/mach/system.h       |    2 +-
 arch/arm/mach-ebsa110/include/mach/system.h       |    2 +-
 arch/arm/mach-ep93xx/include/mach/system.h        |    2 +-
 arch/arm/mach-footbridge/include/mach/system.h    |    2 +-
 arch/arm/mach-h720x/include/mach/system.h         |    2 +-
 arch/arm/mach-imx/include/mach/system.h           |    2 +-
 arch/arm/mach-integrator/include/mach/system.h    |    2 +-
 arch/arm/mach-iop13xx/include/mach/system.h       |    2 +-
 arch/arm/mach-iop32x/include/mach/system.h        |    2 +-
 arch/arm/mach-iop33x/include/mach/system.h        |    2 +-
 arch/arm/mach-ixp2000/include/mach/system.h       |    2 +-
 arch/arm/mach-ixp23xx/include/mach/system.h       |    2 +-
 arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-
 arch/arm/mach-kirkwood/include/mach/system.h      |    2 +-
 arch/arm/mach-ks8695/include/mach/system.h        |    2 +-
 arch/arm/mach-l7200/include/mach/system.h         |    2 +-
 arch/arm/mach-lh7a40x/include/mach/system.h       |    2 +-
 arch/arm/mach-loki/include/mach/system.h          |    2 +-
 arch/arm/mach-msm/include/mach/system.h           |    2 +-
 arch/arm/mach-mv78xx0/include/mach/system.h       |    2 +-
 arch/arm/mach-mx2/system.c                        |    2 +-
 arch/arm/mach-netx/include/mach/system.h          |    2 +-
 arch/arm/mach-ns9xxx/include/mach/system.h        |    2 +-
 arch/arm/mach-orion5x/include/mach/system.h       |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c              |    2 +-
 arch/arm/mach-pnx4008/include/mach/system.h       |    2 +-
 arch/arm/mach-pxa/corgi.c                         |    6 +++---
 arch/arm/mach-pxa/include/mach/system.h           |    2 +-
 arch/arm/mach-pxa/mioa701.c                       |    6 +++---
 arch/arm/mach-pxa/poodle.c                        |    6 +++---
 arch/arm/mach-pxa/reset.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                         |    4 ++--
 arch/arm/mach-pxa/tosa.c                          |    4 ++--
 arch/arm/mach-realview/include/mach/system.h      |    2 +-
 arch/arm/mach-rpc/include/mach/system.h           |    2 +-
 arch/arm/mach-s3c2410/include/mach/system-reset.h |    2 +-
 arch/arm/mach-s3c6400/include/mach/system.h       |    2 +-
 arch/arm/mach-sa1100/include/mach/system.h        |    2 +-
 arch/arm/mach-shark/core.c                        |    2 +-
 arch/arm/mach-shark/include/mach/system.h         |    2 +-
 arch/arm/mach-versatile/include/mach/system.h     |    2 +-
 arch/arm/mach-w90x900/include/mach/system.h       |    2 +-
 arch/arm/plat-mxc/include/mach/system.h           |    2 +-
 arch/arm/plat-omap/include/mach/system.h          |    2 +-
 arch/arm/plat-s3c24xx/cpu.c                       |    6 +++---
 50 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 811be55..0a0d49a 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -97,8 +97,8 @@ extern void __show_regs(struct pt_regs *);
 extern int cpu_architecture(void);
 extern void cpu_init(void);
 
-void arm_machine_restart(char mode);
-extern void (*arm_pm_restart)(char str);
+void arm_machine_restart(char mode, const char *cmd);
+extern void (*arm_pm_restart)(char str, const char *cmd);
 
 #define UDBG_UNDEFINED	(1 << 0)
 #define UDBG_SYSCALL	(1 << 1)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index af377c7..2de14e2 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -83,7 +83,7 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void arm_machine_restart(char mode)
+void arm_machine_restart(char mode, const char *cmd)
 {
 	/*
 	 * Clean and disable cache, and turn off interrupts
@@ -100,7 +100,7 @@ void arm_machine_restart(char mode)
 	/*
 	 * Now call the architecture specific reboot code.
 	 */
-	arch_reset(mode);
+	arch_reset(mode, cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-void (*arm_pm_restart)(char str) = arm_machine_restart;
+void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 
@@ -195,9 +195,9 @@ void machine_power_off(void)
 		pm_power_off();
 }
 
-void machine_restart(char * __unused)
+void machine_restart(char *cmd)
 {
-	arm_pm_restart(reboot_mode);
+	arm_pm_restart(reboot_mode, cmd);
 }
 
 void __show_regs(struct pt_regs *regs)
diff --git a/arch/arm/mach-aaec2000/include/mach/system.h b/arch/arm/mach-aaec2000/include/mach/system.h
index 8f4115d..fe08ca1 100644
--- a/arch/arm/mach-aaec2000/include/mach/system.h
+++ b/arch/arm/mach-aaec2000/include/mach/system.h
@@ -16,7 +16,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index e712658..5268af3 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -43,7 +43,7 @@ static inline void arch_idle(void)
 
 void (*at91_arch_reset)(void);
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/* call the CPU-specific reset function */
 	if (at91_arch_reset)
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index 24e9615..f916cd7 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -32,7 +32,7 @@ static inline void arch_idle(void)
 	mov	r0, r0");
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index 17ca41d..b7e7036 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -21,7 +21,7 @@ static void arch_idle(void)
 	cpu_do_idle();
 }
 
-static void arch_reset(char mode)
+static void arch_reset(char mode, const char *cmd)
 {
 	davinci_watchdog_reset();
 }
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
index 350a028..9a26245 100644
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ b/arch/arm/mach-ebsa110/include/mach/system.h
@@ -34,6 +34,6 @@ static inline void arch_idle(void)
 	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
 }
 
-#define arch_reset(mode)	cpu_reset(0x80000000)
+#define arch_reset(mode, cmd)	cpu_reset(0x80000000)
 
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index 67789d0..ed8f35e 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -9,7 +9,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	u32 devicecfg;
 
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
index 2db7f36..0b29315 100644
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ b/arch/arm/mach-footbridge/include/mach/system.h
@@ -18,7 +18,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	if (mode == 's') {
 		/*
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index e4a7c76..a708d24 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -25,7 +25,7 @@ static void arch_idle(void)
 }
 
 
-static __inline__ void arch_reset(char mode)
+static __inline__ void arch_reset(char mode, const char *cmd)
 {
 	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
 }
diff --git a/arch/arm/mach-imx/include/mach/system.h b/arch/arm/mach-imx/include/mach/system.h
index adee7e5..46d4ca9 100644
--- a/arch/arm/mach-imx/include/mach/system.h
+++ b/arch/arm/mach-imx/include/mach/system.h
@@ -32,7 +32,7 @@ arch_idle(void)
 }
 
 static inline void
-arch_reset(char mode)
+arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
index c485345..e1551b8 100644
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ b/arch/arm/mach-integrator/include/mach/system.h
@@ -32,7 +32,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * To reset, we hit the on-board reset register
diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
index c7127f4..d0c66ef 100644
--- a/arch/arm/mach-iop13xx/include/mach/system.h
+++ b/arch/arm/mach-iop13xx/include/mach/system.h
@@ -13,7 +13,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Reset the internal bus (warning both cores are reset)
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
index 32d9e5b..a4b808f 100644
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ b/arch/arm/mach-iop32x/include/mach/system.h
@@ -16,7 +16,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
index 0cb3ad8..f192a34 100644
--- a/arch/arm/mach-iop33x/include/mach/system.h
+++ b/arch/arm/mach-iop33x/include/mach/system.h
@@ -14,7 +14,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	*IOP3XX_PCSR = 0x30;
 
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index 2e9c68f..de37099 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -17,7 +17,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index d57c3fc..8920ff2 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -19,7 +19,7 @@ static inline void arch_idle(void)
 #endif
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/* First try machine specific support */
 	if (machine_is_ixdp2351()) {
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index 92a7e8d..d2aa26f 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -20,7 +20,7 @@ static inline void arch_idle(void)
 }
 
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	if ( 1 && mode == 's') {
 		/* Jump into ROM at address 0 */
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
index 8510f6c..23a1914 100644
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ b/arch/arm/mach-kirkwood/include/mach/system.h
@@ -17,7 +17,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Enable soft reset to assert RSTOUTn.
diff --git a/arch/arm/mach-ks8695/include/mach/system.h b/arch/arm/mach-ks8695/include/mach/system.h
index 5a9b032..fb1dda9 100644
--- a/arch/arm/mach-ks8695/include/mach/system.h
+++ b/arch/arm/mach-ks8695/include/mach/system.h
@@ -27,7 +27,7 @@ static void arch_idle(void)
 
 }
 
-static void arch_reset(char mode)
+static void arch_reset(char mode, const char *cmd)
 {
 	unsigned int reg;
 
diff --git a/arch/arm/mach-l7200/include/mach/system.h b/arch/arm/mach-l7200/include/mach/system.h
index 5272abe..e0dd3b6 100644
--- a/arch/arm/mach-l7200/include/mach/system.h
+++ b/arch/arm/mach-l7200/include/mach/system.h
@@ -19,7 +19,7 @@ static inline void arch_idle(void)
 	*(unsigned long *)(IO_BASE + 0x50004) = 1;	/* idle mode */
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	if (mode == 's') {
 		cpu_reset(0);
diff --git a/arch/arm/mach-lh7a40x/include/mach/system.h b/arch/arm/mach-lh7a40x/include/mach/system.h
index fa46bb1..45a56d3 100644
--- a/arch/arm/mach-lh7a40x/include/mach/system.h
+++ b/arch/arm/mach-lh7a40x/include/mach/system.h
@@ -13,7 +13,7 @@ static inline void arch_idle(void)
 	cpu_do_idle ();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset (0);
 }
diff --git a/arch/arm/mach-loki/include/mach/system.h b/arch/arm/mach-loki/include/mach/system.h
index 8db1147..c1de36f 100644
--- a/arch/arm/mach-loki/include/mach/system.h
+++ b/arch/arm/mach-loki/include/mach/system.h
@@ -17,7 +17,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Enable soft reset to assert RSTOUTn.
diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index f05ad2e..574ccc4 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -17,7 +17,7 @@
 
 void arch_idle(void);
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	for (;;) ;  /* depends on IPC w/ other core */
 }
diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
index 7d51794..1d6350b 100644
--- a/arch/arm/mach-mv78xx0/include/mach/system.h
+++ b/arch/arm/mach-mv78xx0/include/mach/system.h
@@ -17,7 +17,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Enable soft reset to assert RSTOUTn.
diff --git a/arch/arm/mach-mx2/system.c b/arch/arm/mach-mx2/system.c
index 7b82697..92c79d4 100644
--- a/arch/arm/mach-mx2/system.c
+++ b/arch/arm/mach-mx2/system.c
@@ -46,7 +46,7 @@ void arch_idle(void)
 /*
  * Reset the system. It is called by machine_restart().
  */
-void arch_reset(char mode)
+void arch_reset(char mode, const char *cmd)
 {
 	struct clk *clk;
 
diff --git a/arch/arm/mach-netx/include/mach/system.h b/arch/arm/mach-netx/include/mach/system.h
index 6c1023b..dc7b4bc 100644
--- a/arch/arm/mach-netx/include/mach/system.h
+++ b/arch/arm/mach-netx/include/mach/system.h
@@ -28,7 +28,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	writel(NETX_SYSTEM_RES_CR_FIRMW_RES_EN | NETX_SYSTEM_RES_CR_FIRMW_RES,
 	       NETX_SYSTEM_RES_CR);
diff --git a/arch/arm/mach-ns9xxx/include/mach/system.h b/arch/arm/mach-ns9xxx/include/mach/system.h
index e2068c5..1561588 100644
--- a/arch/arm/mach-ns9xxx/include/mach/system.h
+++ b/arch/arm/mach-ns9xxx/include/mach/system.h
@@ -20,7 +20,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 #ifdef CONFIG_PROCESSOR_NS9360
 	if (processor_is_ns9360())
diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
index 08e4307..9b8db1d 100644
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ b/arch/arm/mach-orion5x/include/mach/system.h
@@ -19,7 +19,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Enable and issue soft reset
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index e0c43b8..c9bf6b8 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -186,7 +186,7 @@ static struct mv_sata_platform_data lsmini_sata_data = {
 
 static void lsmini_power_off(void)
 {
-	arch_reset(0);
+	arch_reset(0, NULL);
 }
 
 
diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
index e12e7ab..5dda2bb 100644
--- a/arch/arm/mach-pnx4008/include/mach/system.h
+++ b/arch/arm/mach-pnx4008/include/mach/system.h
@@ -30,7 +30,7 @@ static void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3b89e50..cdf21dd 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -635,16 +635,16 @@ static void corgi_poweroff(void)
 		/* Green LED off tells the bootloader to halt */
 		gpio_set_value(CORGI_GPIO_LED_GREEN, 0);
 
-	arm_machine_restart('h');
+	arm_machine_restart('h', NULL);
 }
 
-static void corgi_restart(char mode)
+static void corgi_restart(char mode, const char *cmd)
 {
 	if (!machine_is_corgi())
 		/* Green LED on tells the bootloader to reboot */
 		gpio_set_value(CORGI_GPIO_LED_GREEN, 1);
 
-	arm_machine_restart('h');
+	arm_machine_restart('h', cmd);
 }
 
 static void __init corgi_init(void)
diff --git a/arch/arm/mach-pxa/include/mach/system.h b/arch/arm/mach-pxa/include/mach/system.h
index 0a587c4..d1fce8b 100644
--- a/arch/arm/mach-pxa/include/mach/system.h
+++ b/arch/arm/mach-pxa/include/mach/system.h
@@ -20,4 +20,4 @@ static inline void arch_idle(void)
 }
 
 
-void arch_reset(char mode);
+void arch_reset(char mode, const char *cmd);
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 0257727..97c93a7 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -788,13 +788,13 @@ static void mioa701_machine_exit(void);
 static void mioa701_poweroff(void)
 {
 	mioa701_machine_exit();
-	arm_machine_restart('s');
+	arm_machine_restart('s', NULL);
 }
 
-static void mioa701_restart(char c)
+static void mioa701_restart(char c, const char *cmd)
 {
 	mioa701_machine_exit();
-	arm_machine_restart('s');
+	arm_machine_restart('s', cmd);
 }
 
 struct gpio_ress global_gpios[] = {
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 572ddec..036bbde 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -501,12 +501,12 @@ static struct platform_device *devices[] __initdata = {
 
 static void poodle_poweroff(void)
 {
-	arm_machine_restart('h');
+	arm_machine_restart('h', NULL);
 }
 
-static void poodle_restart(char mode)
+static void poodle_restart(char mode, const char *cmd)
 {
-	arm_machine_restart('h');
+	arm_machine_restart('h', cmd);
 }
 
 static void __init poodle_init(void)
diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index 867c95c..df29d45 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -81,7 +81,7 @@ static void do_hw_reset(void)
 	OSMR3 = OSCR + 368640;	/* ... in 100 ms */
 }
 
-void arch_reset(char mode)
+void arch_reset(char mode, const char *cmd)
 {
 	clear_reset_status(RESET_STATUS_ALL);
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f697c49..7a0a430 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -701,10 +701,10 @@ static struct platform_device *devices[] __initdata = {
 
 static void spitz_poweroff(void)
 {
-	arm_machine_restart('g');
+	arm_machine_restart('g', NULL);
 }
 
-static void spitz_restart(char mode)
+static void spitz_restart(char mode, const char *cmd)
 {
 	/* Bootloader magic for a reboot */
 	if((MSC0 & 0xffff0000) == 0x7ff00000)
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 66b1380..4f6f502 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -876,10 +876,10 @@ static struct platform_device *devices[] __initdata = {
 
 static void tosa_poweroff(void)
 {
-	arm_machine_restart('g');
+	arm_machine_restart('g', NULL);
 }
 
-static void tosa_restart(char mode)
+static void tosa_restart(char mode, const char *cmd)
 {
 	/* Bootloader magic for a reboot */
 	if((MSC0 & 0xffff0000) == 0x7ff00000)
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
index a2f61c7..1a15a44 100644
--- a/arch/arm/mach-realview/include/mach/system.h
+++ b/arch/arm/mach-realview/include/mach/system.h
@@ -34,7 +34,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_RESETCTL_OFFSET;
 	unsigned int val;
diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
index bd7268b..45c7b93 100644
--- a/arch/arm/mach-rpc/include/mach/system.h
+++ b/arch/arm/mach-rpc/include/mach/system.h
@@ -16,7 +16,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	iomd_writeb(0, IOMD_ROMCR0);
 
diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-s3c2410/include/mach/system-reset.h
index 7613d0a..b8687f7 100644
--- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
+++ b/arch/arm/mach-s3c2410/include/mach/system-reset.h
@@ -22,7 +22,7 @@
 extern void (*s3c24xx_reset_hook)(void);
 
 static void
-arch_reset(char mode)
+arch_reset(char mode, const char *cmd)
 {
 	struct clk *wdtclk;
 
diff --git a/arch/arm/mach-s3c6400/include/mach/system.h b/arch/arm/mach-s3c6400/include/mach/system.h
index 652bbc4..090cfd9 100644
--- a/arch/arm/mach-s3c6400/include/mach/system.h
+++ b/arch/arm/mach-s3c6400/include/mach/system.h
@@ -16,7 +16,7 @@ static void arch_idle(void)
 	/* nothing here yet */
 }
 
-static void arch_reset(char mode)
+static void arch_reset(char mode, const char *cmd)
 {
 	/* nothing here yet */
 }
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
index 63755ca..942b153 100644
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ b/arch/arm/mach-sa1100/include/mach/system.h
@@ -10,7 +10,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	if (mode == 's') {
 		/* Jump into ROM at address 0 */
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 4f3a265..358d875 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -26,7 +26,7 @@
 #define ROMCARD_SIZE            0x08000000
 #define ROMCARD_START           0x10000000
 
-void arch_reset(char mode)
+void arch_reset(char mode, const char *cmd)
 {
         short temp;
         local_irq_disable();
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 0752ca2..21c373b 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -7,7 +7,7 @@
 #define __ASM_ARCH_SYSTEM_H
 
 /* Found in arch/mach-shark/core.c */
-extern void arch_reset(char mode);
+extern void arch_reset(char mode, const char *cmd);
 
 static inline void arch_idle(void)
 {
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
index c59e610..8ffc12a 100644
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ b/arch/arm/mach-versatile/include/mach/system.h
@@ -34,7 +34,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	u32 val;
 
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
index 93753f9..9406400 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -21,7 +21,7 @@ static void arch_idle(void)
 {
 }
 
-static void arch_reset(char mode)
+static void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index bbfc374..cd03eba 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -26,7 +26,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	cpu_reset(0);
 }
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 06923f2..145e402 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -38,7 +38,7 @@ static inline void omap1_arch_reset(char mode)
 		omap_writew(1, ARM_RSTCT1);
 }
 
-static inline void arch_reset(char mode)
+static inline void arch_reset(char mode, const char *cmd)
 {
 	if (!cpu_class_is_omap2())
 		omap1_arch_reset(mode);
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 542062f..1932b7e 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -182,7 +182,7 @@ static unsigned long s3c24xx_read_idcode_v4(void)
  * with the caches enabled. It seems at least the S3C2440 has a problem
  * resetting if there is bus activity interrupted by the reset.
  */
-static void s3c24xx_pm_restart(char mode)
+static void s3c24xx_pm_restart(char mode, const char *cmd)
 {
 	if (mode != 's') {
 		unsigned long flags;
@@ -191,12 +191,12 @@ static void s3c24xx_pm_restart(char mode)
 		__cpuc_flush_kern_all();
 		__cpuc_flush_user_all();
 
-		arch_reset(mode);
+		arch_reset(mode, cmd);
 		local_irq_restore(flags);
 	}
 
 	/* fallback, or unhandled */
-	arm_machine_restart(mode);
+	arm_machine_restart(mode, cmd);
 }
 
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
