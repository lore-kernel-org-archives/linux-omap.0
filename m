From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Thu, 18 Sep 2014 12:16:16 -0700
Message-ID: <20140918191615.GN14505@atomide.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
 <20140918171650.GK14505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23424 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaIRTQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 15:16:30 -0400
Content-Disposition: inline
In-Reply-To: <20140918171650.GK14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

* Tony Lindgren <tony@atomide.com> [140918 10:17]:
> * Tero Kristo <t-kristo@ti.com> [140901 11:09]:
> > Hi,
> > 
> > This set contains PRCM related cleanups meant for 3.18 merge window.
> > These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
> > (http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
> > set is used as basis to avoid merge issues.
> > 
> > Purpose of this work is to eventually convert the PRCM code into a
> > separate driver, but this is done in incremental parts as the amount
> > of changes is substantial. Expected conclusion of this work is 3.19
> > if everything goes fine.
> > 
> > This part of the work mostly moves some of the SoC specific PRCM driver
> > calls under generic version of the same, and adds SoC-ops to support
> > these on the driver level.
> > 
> > Working branch posted here:
> > 
> > tree: https://github.com/t-kristo/linux-pm.git
> > branch: for-v3.18/prcm-cleanup
> 
> Paul, any comments on this series?

Just gave this branch a quick try, it seems to work with off-idle
for me when merged with current linux-omap master branch. The following
merge resolution is needed because of the recent pre es3.1 fix though.

I've pushed out this merged with all the other pending patches into
omap-for-v3.18/tmp-merge-2014-09-18.

Nishant, care to give it a try and check your recent PM related
changes work with it?

Regards,

Tony

--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@@ -30,6 -30,12 +30,11 @@@
  #include "cm3xxx.h"
  #include "cm-regbits-34xx.h"
  
+ static void omap3xxx_prm_read_pending_irqs(unsigned long *events);
+ static void omap3xxx_prm_ocp_barrier(void);
+ static void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
+ static void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 -static void omap3xxx_prm_reconfigure_io_chain(void);
+ 
  static const struct omap_prcm_irq omap3_prcm_irqs[] = {
  	OMAP_PRCM_IRQ("wkup",	0,	0),
  	OMAP_PRCM_IRQ("io",	9,	1),
@@@ -391,9 -382,9 +396,9 @@@ void omap3430_pre_es3_1_reconfigure_io_
   * I/O wakeup gates are aligned with the current mux settings.  Works
   * by asserting WUCLKIN, waiting for WUCLKOUT to be asserted, and then
   * deasserting WUCLKIN and clearing the ST_IO_CHAIN WKST bit.  No
 - * return value.
 + * return value. These registers are only available in 3430 es3.1 and later.
   */
- void omap3_prm_reconfigure_io_chain(void)
 -static void omap3xxx_prm_reconfigure_io_chain(void)
++static void omap3_prm_reconfigure_io_chain(void)
  {
  	int i = 0;
  
