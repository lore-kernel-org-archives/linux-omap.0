From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Tue, 4 Jan 2011 09:46:15 +0200
Message-ID: <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57954 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299Ab1ADHqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 02:46:20 -0500
Received: by yxe42 with SMTP id 42so6804479yxe.37
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 23:46:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Tue, Jan 04, 2011 at 08:52:29AM +0200, Felipe Balbi wrote:
>On Mon, Jan 03, 2011 at 05:40:02PM -0800, Tony Lindgren wrote:
>>* Felipe Balbi <balbi@ti.com> [110102 23:49]:
>>>@@ -53,23 +54,23 @@
>>> struct retu {
>>> 	/* Device lock */
>>> 	spinlock_t		lock;
>>>-	struct tasklet_struct	tasklet;
>>>+	struct mutex		irq_lock;
>>> 	struct device		*dev;
>>>
>>>+	int			irq_base;
>>>+	int			nirqs;
>>> 	int			irq;
>>
>>This one oopses, looks like irq_base is not initialized?
>
>Aaa, good catch. Sorry for that. Gotta add a platform_data for passing
>that around. Will do it on V2.

Looking into <plat/irqs.h> it seems like there will be quite some
ifdeffery added to have support for Retu irq_base (and later Tahvo,
menelaus, ISP, etc etc); so, would you be willing to accept an atomic
counter to keep track of that ?

Something like the following:

static atomic_t omap_irq_base;

int omap_irq_get_base(void)
{
	return atomic_read(&omap_irq_base);
}

void omap_irq_set_base(int base)
{
	atomic_set(&omap_irq_base, base);
}

void omap_irq_add(int nirqs)
{
	atomic_add(nirqs, &omap_irq_base);
}

void omap_irq_sub(int nirqs)
{
	atomic_sub(nirqs, &omap_irq_base);
}

static int __init omap_irq_init(void)
{
	atomic_set(&omap_irq_base, 0);

	return 0;
}
postcore_initcall(omap_irq_init);

Then, INTC will always be the first one to call omap_irq_add():

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 85bf8ca..3d91a11 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -14,6 +14,7 @@
  #include <linux/init.h>
  #include <linux/interrupt.h>
  #include <linux/io.h>
+#include <plat/irqs.h>
  #include <mach/hardware.h>
  #include <asm/mach/irq.h>
  
@@ -224,6 +225,8 @@ void __init omap_init_irq(void)
                 set_irq_handler(i, handle_level_irq);
                 set_irq_flags(i, IRQF_VALID);
         }
+
+       omap_irq_add(nr_of_irqs);
  }
  
  #ifdef CONFIG_ARCH_OMAP3

and when adding e.g. twl4030, we could:

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3b39ef1..3ae342b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -31,6 +31,7 @@
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
  
+#include <plat/irqs.h>
  #include <plat/mcspi.h>
  #include <plat/board.h>
  #include <plat/usb.h>
@@ -571,8 +572,8 @@ static struct twl4030_codec_data sdp3430_codec = {
  };
  
  static struct twl4030_platform_data sdp3430_twldata = {
-       .irq_base       = TWL4030_IRQ_BASE,
-       .irq_end        = TWL4030_IRQ_END,
+       .irq_base       = -EINVAL,      /* fixed up later */
+       .irq_end        = -EINVAL,      /* fixed up later */
  
         /* platform_data for children goes here */
         .bci            = &sdp3430_bci_data,
@@ -593,6 +594,14 @@ static struct twl4030_platform_data sdp3430_twldata = {
         .vpll2          = &sdp3430_vpll2,
  };
  
+static void __init sdp3430_twl_init(void)
+{
+       int             irq_base = omap_irq_get_base();
+
+       sdp3430_twldata.irq_base = irq_base;
+       sdp3430_twldata.irq_end = irq_base + TWL4030_BASE_NR_IRQS;
+}
+
  static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
         {
                 I2C_BOARD_INFO("twl4030", 0x48),
@@ -794,6 +803,7 @@ static struct omap_musb_board_data musb_board_data = {
  static void __init omap_3430sdp_init(void)
  {
         omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+       sdp3430_twl_init();
         omap3430_i2c_init();
         platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
         if (omap_rev() > OMAP3430_REV_ES1_0)

either that, or we add several ifdefs to <plat/irqs.h> and maintain that
over time. What do you think ?

-- 
balbi
