From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP3: Add basic board support for OMAP LDP (Re:
	[PATCH 0/0] Add minimal omap34xx support)
Date: Fri, 10 Oct 2008 12:15:59 +0300
Message-ID: <20081010091557.GI3044@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57829 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYJJJQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 05:16:13 -0400
Content-Disposition: inline
In-Reply-To: <20081010073251.GN435@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081010 11:42]:
> On Thu, Oct 09, 2008 at 06:17:25PM +0300, Tony Lindgren wrote:
> > Sure, I'll post a minimal LDP patch separately tomorrow. I don't have
> > an LDP so I can't verify it boots though.
> 
> Unfortunately, Linus has been unpredictable, and released 2.6.27 last
> night, rather than the usual one week after -rc9.
> 
> What this means is that the merge window is now open, and I shouldn't
> be accepting anything else into my kernel tree.
> 
> However, if you can get LDP in by this evening, I'll pull it into the
> tree.  That will be the final devel code merged into my tree for 2.6.28.

Sure. Here's the minimal board patch for LDP with it's defconfig
in the following mail. Also added to the omap3-upstream queue.

Tony


--Bn2rw/3z4jIqBvZU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap3-ldp.patch"

>From 492656511b109b5f9ee64d05c90b5bd9043549fa Mon Sep 17 00:00:00 2001
From: Nishant Kamat <nskamat@ti.com>
Date: Fri, 10 Oct 2008 11:28:23 +0300
Subject: [PATCH] ARM: OMAP3: Add basic board support for OMAP LDP

This adds minimal board support for the OMAP3430 LDP development platform.

Signed-off-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index aef043b..4832fcc 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -48,6 +48,10 @@ config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_LDP
+	bool "OMAP3 LDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OVERO
 	bool "Gumstix Overo board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index feb9caf..c693923 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -30,5 +30,6 @@ obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
+obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
new file mode 100644
index 0000000..1ea5998
--- /dev/null
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -0,0 +1,86 @@
+/*
+ * linux/arch/arm/mach-omap2/board-ldp.c
+ *
+ * Copyright (C) 2008 Texas Instruments Inc.
+ * Nishant Kamat <nskamat@ti.com>
+ *
+ * Modified from mach-omap2/board-3430sdp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/workqueue.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/board-ldp.h>
+#include <mach/mcspi.h>
+#include <mach/gpio.h>
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/gpmc.h>
+
+#include <asm/io.h>
+#include <asm/delay.h>
+#include <mach/control.h>
+
+static void __init omap_ldp_init_irq(void)
+{
+	omap2_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_uart_config ldp_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct omap_board_config_kernel ldp_config[] __initdata = {
+	{ OMAP_TAG_UART,	&ldp_uart_config },
+};
+
+static int __init omap_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
+
+static void __init omap_ldp_init(void)
+{
+	omap_i2c_init();
+	omap_board_config = ldp_config;
+	omap_board_config_size = ARRAY_SIZE(ldp_config);
+	omap_serial_init();
+}
+
+static void __init omap_ldp_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP_LDP, "OMAP LDP board")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_ldp_map_io,
+	.init_irq	= omap_ldp_init_irq,
+	.init_machine	= omap_ldp_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/mach/board-ldp.h b/arch/arm/plat-omap/include/mach/board-ldp.h
new file mode 100644
index 0000000..66e2746
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/board-ldp.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/plat-omap/include/mach/board-ldp.h
+ *
+ * Hardware definitions for TI OMAP3 LDP.
+ *
+ * Copyright (C) 2008 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_LDP_H
+#define __ASM_ARCH_OMAP_LDP_H
+
+extern void twl4030_bci_battery_init(void);
+
+#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
+
+#endif /* __ASM_ARCH_OMAP_LDP_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 80f6d7e..6589ddb 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -326,6 +326,10 @@
 #include "board-omap3beagle.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP_LDP
+#include "board-ldp.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_APOLLON
 #include "board-apollon.h"
 #endif

--Bn2rw/3z4jIqBvZU--
