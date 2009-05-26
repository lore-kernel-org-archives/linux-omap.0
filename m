From: Jean Pihet <jpihet@mvista.com>
Subject: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was: Re: Beagleboard rev C memory timings & suspend/resume)
Date: Tue, 26 May 2009 15:27:16 +0200
Message-ID: <200905261527.16648.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <200905112110.34589.jpihet@mvista.com> <alpine.DEB.2.00.0905111416350.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_04+GKjqjDpqIBqT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:34519 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZEZN1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 09:27:44 -0400
In-Reply-To: <alpine.DEB.2.00.0905111416350.17514@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

--Boundary-00=_04+GKjqjDpqIBqT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul, Kevin,

Here is a patch for the SDRC 2nd CS support. It applies on top of the curre=
nt=20
pm branch.

I have some questions:
=2D Is it OK to copy the micron sdram params file to a new file with the 2 =
CSes=20
params? One could use a unique file with #ifdef SDRC_SUPPORT_2_CSES.
=2D Does the RX51 board have 2 sdram parts? If so I need to update the boar=
d=20
file as well.

Comments are welcome.

Regards,
Jean

=46rom 517f52f4bef8225c5921b55ecd96eda2e0c4b697 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 26 May 2009 14:55:57 +0200
Subject: [PATCH] OMAP3: add support for 2 SDRAM chip selects

Some boards (Beagle Cx, Overo) have 2 SDRAM parts
connected to the SDRC.

This patch adds the following:
=2D ensure that the CKE signals mux settings are correct
=2D extend the omap_sdrc_params struct with the 2nd CS params
=2D add a new file for the micron sdram params for 2 CSes
=2D adapt the sram sleep code to configure the SDRC for the 2nd CS

Thanks to Paul Walmsley and Kevin Hilman for the suggestions
and code reviews.

Tested on Beagleboard rev C2 and B5.

Signed-off-by: Jean Pihet <jpihet@mvista.com>

