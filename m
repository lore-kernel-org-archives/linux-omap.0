From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Fri, 7 Jan 2011 09:48:14 +0200
Message-ID: <20110107074814.GC3230@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
 <20110104191359.GH7771@atomide.com>
 <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
 <20110107030449.GH7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:52812 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752782Ab1AGHsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 02:48:19 -0500
Received: by mail-ew0-f51.google.com with SMTP id 19so8127398ewy.10
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 23:48:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107030449.GH7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Jan 06, 2011 at 07:04:50PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110104 22:37]:
> > Hi,
> > 
> > On Tue, Jan 04, 2011 at 11:14:00AM -0800, Tony Lindgren wrote:
> > > I think there's been some patches related to this to get rid
> > > of NR_IRQS? Might be worth taking a look at those first as it's
> > > a generic solution.
> > 
> > Yeah, one way would be to use Sparse IRQ numbering scheme and define
> > different bases for different IRQ chips. We could use for example,
> > something like:
> > 
> > IRQ	|	Chip
> > =====================
> > 0-299	|	INTC
> > 300-499	|	TWL4030
> > 500-599	|	MENELAUS
> > 600-799	|	RETU
> > 800-999	|	TAHVO
> > 
> > and so on. But I'm not sure that's good enough (numbers are just from
> > the top of my head, didn't really check how many IRQs each one have).
> > 
> > The only problem I see is with INTC, what happens if we give it an
> > interval which ends up not being big enough for next OMAP versions ?
> 
> I think that's the way to go, but we should not allocate that
> many irqs.. We can define the ranges like we already do in irqs.h
> based on what gets compiled in. There are few more blocks though:

The main point of using Sparse IRQ numbering is exactly avoiding
pre-processor branches. Instead of defining ranges only when a device is
compile, we can always keep the range allocated no matter if the device
probes or not. So, I suggest dropping the ifdeffery on <plat/irqs.h> and
move that to something like below:

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 65e20a6..c4fcd9d 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -367,49 +367,28 @@
 
 /* External FPGA handles interrupts on Innovator boards */
 #define        OMAP_FPGA_IRQ_BASE      (OMAP_IRQ_END)
-#ifdef CONFIG_MACH_OMAP_INNOVATOR
 #define OMAP_FPGA_NR_IRQS      24
-#else
-#define OMAP_FPGA_NR_IRQS      0
-#endif
 #define OMAP_FPGA_IRQ_END      (OMAP_FPGA_IRQ_BASE + OMAP_FPGA_NR_IRQS)
 
 /* External TWL4030 can handle interrupts on 2430 and 34xx boards */
 #define        TWL4030_IRQ_BASE        (OMAP_FPGA_IRQ_END)
-#ifdef CONFIG_TWL4030_CORE
 #define        TWL4030_BASE_NR_IRQS    8
 #define        TWL4030_PWR_NR_IRQS     8
-#else
-#define        TWL4030_BASE_NR_IRQS    0
-#define        TWL4030_PWR_NR_IRQS     0
-#endif
 #define TWL4030_IRQ_END                (TWL4030_IRQ_BASE + TWL4030_BASE_NR_IRQS)
 #define TWL4030_PWR_IRQ_BASE   TWL4030_IRQ_END
 #define        TWL4030_PWR_IRQ_END     (TWL4030_PWR_IRQ_BASE + TWL4030_PWR_NR_IRQS)
 
 /* External TWL4030 gpio interrupts are optional */
 #define TWL4030_GPIO_IRQ_BASE  TWL4030_PWR_IRQ_END
-#ifdef CONFIG_GPIO_TWL4030
 #define TWL4030_GPIO_NR_IRQS   18
-#else
-#define        TWL4030_GPIO_NR_IRQS    0
-#endif
 #define TWL4030_GPIO_IRQ_END   (TWL4030_GPIO_IRQ_BASE + TWL4030_GPIO_NR_IRQS)
 
 #define        TWL6030_IRQ_BASE        (OMAP_FPGA_IRQ_END)
-#ifdef CONFIG_TWL4030_CORE
 #define        TWL6030_BASE_NR_IRQS    20
-#else
-#define        TWL6030_BASE_NR_IRQS    0
-#endif
 #define TWL6030_IRQ_END                (TWL6030_IRQ_BASE + TWL6030_BASE_NR_IRQS)
 
 /* Total number of interrupts depends on the enabled blocks above */
-#if (TWL4030_GPIO_IRQ_END > TWL6030_IRQ_END)
-#define TWL_IRQ_END            TWL4030_GPIO_IRQ_END
-#else
-#define TWL_IRQ_END            TWL6030_IRQ_END
-#endif
+#define TWL_IRQ_END            TWL4030_GPIO_IRQ_END
 
 #define NR_IRQS                        TWL_IRQ_END
 

-- 
balbi
