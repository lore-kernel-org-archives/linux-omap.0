From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Tue, 19 Aug 2008 13:08:29 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808191018550.16256@utopia.booyaka.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>    <002f01c8f7c5$0790fea0$LocalHost@wipultra1382> <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58559 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437AbYHSTIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 15:08:30 -0400
In-Reply-To: <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, sakari.poussa@nokia.com, igor.stoppa@nokia.com, tony@atomide.com, r-woodruff2@ti.com, sawant@ti.com, jouni.hogander@nokia.com

Hello Rajendra,

here are a few more comments on the CPUIdle patch set.  Many of these, we 
discussed today.  A closer look at patch 11/11 reveals that it will need 
some additional attention.


- Paul


General
-------

1. Please separate the context save/restore patches from the CPUIdle 
patches, and submit the context save/restore patches as an initial 
patchset, then the CPUIdle patches as a second set.

2. Also, split the cache associativity changes to 
arch/arm/mach-omap2/sleep34xx.S into a separate patch, and give it a 
descriptive commit message to help readers understand what is changing 
here.

Comments on the context save/restore patches
--------------------------------------------

3. On the patch 5/11 "scratchpad contents," please save/restore the 
scratchpad registers into a structure with descriptively-named fields 
rather than simply incrementing a pointer across a buffer.  This will 
document the layout of the scratchpad area and make this code easier to 
verify.

4. Also on the same patch, move the clear_scratchpad_contents() and 
save_scratchpad_contents() to mach-omap2/control.c.  Please rename these 
functions to omap3_clear_scratchpad_contents() and 
omap3_save_scratchpad_contents().

5. On patch 11/11 "CORE context save/restore," please use a structure with 
descriptively-named fields in place of "prcm_sleep_save", as was done for 
the "intc_context" and "control_ctx" structures in the same patch, and 
similar to comment #3 above.

6. Also on the same patch, this patch should be split into several smaller 
patches.  The PRCM, INTC, SRAM, and SCM save/restore functions should all 
be split into separate patches.  Please cc Paul Mundt 
<lethal@linux-sh.org> on the INTC patch.  Also please split the serial 
driver clock control patch into a separate patch.

7. In the new PRCM save/restore patch, please move omap3_save_prcm_ctx() 
and omap3_restore_prcm_ctx() to mach-omap2/prcm.c.

8. In the new IRQ save/restore patch, please move omap_save_intc_ctx() and 
omap_restore_intc_ctx() to mach-omap2/irq.c.

9. In the new SCM save/restore patch, please move omap_save_control_ctx() 
and omap_restore_control_ctx() to mach-omap2/control.c.

10. In the following changes to omap3_pm_init() in pm34xx.c hunk:

+       pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+       pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+

please add a comment between the two pwrdm_add_wkdep() functions, reading
something similar to:

/* 
 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
 * waking up PER with every CORE wakeup - see
 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
 */

11. In omap_(save|restore)_intc_ctx(), please use 
intc_bank_(read|write)_reg() instead of __omap_readl/writel().

12. In omap_save_core_context(), please use descriptive preprocessor 
macros for the constants in these two lines, so someone reading the code 
can clearly see what bits are being used without having to consult the 
TRM:

+              control_padconf_off |= 2;
...
+              while (!omap_readl(CONTROL_GENERAL_PURPOSE_STATUS) & 0x1);


13. Similarly, in the new serial driver patch, please use descriptive 
preprocessor macros for the constants in lines like these:

+ tmp = (serial_in(up, UART_OMAP_SYSC) & 0x7) | (1 << 3);


14. In omap3_enter_idle_bm(), the first branch of this conditional needs 
to have braces around it per CodingStyle chapter 2.

+               if (dev->safe_state)
+                       return dev->safe_state->enter(dev, dev->safe_state);
+               else {


15. All of these constants from cpuidle34xx.h should be moved into 
driver-specific files as implied by comments #7-9 above.  You should be 
able to delete many of them, since they already exist.  But whichever 
constants remain (if any) should be expressed as register offsets from the 
OMAP device base address, not absolute addresses:

+/* Interrupt Controller registers */
+#define INTC_BASE      0x48200000
+#define INTC_MIR_0     0x48200084
+#define INTC_MIR_1     0x482000A4
+#define INTC_MIR_2     0x482000C4
+#define INTCPS_SYSCONFIG       0x48200010
+#define INTCPS_PROTECTION      0x4820004C
+#define INTCPS_IDLE    0x48200050
+#define INTCPS_THRESHOLD       0x48200068
+
+#define CONTROL_PADCONF_SYS_NIRQ       0x480021E0
+#define CONTROL_PADCONF_OFF    0x48002270
+#define CONTROL_GENERAL_PURPOSE_STATUS 0x480022F4
+
+#define OMAP34XX_GPIO1_IRQENABLE1      0x4831001c
+#define OMAP34XX_GPIO1_WAKEUPEN        0x48310020
+#define OMAP34XX_GPIO1_FALLINGDETECT   0x4831004c



Comments on the CPUIdle patches
-------------------------------

16. Please drop the generic drivers/cpuidle/Kconfig patch from this set, 
since it will affect other trees, and send it upstream separately to 
linux-pm, lkml, and cc Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> 
and Len Brown <len.brown@intel.com> for them to merge.

17. As we discussed, there are some drivers which don't work yet with OFF 
mode unless unmergeable workarounds are present.  This is only a problem 
with C6, correct?  Or does it also apply to the CORE CSWR states?  Please 
wrap the affected states with #ifdefs, controlled by a new OMAP-specific 
Kconfig option, CONFIG_CPUIDLE_CORE_OFF_MODE or something similar.  This 
will also need to adjust OMAP3_MAX_STATES.  The option should default to 
disabled.  When enabled, this should allow driver authors to determine 
whether their drivers work with OFF mode.


