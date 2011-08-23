From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: Fwd: [RFC/PATCH v2 11/13] dt: omap4: add generic board file for
	dt support
Date: Tue, 23 Aug 2011 21:00:41 +0530
Message-ID: <20110823153041.GD32698@manju-desktop>
References: <1314074021-25186-12-git-send-email-manjugk@ti.com>
	<4E537F80.1060001@ti.com> <4E53A57D.7060905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E53A57D.7060905@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 23, 2011 at 03:05:01PM +0200, Cousson, Benoit wrote:
> From: G, Manjunath Kondaiah<manjugk@ti.com>
> >The generic board file is created and derived from omap4 panda board file.
> >
> >The changes here focus on minimal configuration to boot panda board with
> >dt enabled which provides basic platform for converting device drivers for
> >using dt.
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >---
> >   arch/arm/boot/dts/omap4-panda.dts      |    2 +-
> >   arch/arm/mach-omap2/Kconfig            |   11 +++++
> >   arch/arm/mach-omap2/Makefile           |    1 +
> >   arch/arm/mach-omap2/board-omap4-dt.c   |   66
> >++++++++++++++++++++++++++++++++
> >   arch/arm/mach-omap2/board-omap4panda.c |    6 ---
> >   5 files changed, 79 insertions(+), 7 deletions(-)
> >   create mode 100644 arch/arm/mach-omap2/board-omap4-dt.c
> >
> >diff --git a/arch/arm/boot/dts/omap4-panda.dts
> >b/arch/arm/boot/dts/omap4-panda.dts
> >index 6b831ca..9d1b17c 100644
> >--- a/arch/arm/boot/dts/omap4-panda.dts
> >+++ b/arch/arm/boot/dts/omap4-panda.dts
> >@@ -2,7 +2,7 @@
> >
> >   / {
> >   	model = "TI OMAP4 PandaBoard";
> >-	compatible = "ti,omap4-panda", "ti,omap4430";
> >+	compatible = "ti,omap4-panda", "ti,omap4";
> 
> That change does not belong here, or at least should be listed in
> the changelog. Potentially you should keep the ti,omap4430 and just
> add the ti,omap4 to have the most generic compatible value.
ok.
> 
> >
> >   	i2c1 {
> >   		clock-frequency =<400000>;
> >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >index 4fbb54d..853b14c 100644
> >--- a/arch/arm/mach-omap2/Kconfig
> >+++ b/arch/arm/mach-omap2/Kconfig
> >@@ -337,6 +337,17 @@ config MACH_OMAP4_PANDA
> >   	select OMAP_PACKAGE_CBS
> >   	select REGULATOR_FIXED_VOLTAGE
> >
> >+config MACH_OMAP4_DT
> >+	bool "Generic OMAP4 board(FDT support)"
> >+	depends on ARCH_OMAP4
> >+	select OMAP_PACKAGE_CBB
> 
> Wrong package... it looks like some OMAP3 copy/paste.
> 
> >+	select USE_OF
> >+
> >+	help
> >+	  Support for generic TI OMAP4 boards using Flattened Device Tree.
> >+	  Say Y here to enable OMAP3 device tree support
> 
> Some more copy/paste evidence:-)
Sorry for this typo. Will fix it.
> 
> >+	  More information at Documentation/devicetree
> >+
> >   config OMAP3_EMU
> >   	bool "OMAP3 debugging peripherals"
> >   	depends on ARCH_OMAP3
> >diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >index e702e47..8b8c29c 100644
> >--- a/arch/arm/mach-omap2/Makefile
> >+++ b/arch/arm/mach-omap2/Makefile
> >@@ -198,6 +198,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
> >   obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
> >   obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
> >   obj-$(CONFIG_MACH_OMAP3_DT)		+= board-omap3-dt.o
> >+obj-$(CONFIG_MACH_OMAP4_DT)		+= board-omap4-dt.o
> 
> Boards are grouped by SoC version.
one board file/soc family like board-omap4-dt for omap4xxxx
can you please be more specific what changes you are expecting?

> 
> >   obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
> >   obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
> >   					   sdram-nokia.o
> >diff --git a/arch/arm/mach-omap2/board-omap4-dt.c
> >b/arch/arm/mach-omap2/board-omap4-dt.c
> >new file mode 100644
> >index 0000000..a4d296c
> >--- /dev/null
> >+++ b/arch/arm/mach-omap2/board-omap4-dt.c
> >@@ -0,0 +1,66 @@
> >+/*
> >+ * TI OMAP3 device tree board support
> 
> One more C&P.
> 
> >+ *
> >+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2 as
> >+ * published by the Free Software Foundation.
> >+ */
> >+
> >+#include<linux/kernel.h>
> >+#include<linux/init.h>
> >+#include<linux/i2c/twl.h>
> >+
> >+#include<mach/omap4-common.h>
> 
> nitpicking, but it should go after <plat/common.h>.
ok
> 
> >+#include<asm/mach/arch.h>
> >+#include<asm/mach/map.h>
> >+
> >+#include<plat/common.h>
> >+
> >+#include "common-board-devices.h"
> >+
> >+static void __init omap4_init_early(void)
> >+{
> >+	omap2_init_common_infrastructure();
> >+	omap2_init_common_devices(NULL, NULL);
> >+}
> >+
> >+static struct twl4030_platform_data omap4_twldata = {
> >+	.irq_base	= TWL6030_IRQ_BASE,
> >+	.irq_end	= TWL6030_IRQ_END,
> >+};
> >+
> >+static int __init omap4_i2c_init(void)
> >+{
> >+	omap4_pmic_init("twl6030",&omap4_twldata);
> >+	return 0;
> >+}
> >+
> >+static void __init omap4_init(void)
> >+{
> >+	omap4_i2c_init();
> >+	omap_serial_init();
> >+}
> >+
> >+static void __init omap4_map_io(void)
> >+{
> >+	omap2_set_globals_443x();
> >+	omap44xx_map_common_io();
> >+}
> >+
> >+static const char *omap4_match[] __initdata = {
> >+	"ti,omap4",
> >+	NULL,
> >+};
> >+
> >+DT_MACHINE_START(OMAP4_DT, "TI OMAP4 (Flattened Device Tree)")
> >+	.boot_params	= 0x80000100,
> 
> Not needed anymore with DT.
yes
> 
> >+	.reserve	= omap_reserve,
> >+	.map_io		= omap4_map_io,
> >+	.init_early	= omap4_init_early,
> >+	.init_irq	= gic_init_irq,
> >+	.init_machine	= omap4_init,
> >+	.timer		=&omap4_timer,
> >+	.dt_compat	= omap4_match,
> >+MACHINE_END
> >diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> >b/arch/arm/mach-omap2/board-omap4panda.c
> >index 1c583c7..9aaa960 100644
> >--- a/arch/arm/mach-omap2/board-omap4panda.c
> >+++ b/arch/arm/mach-omap2/board-omap4panda.c
> 
> That change does not really belong here or the changelog is not correct.
> You can potentially do it in an other patch before. It will not
> really introduce any regression if you do it before adding any
> information into panda DT.
ok.

-M
