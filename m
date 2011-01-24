From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Mon, 24 Jan 2011 12:17:31 -0800
Message-ID: <20110124201731.GC13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44958 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1AXURz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 15:17:55 -0500
Content-Disposition: inline
In-Reply-To: <20110123174814.GI30094@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110123 09:47]:
> On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrote:
> > Move non-mapping and non-irq initialization code out of .map_io and
> > .init_irq respectively into the new init_early hook.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > I think I've updated this patch correctly for the new platforms merged
> > into mainline.
> 
> Grr, this breaks on OMAP because some of this stuff wants to do ioremap()
> and therefore wants the kmem allocators initialized.  That's rather
> annoying...

So far tested on zoom3 only, but the following gets it booting
on top of your patch.

Want to take this one into your series?  

Meanwhile, I'll add these both into our omap-testing branch
for some more testing.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 24 Jan 2011 11:56:37 -0800
Subject: [PATCH] omap2+: Fix omap_serial_early_init to work with init_early hook

The new init_early hook happens at the end of setup_arch,
which is too early for kzalloc. However, there's no need
to call omap_serial_early_init that early, so fix this
by setting it up as a subsys_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -400,8 +400,6 @@ void __init omap2_init_common_infrastructure(void)
 void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
-	omap_serial_early_init();
-
 	omap_hwmod_late_init();
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -655,7 +655,7 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 #endif
 
-void __init omap_serial_early_init(void)
+static int __init omap_serial_early_init(void)
 {
 	int i = 0;
 
@@ -691,7 +691,10 @@ void __init omap_serial_early_init(void)
 		 */
 		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
 	} while (1);
+
+	return 0;
 }
+subsys_initcall(omap_serial_early_init);
 
 /**
  * omap_serial_init_port() - initialize single serial port
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -96,7 +96,6 @@
 
 struct omap_board_data;
 
-extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
