From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] TI816X: Update to use init_early
Date: Wed, 16 Feb 2011 09:12:41 -0800
Message-ID: <20110216171241.GE20795@atomide.com>
References: <1297791368-32042-1-git-send-email-hemantp@ti.com>
 <20110215180139.GF11199@n2100.arm.linux.org.uk>
 <20110215180533.GA20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39428 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab1BPRNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 12:13:01 -0500
Content-Disposition: inline
In-Reply-To: <20110215180533.GA20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hemant Pedanekar <hemantp@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110215 10:04]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110215 10:00]:
> > On Tue, Feb 15, 2011 at 11:06:08PM +0530, Hemant Pedanekar wrote:
> > > +static void __init ti8168_evm_init_irq(void)
> > > +{
> > > +	omap_board_config = ti8168_evm_config;
> > > +	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> > > +	omap2_init_common_infrastructure();
> > > +	omap2_init_common_devices(NULL, NULL);
> > > +	omap_init_irq();
> > > +}
> > 
> > What here can use the new init_early hook in the machine record?
> 
> I can fix this up for the init_early changes when I merge the branches
> together.

Here's the patch to do that.

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 16 Feb 2011 08:45:46 -0800
Subject: [PATCH] TI816X: Update to use init_early

Update to use init_early

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -27,12 +27,16 @@
 static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
 };
 
-static void __init ti8168_evm_init_irq(void)
+static void __init ti8168_init_early(void)
 {
 	omap_board_config = ti8168_evm_config;
 	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
+}
+
+static void __init ti8168_evm_init_irq(void)
+{
 	omap_init_irq();
 }
 
@@ -51,6 +55,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	/* Maintainer: Texas Instruments */
 	.boot_params	= 0x80000100,
 	.map_io		= ti8168_evm_map_io,
+	.init_early	= ti8168_init_early,
 	.init_irq	= ti8168_evm_init_irq,
 	.timer		= &omap_timer,
 	.init_machine	= ti8168_evm_init,