On Monday 11 May 2009 22:27:50 Paul Walmsley wrote:
> Hi Jean,
>
> On Mon, 11 May 2009, Jean Pihet wrote:
> > On Saturday 09 May 2009 00:43:43 Paul Walmsley wrote:
> > > One possibility: perhaps the problem is with Beagle's pin mux setting=
s.
> > > You might want to boot with mem=3D128M and make sure
> > > CONTROL_PADCONF_SAD2D_SBUSFLAG and CONTROL_PADCONF_SDRC_CKE1 are in
> > > mode 0 before suspend and after resume.
> >
> > Yes that definitely is the root cause. I should have checked this first
> > ;-( The U-Boot change is committed, cf.
> > http://gitorious.org/u-boot-omap3/mainline/commit/c6f01ad390308800693c6=
2d
> >bdb096ab59e03630b and
> > http://gitorious.org/u-boot-omap3/mainline/commit/4025cfbde3611b14c0d48=
31
> >a5524e5e061128e30
>
> Nice work!
>
> Sounds like we should also patch mach-omap2/sdrc.c:omap2_sdrc_init() to
> warn if the sdrc_cke1 pin mux is wrong if a second struct omap_sdrc_params
> * is passed.  Probably board-omap3beagle.c should also remux the pad if
> it's wrong.  Otherwise there will be a lot of unhappy Rev C BeagleBoard
> users.
>
> > I am looking at a fix for the SDRC setup with 2 CSes. I will propose the
> > changes asap.
>
> Excellent, thanks Jean.
>
>
> - Paul



--Boundary-00=_04+GKjqjDpqIBqT
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-OMAP3-add-support-for-2-SDRAM-chip-selects.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-OMAP3-add-support-for-2-SDRAM-chip-selects.patch"

=46rom 517f52f4bef8225c5921b55ecd96eda2e0c4b697 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 26 May 2009 14:55:57 +0200
Subject: [PATCH] OMAP3: add support for 2 SDRAM chip selects

Some boards (Beagle Cx, Overo) have 2 SDRAM parts
connected to the SDRC.

This patch adds the following:
=2D ensure that the CKE signals mux settings are correct
=2D extend the omap_sdrc_params struct with the 2nd CS params
=2D add a new file for the micron sdram params for 2 CSes
=2D adapt the sram sleep code to configure the SDRC for the 2nd CS

Thanks to Paul Walmsley and Kevin Hilman for the suggestions
and code reviews.

Tested on Beagleboard rev C2 and B5.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 arch/arm/mach-omap2/board-omap3beagle.c            |    6 +-
 arch/arm/mach-omap2/board-overo.c                  |    6 +-
 arch/arm/mach-omap2/board-rx51-sdram.c             |    8 +-
 arch/arm/mach-omap2/clock34xx.c                    |   18 ++-
 arch/arm/mach-omap2/mux.c                          |    6 +
 .../mach-omap2/sdram-micron-mt46h32m32lf-6-2cses.h |   93 ++++++++++++++
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   60 +++++-----
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   40 +++---
 arch/arm/mach-omap2/sdrc.c                         |   15 ++-
 arch/arm/mach-omap2/sram34xx.S                     |  128 +++++++++++++++-=
=2D---
 arch/arm/plat-omap/include/mach/mux.h              |    4 +
 arch/arm/plat-omap/include/mach/sdrc.h             |   23 +++--
 arch/arm/plat-omap/include/mach/sram.h             |   12 +-
 arch/arm/plat-omap/sram.c                          |   34 +++--
 14 files changed, 329 insertions(+), 124 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6-2cses.h

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/=
board-omap3beagle.c
index 7294dbf..7128213 100644
=2D-- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -110,7 +110,7 @@ static struct platform_device omap3beagle_nand_device =
=3D {
 	.resource	=3D &omap3beagle_nand_resource,
 };
=20
=2D#include "sdram-micron-mt46h32m32lf-6.h"
+#include "sdram-micron-mt46h32m32lf-6-2cses.h"
=20
 static struct omap_uart_config omap3_beagle_uart_config __initdata =3D {
 	.enabled_uarts	=3D ((1 << 0) | (1 << 1) | (1 << 2)),
@@ -441,6 +441,10 @@ static void __init omap3_beagle_init(void)
 	usb_musb_init();
 	usb_ehci_init();
 	omap3beagle_flash_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
=20
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-=
overo.c
index 9eae608..a6ac353 100644
=2D-- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -47,7 +47,7 @@
 #include <mach/nand.h>
 #include <mach/usb.h>
=20
=2D#include "sdram-micron-mt46h32m32lf-6.h"
+#include "sdram-micron-mt46h32m32lf-6-2cses.h"
 #include "twl4030-generic-scripts.h"
 #include "mmc-twl4030.h"
=20
@@ -391,6 +391,10 @@ static void __init overo_init(void)
 	overo_init_smsc911x();
 	overo_ads7846_init();
=20
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") =3D=3D 0) &&
 	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) =3D=3D 0)) {
diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/b=
oard-rx51-sdram.c
index 32b5da4..2e37b0f 100644
=2D-- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -204,10 +204,10 @@ struct omap_sdrc_params *rx51_get_sdram_timings(void)
 	rfr_ctrl =3D l | 0x3; /* autorefresh, reload counter with 8xARCV */
=20
 	rx51_sdrc_params[0].rate =3D 133333333;
=2D	rx51_sdrc_params[0].actim_ctrla =3D actim_ctrla;
=2D	rx51_sdrc_params[0].actim_ctrlb =3D actim_ctrlb;
=2D	rx51_sdrc_params[0].rfr_ctrl =3D rfr_ctrl;
=2D	rx51_sdrc_params[0].mr =3D 0x32;
+	rx51_sdrc_params[0].actim_ctrl_a_0 =3D actim_ctrla;
+	rx51_sdrc_params[0].actim_ctrl_b_0 =3D actim_ctrlb;
+	rx51_sdrc_params[0].rfr_ctrl_0 =3D rfr_ctrl;
+	rx51_sdrc_params[0].mr_0 =3D 0x32;
=20
 	rx51_sdrc_params[1].rate =3D 0;
=20
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index 3cee6b4..a019711 100644
=2D-- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -518,12 +518,18 @@ static int omap3_core_dpll_m2_set_rate(struct clk *cl=
k, unsigned long rate)
=20
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
=2D	pr_debug("clock: SDRC timing params used: %08x %08x %08x\n",
=2D		 sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
=2D
=2D	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
=2D				  sp->actim_ctrlb, new_div, unlock_dll, c,
=2D				  sp->mr, rate > clk->rate);
+	pr_debug("Clock: SDRC timing params used: "
+		 "CS0 %08x %08x %08x %08x, CS1 %08x %08x %08x %08x\n",
+		 sp->rfr_ctrl_0, sp->actim_ctrl_a_0,
+		 sp->actim_ctrl_b_0, sp->mr_0,
+		 sp->rfr_ctrl_1, sp->actim_ctrl_a_1,
+		 sp->actim_ctrl_b_1, sp->mr_1);
+
+	omap3_configure_core_dpll(new_div, unlock_dll, c, rate > clk->rate,
+				  sp->rfr_ctrl_0, sp->actim_ctrl_a_0,
+				  sp->actim_ctrl_b_0, sp->mr_0,
+				  sp->rfr_ctrl_1, sp->actim_ctrl_a_1,
+				  sp->actim_ctrl_b_1, sp->mr_1);
=20
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..43d6b92 100644
=2D-- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,12 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 };
=20
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6-2cses.h b/arch=
/arm/mach-omap2/sdram-micron-mt46h32m32lf-6-2cses.h
new file mode 100644
index 0000000..5b9be9e
=2D-- /dev/null
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6-2cses.h
@@ -0,0 +1,93 @@
+/*
+ * SDRC register values for the Micron MT46H32M32LF-6
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
+#define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
+
+#include <mach/sdrc.h>
+
+/* Micron MT46H32M32LF-6, using 2 parts on CS0 and CS1 */
+/* XXX Using ARE =3D 0x1 (no autorefresh burst) -- can this be changed? */
+static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] =3D {
+	[0] =3D {
+		.rate			=3D 166000000,
+		.actim_ctrl_a_0		=3D 0x9a9db4c6,
+		.actim_ctrl_b_0 	=3D 0x00011217,
+		.rfr_ctrl_0		=3D 0x0004dc01,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x9a9db4c6,
+		.actim_ctrl_b_1 	=3D 0x00011217,
+		.rfr_ctrl_1		=3D 0x0004dc01,
+		.mr_1			=3D 0x00000032,
+	},
+	[1] =3D {
+		.rate			=3D 165941176,
+		.actim_ctrl_a_0		=3D 0x9a9db4c6,
+		.actim_ctrl_b_0		=3D 0x00011217,
+		.rfr_ctrl_0		=3D 0x0004dc01,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x9a9db4c6,
+		.actim_ctrl_b_1		=3D 0x00011217,
+		.rfr_ctrl_1		=3D 0x0004dc01,
+		.mr_1			=3D 0x00000032,
+	},
+	[2] =3D {
+		.rate			=3D 133333333,
+		.actim_ctrl_a_0		=3D 0x7a19b485,
+		.actim_ctrl_b_0		=3D 0x00011213,
+		.rfr_ctrl_0		=3D 0x0003de01,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x7a19b485,
+		.actim_ctrl_b_1		=3D 0x00011213,
+		.rfr_ctrl_1		=3D 0x0003de01,
+		.mr_1			=3D 0x00000032,
+	},
+	[3] =3D {
+		.rate			=3D 83000000,
+		.actim_ctrl_a_0		=3D 0x51512283,
+		.actim_ctrl_b_0		=3D 0x0001120c,
+		.rfr_ctrl_0		=3D 0x00025501,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x51512283,
+		.actim_ctrl_b_1		=3D 0x0001120c,
+		.rfr_ctrl_1		=3D 0x00025501,
+		.mr_1			=3D 0x00000032,
+	},
+	[4] =3D {
+		.rate			=3D 82970588,
+		.actim_ctrl_a_0		=3D 0x51512283,
+		.actim_ctrl_b_0		=3D 0x0001120c,
+		.rfr_ctrl_0		=3D 0x00025501,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x51512283,
+		.actim_ctrl_b_1		=3D 0x0001120c,
+		.rfr_ctrl_1		=3D 0x00025501,
+		.mr_1			=3D 0x00000032,
+	},
+	[5] =3D {
+		.rate			=3D 66666666,
+		.actim_ctrl_a_0		=3D 0x410d2243,
+		.actim_ctrl_b_0		=3D 0x0001120a,
+		.rfr_ctrl_0		=3D 0x0001d601,
+		.mr_0			=3D 0x00000032,
+		.actim_ctrl_a_1		=3D 0x410d2243,
+		.actim_ctrl_b_1		=3D 0x0001120a,
+		.rfr_ctrl_1		=3D 0x0001d601,
+		.mr_1			=3D 0x00000032,
+	},
+	[6] =3D {
+		.rate	     =3D 0
+	},
+};
+
+#endif
diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/m=
ach-omap2/sdram-micron-mt46h32m32lf-6.h
index b6c1db3..3b0dce4 100644
=2D-- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -20,46 +20,46 @@
 /* XXX Using ARE =3D 0x1 (no autorefresh burst) -- can this be changed? */
 static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] =3D {
 	[0] =3D {
=2D		.rate	     =3D 166000000,
=2D		.actim_ctrla =3D 0x9a9db4c6,
=2D		.actim_ctrlb =3D 0x00011217,
=2D		.rfr_ctrl    =3D 0x0004dc01,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 166000000,
+		.actim_ctrl_a_0	=3D 0x9a9db4c6,
+		.actim_ctrl_b_0	=3D 0x00011217,
+		.rfr_ctrl_0	=3D 0x0004dc01,
+		.mr_0		=3D 0x00000032,
 	},
 	[1] =3D {
=2D		.rate	     =3D 165941176,
=2D		.actim_ctrla =3D 0x9a9db4c6,
=2D		.actim_ctrlb =3D 0x00011217,
=2D		.rfr_ctrl    =3D 0x0004dc01,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 165941176,
+		.actim_ctrl_a_0	=3D 0x9a9db4c6,
+		.actim_ctrl_b_0	=3D 0x00011217,
+		.rfr_ctrl_0	=3D 0x0004dc01,
+		.mr_0		=3D 0x00000032,
 	},
 	[2] =3D {
=2D		.rate	     =3D 133333333,
=2D		.actim_ctrla =3D 0x7a19b485,
=2D		.actim_ctrlb =3D 0x00011213,
=2D		.rfr_ctrl    =3D 0x0003de01,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 133333333,
+		.actim_ctrl_a_0	=3D 0x7a19b485,
+		.actim_ctrl_b_0	=3D 0x00011213,
+		.rfr_ctrl_0	=3D 0x0003de01,
+		.mr_0		=3D 0x00000032,
 	},
 	[3] =3D {
=2D		.rate	     =3D 83000000,
=2D		.actim_ctrla =3D 0x51512283,
=2D		.actim_ctrlb =3D 0x0001120c,
=2D		.rfr_ctrl    =3D 0x00025501,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 83000000,
+		.actim_ctrl_a_0	=3D 0x51512283,
+		.actim_ctrl_b_0	=3D 0x0001120c,
+		.rfr_ctrl_0	=3D 0x00025501,
+		.mr_0		=3D 0x00000032,
 	},
 	[4] =3D {
=2D		.rate	     =3D 82970588,
=2D		.actim_ctrla =3D 0x51512283,
=2D		.actim_ctrlb =3D 0x0001120c,
=2D		.rfr_ctrl    =3D 0x00025501,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 82970588,
+		.actim_ctrl_a_0	=3D 0x51512283,
+		.actim_ctrl_b_0	=3D 0x0001120c,
+		.rfr_ctrl_0	=3D 0x00025501,
+		.mr_0		=3D 0x00000032,
 	},
 	[5] =3D {
=2D		.rate	     =3D 66666666,
=2D		.actim_ctrla =3D 0x410d2243,
=2D		.actim_ctrlb =3D 0x0001120a,
=2D		.rfr_ctrl    =3D 0x0001d601,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 66666666,
+		.actim_ctrl_a_0	=3D 0x410d2243,
+		.actim_ctrl_b_0	=3D 0x0001120a,
+		.rfr_ctrl_0	=3D 0x0001d601,
+		.mr_0		=3D 0x00000032,
 	},
 	[6] =3D {
 		.rate	     =3D 0
diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/ar=
m/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 74a92c8..b637460 100644
=2D-- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -20,32 +20,32 @@
 /* XXX Using ARE =3D 0x1 (no autorefresh burst) -- can this be changed? */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] =3D {
 	[0] =3D {
=2D		.rate	     =3D 165941176,
=2D		.actim_ctrla =3D 0x629db4c6,
=2D		.actim_ctrlb =3D 0x00012214,
=2D		.rfr_ctrl    =3D 0x0004dc01,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 165941176,
+		.actim_ctrl_a_0	=3D 0x629db4c6,
+		.actim_ctrl_b_0	=3D 0x00012214,
+		.rfr_ctrl_0	=3D 0x0004dc01,
+		.mr_0		=3D 0x00000032,
 	},
 	[1] =3D {
=2D		.rate	     =3D 133333333,
=2D		.actim_ctrla =3D 0x5219b485,
=2D		.actim_ctrlb =3D 0x00012210,
=2D		.rfr_ctrl    =3D 0x0003de01,
=2D		.mr	     =3D 0x00000032,
+		.rate		=3D 133333333,
+		.actim_ctrl_a_0	=3D 0x5219b485,
+		.actim_ctrl_b_0	=3D 0x00012210,
+		.rfr_ctrl_0	=3D 0x0003de01,
+		.mr_0		=3D 0x00000032,
 	},
 	[2] =3D {
=2D		.rate	     =3D 82970588,
=2D		.actim_ctrla =3D 0x31512283,
=2D		.actim_ctrlb =3D 0x0001220a,
=2D		.rfr_ctrl    =3D 0x00025501,
=2D		.mr	     =3D 0x00000022,
+		.rate		=3D 82970588,
+		.actim_ctrl_a_0	=3D 0x31512283,
+		.actim_ctrl_b_0	=3D 0x0001220a,
+		.rfr_ctrl_0	=3D 0x00025501,
+		.mr_0		=3D 0x00000022,
 	},
 	[3] =3D {
=2D		.rate	     =3D 66666666,
=2D		.actim_ctrla =3D 0x290d2243,
=2D		.actim_ctrlb =3D 0x00012208,
=2D		.rfr_ctrl    =3D 0x0001d601,
=2D		.mr	     =3D 0x00000022,
+		.rate		=3D 66666666,
+		.actim_ctrl_a_0	=3D 0x290d2243,
+		.actim_ctrl_b_0	=3D 0x00012208,
+		.rfr_ctrl_0	=3D 0x0001d601,
+		.mr_0		=3D 0x00000022,
 	},
 	[4] =3D {
 		.rate	     =3D 0
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index c832d83..072dcc9 100644
=2D-- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -72,14 +72,19 @@ void omap2_sms_restore_context(void)
  * omap2_sdrc_get_params - return SDRC register values for a given clock r=
ate
  * @r: SDRC clock rate (in Hz)
  *
=2D * Return pre-calculated values for the SDRC_ACTIM_CTRLA,
=2D * SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL, and SDRC_MR registers, for a given
=2D * SDRC clock rate 'r'.  These parameters control various timing
+ * Return pre-calculated values for the SDRC_ACTIM_CTRL_A_[01],
+ * SDRC_ACTIM_CTRL_B_[01], SDRC_RFR_CTRL_[01], and SDRC_MR_[01] registers,
+ * for a given SDRC clock rate 'r'.
+ * These parameters control various timing
  * delays in the SDRAM controller that are expressed in terms of the
  * number of SDRC clock cycles to wait; hence the clock rate
  * dependency. Note that sdrc_init_params must be sorted rate
=2D * descending.  Also assumes that both chip-selects use the same
=2D * timing parameters.  Returns a struct omap_sdrc_params * upon
+ * descending.
+ *
+ * The omap_sdrc_params struct supports different timing parameters
+ * for 2 chip selects.
+ *
+ * Returns a struct omap_sdrc_params * upon
  * success, or NULL upon failure.
  */
 struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index f41f8d9..ccfc008 100644
=2D-- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -36,7 +36,7 @@
=20
 	.text
=20
=2D/* r4 parameters */
+/* r1 parameters */
 #define SDRC_NO_UNLOCK_DLL		0x0
 #define SDRC_UNLOCK_DLL			0x1
=20
@@ -71,40 +71,65 @@
=20
 /*
  * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
=2D * r0 =3D new SDRC_RFR_CTRL register contents
=2D * r1 =3D new SDRC_ACTIM_CTRLA register contents
=2D * r2 =3D new SDRC_ACTIM_CTRLB register contents
=2D * r3 =3D new M2 divider setting (only 1 and 2 supported right now)
=2D * r4 =3D unlock SDRC DLL? (1 =3D yes, 0 =3D no).  Only unlock DLL for
+ *
+ * Params passed in registers:
+ *  r0 =3D new M2 divider setting (only 1 and 2 supported right now)
+ *  r1 =3D unlock SDRC DLL? (1 =3D yes, 0 =3D no).  Only unlock DLL for
  *      SDRC rates < 83MHz
=2D * r5 =3D number of MPU cycles to wait for SDRC to stabilize after
+ *  r2 =3D number of MPU cycles to wait for SDRC to stabilize after
  *      reprogramming the SDRC when switching to a slower MPU speed
=2D * r6 =3D new SDRC_MR_0 register value
=2D * r7 =3D increasing SDRC rate? (1 =3D yes, 0 =3D no)
+ *  r3 =3D increasing SDRC rate? (1 =3D yes, 0 =3D no)
  *
+ * Params passed via the stack. Those will be copied in SRAM before use
+ *  by the code in SRAM (SDRAM is not accessible during SDRC
+ *  reconfiguration):
+ *  new SDRC_RFR_CTRL_0 register contents
+ *  new SDRC_ACTIM_CTRL_A_0 register contents
+ *  new SDRC_ACTIM_CTRL_B_0 register contents
+ *  new SDRC_MR_0 register value
+ *  new SDRC_RFR_CTRL_1 register contents
+ *  new SDRC_ACTIM_CTRL_A_1 register contents
+ *  new SDRC_ACTIM_CTRL_B_1 register contents
+ *  new SDRC_MR_1 register value
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
=2D	ldr	r4, [sp, #52]		@ pull extra args off the stack
=2D	ldr	r5, [sp, #56]		@ load extra args from the stack
=2D	ldr	r6, [sp, #60]		@ load extra args from the stack
=2D	ldr	r7, [sp, #64]		@ load extra args from the stack
+
+					@ pull the extra args off the stack
+					@  and store them in SRAM
+	ldr	r4, [sp, #52]
+	str     r4, omap_sdrc_rfr_ctrl_0_val
+	ldr	r4, [sp, #56]
+	str     r4, omap_sdrc_actim_ctrl_a_0_val
+	ldr	r4, [sp, #60]
+	str     r4, omap_sdrc_actim_ctrl_b_0_val
+	ldr	r4, [sp, #64]
+	str     r4, omap_sdrc_mr_0_val
+	ldr	r4, [sp, #68]
+	str     r4, omap_sdrc_rfr_ctrl_1_val
+	ldr	r4, [sp, #72]
+	str     r4, omap_sdrc_actim_ctrl_a_1_val
+	ldr	r4, [sp, #76]
+	str     r4, omap_sdrc_actim_ctrl_b_1_val
+	ldr	r4, [sp, #80]
+	str     r4, omap_sdrc_mr_1_val
 	dsb				@ flush buffered writes to interconnect
=2D	cmp	r7, #1			@ if increasing SDRC clk rate,
+
+	cmp	r3, #1			@ if increasing SDRC clk rate,
 	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
=2D	cmp	r4, #SDRC_UNLOCK_DLL	@ set the intended DLL state
+	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
 	bleq	unlock_dll
 	blne	lock_dll
 	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
 	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
 	bl	enable_sdrc		@ take SDRC out of idle
=2D	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
+	cmp	r1, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
 	bleq	wait_dll_unlock
 	blne	wait_dll_lock
=2D	cmp	r7, #1			@ if increasing SDRC clk rate,
+	cmp	r3, #1			@ if increasing SDRC clk rate,
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
=2D	mov	r12, r5
+	mov	r12, r2
 	bl	wait_clk_stable		@ wait for SDRC to stabilize
 return_to_sdram:
 	isb				@ prevent speculative exec past here
@@ -149,7 +174,7 @@ configure_core_dpll:
 	ldr	r12, [r11]
 	ldr	r10, core_m2_mask_val	@ modify m2 for core dpll
 	and	r12, r12, r10
=2D	orr	r12, r12, r3, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
+	orr	r12, r12, r0, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
 	str	r12, [r11]
 	ldr	r12, [r11]		@ posted-write barrier for CM
 	bx	lr
@@ -187,15 +212,31 @@ wait_dll_unlock:
 	bne	wait_dll_unlock
 	bx	lr
 configure_sdrc:
=2D	ldr	r11, omap3_sdrc_rfr_ctrl
=2D	str	r0, [r11]
=2D	ldr	r11, omap3_sdrc_actim_ctrla
=2D	str	r1, [r11]
=2D	ldr	r11, omap3_sdrc_actim_ctrlb
=2D	str	r2, [r11]
+	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
+	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
+	str	r12, [r11]			@ store
+	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
+	ldr	r11, omap3_sdrc_actim_ctrl_a_0
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_b_0_val
+	ldr	r11, omap3_sdrc_actim_ctrl_b_0
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_mr_0_val
 	ldr	r11, omap3_sdrc_mr_0
=2D	str	r6, [r11]
=2D	ldr	r6, [r11]		@ posted-write barrier for SDRC
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_rfr_ctrl_1_val
+	ldr	r11, omap3_sdrc_rfr_ctrl_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
+	ldr	r11, omap3_sdrc_actim_ctrl_a_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_b_1_val
+	ldr	r11, omap3_sdrc_actim_ctrl_b_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_mr_1_val
+	ldr	r11, omap3_sdrc_mr_1
+	str	r12, [r11]
+	ldr	r12, [r11]		@ posted-write barrier for SDRC
 	bx	lr
=20
 omap3_sdrc_power:
@@ -206,14 +247,40 @@ omap3_cm_idlest1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
 omap3_cm_iclken1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
=2Domap3_sdrc_rfr_ctrl:
+
+omap3_sdrc_rfr_ctrl_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
=2Domap3_sdrc_actim_ctrla:
+omap3_sdrc_rfr_ctrl_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
+omap3_sdrc_actim_ctrl_a_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
=2Domap3_sdrc_actim_ctrlb:
+omap3_sdrc_actim_ctrl_a_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
+omap3_sdrc_actim_ctrl_b_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_actim_ctrl_b_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
 omap3_sdrc_mr_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
+omap3_sdrc_mr_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
+omap_sdrc_rfr_ctrl_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_rfr_ctrl_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_a_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_a_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_b_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_b_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_mr_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_mr_1_val:
+	.word 0xDEADBEEF
+
 omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
@@ -223,3 +290,4 @@ core_m2_mask_val:
=20
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
+
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/inc=
lude/mach/mux.h
index f7e298a..7368aba 100644
=2D-- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -803,6 +803,10 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+	H16_34XX_SDRC_CKE0,
+	H17_34XX_SDRC_CKE1,
 };
=20
 struct omap_mux_cfg {
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/in=
clude/mach/sdrc.h
index a678bc8..e14204c 100644
=2D-- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -94,22 +94,29 @@
 /**
  * struct omap_sdrc_params - SDRC parameters for a given SDRC clock rate
  * @rate: SDRC clock rate (in Hz)
=2D * @actim_ctrla: Value to program to SDRC_ACTIM_CTRLA for this rate
=2D * @actim_ctrlb: Value to program to SDRC_ACTIM_CTRLB for this rate
=2D * @rfr_ctrl: Value to program to SDRC_RFR_CTRL for this rate
=2D * @mr: Value to program to SDRC_MR for this rate
+ * @actim_ctrl_a_[01]: Value to program to SDRC_ACTIM_CTRL_A_[01] for this=
 rate
+ * @actim_ctrl_b_[01]: Value to program to SDRC_ACTIM_CTRL_B_[01] for this=
 rate
+ * @rfr_ctrl_[01]: Value to program to SDRC_RFR_CTRL_[01] for this rate
+ * @mr_[01]: Value to program to SDRC_MR_[01] for this rate
  *
  * This structure holds a pre-computed set of register values for the
  * SDRC for a given SDRC clock rate and SDRAM chip.  These are
  * intended to be pre-computed and specified in an array in the board-*.c
  * files.  The structure is keyed off the 'rate' field.
+ *
+ * The struct supports up to 2 CSes. The fields *_0 are used for the 1st
+ * CS, the fields *_1 are used for the 2nd one.
  */
 struct omap_sdrc_params {
 	unsigned long rate;
=2D	u32 actim_ctrla;
=2D	u32 actim_ctrlb;
=2D	u32 rfr_ctrl;
=2D	u32 mr;
+	u32 actim_ctrl_a_0;
+	u32 actim_ctrl_b_0;
+	u32 rfr_ctrl_0;
+	u32 mr_0;
+	u32 actim_ctrl_a_1;
+	u32 actim_ctrl_b_1;
+	u32 rfr_ctrl_1;
+	u32 mr_1;
 };
=20
 void omap2_sms_save_context(void);
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/in=
clude/mach/sram.h
index ad0a600..2194b04 100644
=2D-- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -21,11 +21,13 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u=
32 dll_val,
 				      u32 mem_type);
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
=20
=2Dextern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
=2D				     u32 sdrc_actim_ctrla,
=2D				     u32 sdrc_actim_ctrlb, u32 m2,
=2D				     u32 unlock_dll, u32 f, u32 sdrc_mr,
=2D				     u32 inc);
+extern u32 omap3_configure_core_dpll(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+
 extern void omap3_sram_restore_context(void);
=20
 /* Do not use these */
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a2e60e7..517f45b 100644
=2D-- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -368,23 +368,29 @@ static inline int omap243x_sram_init(void)
=20
 #ifdef CONFIG_ARCH_OMAP3
=20
=2Dstatic u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
=2D					      u32 sdrc_actim_ctrla,
=2D					      u32 sdrc_actim_ctrlb,
=2D					      u32 m2, u32 unlock_dll,
=2D					      u32 f, u32 sdrc_mr, u32 inc);
=2Du32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
=2D			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll,
=2D			      u32 f, u32 sdrc_mr, u32 inc)
=2D {
+static u32 (*_omap3_sram_configure_core_dpll)(
+				u32 m2, u32 unlock_dll, u32 f, u32 inc,
+				u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+				u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+				u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+				u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+
+u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			      u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			      u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			      u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			      u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1)
+{
 	if (!_omap3_sram_configure_core_dpll)
 		omap_sram_error();
=20
=2D	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
=2D					       sdrc_actim_ctrla,
=2D					       sdrc_actim_ctrlb, m2,
=2D					       unlock_dll, f, sdrc_mr, inc);
=2D }
+	return _omap3_sram_configure_core_dpll(
+				m2, unlock_dll, f, inc,
+				sdrc_rfr_ctrl_0, sdrc_actim_ctrl_a_0,
+				sdrc_actim_ctrl_b_0, sdrc_mr_0,
+				sdrc_rfr_ctrl_1, sdrc_actim_ctrl_a_1,
+				sdrc_actim_ctrl_b_1, sdrc_mr_1);
+}
=20
 #ifdef CONFIG_PM
 void omap3_sram_restore_context(void)
=2D-=20
1.6.1.2.MVISTA.50.gdf8fd


--Boundary-00=_04+GKjqjDpqIBqT--
