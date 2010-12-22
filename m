From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
 into OMAP2/3-specific files
Date: Tue, 21 Dec 2010 20:51:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012212049400.1446@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain> <20101207012516.3708.87606.stgit@twilight.localdomain> <alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com> <AANLkTimTtdMeaz=k6H=GQMNTGciJ5uc+GGUnC1RdR_f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0LVDva (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 22:51:30 -0500
In-Reply-To: <AANLkTimTtdMeaz=k6H=GQMNTGciJ5uc+GGUnC1RdR_f2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hi Felipe

On Wed, 15 Dec 2010, Felipe Contreras wrote:

> I would prefer the XX comments in a separate chunk:
> 
> /*
>  * license notice
>  */
> 
> /*
>  * XXX
>  */
> 
> But otherwise it's ok.

Thanks, I've made that change and added your Ack.  The updated patch 
follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 21 Dec 2010 15:30:55 -0700
Subject: [PATCH] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code into OMAP2/3-specific files

In preparation for adding OMAP4-specific PRCM accessor/mutator
functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specific
files.  Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
OMAP2xxx/3xxx-specific.

This process also requires the #includes in each of these files to be
changed to reference the new file name.  As part of doing so, add some
comments into plat-omap/sram.c and plat-omap/mcbsp.c, which use
"sideways includes", to indicate that these users of the PRM/CM includes
should not be doing so.

Thanks to Felipe Contreras <felipe.contreras@gmail.com> for comments on this
patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
Acked-by: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
Tested-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |   11 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c              |    2 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c          |    2 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c               |    2 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c               |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c     |    2 +-
 arch/arm/mach-omap2/clkt_dpll.c                  |    1 -
 arch/arm/mach-omap2/clock.c                      |    4 +-
 arch/arm/mach-omap2/clock2420_data.c             |    4 +-
 arch/arm/mach-omap2/clock2430.c                  |    2 +-
 arch/arm/mach-omap2/clock2430_data.c             |    4 +-
 arch/arm/mach-omap2/clock34xx.c                  |    2 +-
 arch/arm/mach-omap2/clock3517.c                  |    2 +-
 arch/arm/mach-omap2/clock3xxx.c                  |    4 +-
 arch/arm/mach-omap2/clock3xxx_data.c             |    4 +-
 arch/arm/mach-omap2/clock44xx_data.c             |    6 +-
 arch/arm/mach-omap2/clockdomain.c                |    5 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    4 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +
 arch/arm/mach-omap2/cm-regbits-24xx.h            |    2 -
 arch/arm/mach-omap2/cm-regbits-34xx.h            |    2 -
 arch/arm/mach-omap2/cm-regbits-44xx.h            |    3 -
 arch/arm/mach-omap2/cm.h                         |  134 +--------
 arch/arm/mach-omap2/{cm.c => cm2xxx_3xxx.c}      |   39 ++-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |  131 ++++++++
 arch/arm/mach-omap2/cm44xx.h                     |    1 +
 arch/arm/mach-omap2/cm4xxx.c                     |    2 +-
 arch/arm/mach-omap2/control.c                    |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c                   |    4 +-
 arch/arm/mach-omap2/dsp.c                        |   11 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |    5 +-
 arch/arm/mach-omap2/pm-debug.c                   |    4 +-
 arch/arm/mach-omap2/pm24xx.c                     |    4 +-
 arch/arm/mach-omap2/pm34xx.c                     |    4 +-
 arch/arm/mach-omap2/powerdomain.c                |    3 +
 arch/arm/mach-omap2/powerdomain44xx.c            |    1 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    4 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    4 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |    1 -
 arch/arm/mach-omap2/prcm-common.h                |    6 +
 arch/arm/mach-omap2/prcm.c                       |   88 +-----
 arch/arm/mach-omap2/prm-regbits-24xx.h           |    2 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h           |    8 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h           |    2 -
 arch/arm/mach-omap2/prm.h                        |  352 +--------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |   51 +++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |  367 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h                    |    1 +
 arch/arm/mach-omap2/sdrc.c                       |    2 -
 arch/arm/mach-omap2/sdrc2xxx.c                   |    2 +-
 arch/arm/mach-omap2/serial.c                     |    4 +-
 arch/arm/mach-omap2/sleep34xx.S                  |    4 +-
 arch/arm/mach-omap2/sram242x.S                   |    4 +-
 arch/arm/mach-omap2/sram243x.S                   |    4 +-
 arch/arm/mach-omap2/sram34xx.S                   |    2 +-
 arch/arm/plat-omap/include/plat/common.h         |    2 +
 arch/arm/plat-omap/include/plat/prcm.h           |    7 -
 arch/arm/plat-omap/mcbsp.c                       |    2 +
 arch/arm/plat-omap/sram.c                        |    5 +-
 drivers/staging/tidspbridge/core/_tiomap.h       |    6 +
 60 files changed, 699 insertions(+), 650 deletions(-)
 rename arch/arm/mach-omap2/{cm.c => cm2xxx_3xxx.c} (67%)
 create mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx.h
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2006dee..b2e4f7b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o
 
-omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
+omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
@@ -72,9 +72,12 @@ endif
 endif
 
 # PRCM
-obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm4xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
+# XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
+# will be removed once the OMAP4 part of the codebase is converted to
+# use OMAP4-specific PRCM functions.
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cm4xxx.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index 66e01ac..954d11f 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -26,7 +26,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 01904843..530a76b 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -32,7 +32,7 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 
 /* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index 2167be8..df7b805 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -27,7 +27,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 
 static int omap2_enable_osc_ck(struct clk *clk)
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index 822b5a7..8693cfd 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -26,7 +26,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 
 void __iomem *prcm_clksrc_ctrl;
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index aef6291..f49f47d 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -40,7 +40,7 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 
 const struct prcm_config *curr_prcm_set;
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 6ce512e..337392c 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -24,7 +24,6 @@
 #include <plat/clock.h>
 
 #include "clock.h"
-#include "cm.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b5babf5..cda2f1d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,9 +29,7 @@
 #include <plat/prcm.h>
 
 #include "clock.h"
-#include "prm.h"
-#include "prm-regbits-24xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index ed61ac2..0b2471a 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -22,8 +22,8 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "prm.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index 44d0ccc..d87bc9c 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -25,7 +25,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 
 /**
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 1bded4e..570c26d 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -22,8 +22,8 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
-#include "prm.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6febd5f..287abc4 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -25,7 +25,7 @@
 
 #include "clock.h"
 #include "clock34xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /**
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
index b496a93..74116a3 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -25,7 +25,7 @@
 
 #include "clock.h"
 #include "clock3517.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index a447c4d..81f5fdb 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -25,9 +25,9 @@
 
 #include "clock.h"
 #include "clock3xxx.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ee8aa39..a179edb 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -28,9 +28,9 @@
 #include "clock36xx.h"
 #include "clock3517.h"
 
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 254f341..91ab6f2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -33,11 +33,15 @@
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include "cm-regbits-44xx.h"
-#include "prm.h"
+#include "prm44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
 
+/* OMAP4 modulemode control */
+#define OMAP4430_MODULEMODE_HWCTRL			0
+#define OMAP4430_MODULEMODE_SWCTRL			1
+
 /* Root clocks */
 
 static struct clk extalt_clkin_ck = {
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6fb61b1..a2142e0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -27,9 +27,10 @@
 
 #include <linux/bitops.h>
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 
 #include <plat/clock.h>
 #include <plat/powerdomain.h>
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 8dadf75..de1d3b7 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -36,8 +36,8 @@
 #include <linux/io.h>
 
 #include <plat/clockdomain.h>
-#include "cm.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 #include "cm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index d4a5206..7fc81f6 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -27,6 +27,8 @@
 #include <linux/io.h>
 
 #include <plat/clockdomain.h>
+#include "cm1_44xx.h"
+#include "cm2_44xx.h"
 
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index 9a106c0..0856f2b 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -14,8 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "cm.h"
-
 /* Bits shared between registers */
 
 /* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 4f959a7..cd9ff8b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -14,8 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "cm.h"
-
 /* Bits shared between registers */
 
 /* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
diff --git a/arch/arm/mach-omap2/cm-regbits-44xx.h b/arch/arm/mach-omap2/cm-regbits-44xx.h
index 0b72be4..9d47a05 100644
--- a/arch/arm/mach-omap2/cm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-44xx.h
@@ -22,9 +22,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_REGBITS_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_REGBITS_44XX_H
 
-#include "cm.h"
-
-
 /*
  * Used by CM_L3_1_DYNAMICDEP, CM_L3_1_DYNAMICDEP_RESTORE, CM_MPU_DYNAMICDEP,
  * CM_TESLA_DYNAMICDEP
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index bf21375..a7bc096 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -1,8 +1,5 @@
-#ifndef __ARCH_ASM_MACH_OMAP2_CM_H
-#define __ARCH_ASM_MACH_OMAP2_CM_H
-
 /*
- * OMAP2/3 Clock Management (CM) register definitions
+ * OMAP2+ Clock Management prototypes
  *
  * Copyright (C) 2007-2009 Texas Instruments, Inc.
  * Copyright (C) 2007-2009 Nokia Corporation
@@ -13,133 +10,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#include "prcm-common.h"
-
-#define OMAP2420_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
-#define OMAP2430_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
-#define OMAP34XX_CM_REGADDR(module, reg)				\
-			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
-
-
-#include "cm44xx.h"
-
-/*
- * Architecture-specific global CM registers
- * Use cm_{read,write}_reg() with these registers.
- * These registers appear once per CM module.
- */
-
-#define OMAP3430_CM_REVISION		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP3430_CM_SYSCONFIG		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0010)
-#define OMAP3430_CM_POLCTRL		OMAP34XX_CM_REGADDR(OCP_MOD, 0x009c)
-
-#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
-
-/*
- * Module specific CM registers from CM_BASE + domain offset
- * Use cm_{read,write}_mod_reg() with these registers.
- * These register offsets generally appear in more than one PRCM submodule.
- */
-
-/* Common between 24xx and 34xx */
-
-#define CM_FCLKEN					0x0000
-#define CM_FCLKEN1					CM_FCLKEN
-#define CM_CLKEN					CM_FCLKEN
-#define CM_ICLKEN					0x0010
-#define CM_ICLKEN1					CM_ICLKEN
-#define CM_ICLKEN2					0x0014
-#define CM_ICLKEN3					0x0018
-#define CM_IDLEST					0x0020
-#define CM_IDLEST1					CM_IDLEST
-#define CM_IDLEST2					0x0024
-#define CM_AUTOIDLE					0x0030
-#define CM_AUTOIDLE1					CM_AUTOIDLE
-#define CM_AUTOIDLE2					0x0034
-#define CM_AUTOIDLE3					0x0038
-#define CM_CLKSEL					0x0040
-#define CM_CLKSEL1					CM_CLKSEL
-#define CM_CLKSEL2					0x0044
-#define OMAP2_CM_CLKSTCTRL				0x0048
-#define OMAP4_CM_CLKSTCTRL				0x0000
-
-
-/* Architecture-specific registers */
-
-#define OMAP24XX_CM_FCLKEN2				0x0004
-#define OMAP24XX_CM_ICLKEN4				0x001c
-#define OMAP24XX_CM_AUTOIDLE4				0x003c
-
-#define OMAP2430_CM_IDLEST3				0x0028
-
-#define OMAP3430_CM_CLKEN_PLL				0x0004
-#define OMAP3430ES2_CM_CLKEN2				0x0004
-#define OMAP3430ES2_CM_FCLKEN3				0x0008
-#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
-#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
-#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
-#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
-#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
-#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
-#define OMAP3430_CM_CLKSTST				0x004c
-#define OMAP3430ES2_CM_CLKSEL4				0x004c
-#define OMAP3430ES2_CM_CLKSEL5				0x0050
-#define OMAP3430_CM_CLKSEL2_EMU				0x0050
-#define OMAP3430_CM_CLKSEL3_EMU				0x0054
-
-/* CM2.CEFUSE_CM2 register offsets */
-
-/* OMAP4 modulemode control */
-#define OMAP4430_MODULEMODE_HWCTRL			0
-#define OMAP4430_MODULEMODE_SWCTRL			1
-
-/* Clock management domain register get/set */
-
-#ifndef __ASSEMBLER__
-
-extern u32 cm_read_mod_reg(s16 module, u16 idx);
-extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-
-extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-				      u8 idlest_shift);
-extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
-
-static inline u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
-#endif
-
-/* CM register bits shared between 24XX and 3430 */
-
-/* CM_CLKSEL_GFX */
-#define OMAP_CLKSEL_GFX_SHIFT				0
-#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
-
-/* CM_ICLKEN_GFX */
-#define OMAP_EN_GFX_SHIFT				0
-#define OMAP_EN_GFX_MASK				(1 << 0)
-
-/* CM_IDLEST_GFX */
-#define OMAP_ST_GFX_MASK				(1 << 0)
-
-
-/* CM_IDLEST indicator */
-#define OMAP24XX_CM_IDLEST_VAL		0
-#define OMAP34XX_CM_IDLEST_VAL		1
+#ifndef __ARCH_ASM_MACH_OMAP2_CM_H
+#define __ARCH_ASM_MACH_OMAP2_CM_H
 
 /*
  * MAX_MODULE_READY_TIME: max duration in microseconds to wait for the
diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
similarity index 67%
rename from arch/arm/mach-omap2/cm.c
rename to arch/arm/mach-omap2/cm2xxx_3xxx.c
index 721c3b6..5978ce4 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
@@ -19,11 +18,10 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <asm/atomic.h>
-
 #include <plat/common.h>
 
 #include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
@@ -31,6 +29,40 @@ static const u8 cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
 };
 
+
+u32 cm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(cm_base + module + idx);
+}
+
+void cm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__raw_writel(val, cm_base + module + idx);
+}
+
+/* Read-modify-write a register in a CM module. Caller must lock */
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	cm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+
 /**
  * omap2_cm_wait_idlest_ready - wait for a module to leave idle or standby
  * @prcm_mod: PRCM module offset
@@ -59,7 +91,6 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	else
 		BUG();
 
-	/* XXX should be OMAP2 CM */
 	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
 			  MAX_MODULE_READY_TIME, i);
 
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
new file mode 100644
index 0000000..5e57211
--- /dev/null
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -0,0 +1,131 @@
+/*
+ * OMAP2/3 Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The CM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The CM modules/instances on OMAP4 are quite different, so
+ * they are handled in a separate file.
+ */
+#ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
+#define __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
+
+#include "prcm-common.h"
+
+#define OMAP2420_CM_REGADDR(module, reg)				\
+			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+#define OMAP2430_CM_REGADDR(module, reg)				\
+			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+#define OMAP34XX_CM_REGADDR(module, reg)				\
+			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+
+
+/*
+ * OMAP3-specific global CM registers
+ * Use cm_{read,write}_reg() with these registers.
+ * These registers appear once per CM module.
+ */
+
+#define OMAP3430_CM_REVISION		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP3430_CM_SYSCONFIG		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0010)
+#define OMAP3430_CM_POLCTRL		OMAP34XX_CM_REGADDR(OCP_MOD, 0x009c)
+
+#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+
+/*
+ * Module specific CM register offsets from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* Common between OMAP2 and OMAP3 */
+
+#define CM_FCLKEN					0x0000
+#define CM_FCLKEN1					CM_FCLKEN
+#define CM_CLKEN					CM_FCLKEN
+#define CM_ICLKEN					0x0010
+#define CM_ICLKEN1					CM_ICLKEN
+#define CM_ICLKEN2					0x0014
+#define CM_ICLKEN3					0x0018
+#define CM_IDLEST					0x0020
+#define CM_IDLEST1					CM_IDLEST
+#define CM_IDLEST2					0x0024
+#define CM_AUTOIDLE					0x0030
+#define CM_AUTOIDLE1					CM_AUTOIDLE
+#define CM_AUTOIDLE2					0x0034
+#define CM_AUTOIDLE3					0x0038
+#define CM_CLKSEL					0x0040
+#define CM_CLKSEL1					CM_CLKSEL
+#define CM_CLKSEL2					0x0044
+#define OMAP2_CM_CLKSTCTRL				0x0048
+
+/* OMAP2-specific register offsets */
+
+#define OMAP24XX_CM_FCLKEN2				0x0004
+#define OMAP24XX_CM_ICLKEN4				0x001c
+#define OMAP24XX_CM_AUTOIDLE4				0x003c
+
+#define OMAP2430_CM_IDLEST3				0x0028
+
+/* OMAP3-specific register offsets */
+
+#define OMAP3430_CM_CLKEN_PLL				0x0004
+#define OMAP3430ES2_CM_CLKEN2				0x0004
+#define OMAP3430ES2_CM_FCLKEN3				0x0008
+#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
+#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
+#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
+#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
+#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
+#define OMAP3430_CM_CLKSTST				0x004c
+#define OMAP3430ES2_CM_CLKSEL4				0x004c
+#define OMAP3430ES2_CM_CLKSEL5				0x0050
+#define OMAP3430_CM_CLKSEL2_EMU				0x0050
+#define OMAP3430_CM_CLKSEL3_EMU				0x0054
+
+
+/* CM_IDLEST bit field values to indicate deasserted IdleReq */
+
+#define OMAP24XX_CM_IDLEST_VAL				0
+#define OMAP34XX_CM_IDLEST_VAL				1
+
+
+/* Clock management domain register get/set */
+
+#ifndef __ASSEMBLER__
+
+extern u32 cm_read_mod_reg(s16 module, u16 idx);
+extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
+extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+				      u8 idlest_shift);
+extern u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
+
+#endif
+
+/* CM register bits shared between 24XX and 3430 */
+
+/* CM_CLKSEL_GFX */
+#define OMAP_CLKSEL_GFX_SHIFT				0
+#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
+
+/* CM_ICLKEN_GFX */
+#define OMAP_EN_GFX_SHIFT				0
+#define OMAP_EN_GFX_MASK				(1 << 0)
+
+/* CM_IDLEST_GFX */
+#define OMAP_ST_GFX_MASK				(1 << 0)
+
+#endif
diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index d390526..48fc3f4 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -18,6 +18,7 @@
 
 
 #include "prcm-common.h"
+#include "cm.h"
 
 #define OMAP4_CM_CLKSTCTRL				0x0000
 
diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
index f8a660a..25d2b3e 100644
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -23,7 +23,7 @@
 
 #include <plat/common.h>
 
-#include "cm.h"
+#include "cm44xx.h"
 #include "cm-regbits-44xx.h"
 
 /**
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index b066c6e..2506edf 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -20,8 +20,8 @@
 
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
-#include "cm.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 #include "sdrc.h"
 #include "pm.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index ed8d330..cb535ee 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -32,9 +32,7 @@
 #include <asm/clkdev.h>
 
 #include "clock.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 6feeeae..cf5f333 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -11,9 +11,16 @@
  * published by the Free Software Foundation.
  */
 
+/*
+ * XXX The function pointers to the PRM/CM functions are incorrect and
+ * should be removed.  No device driver should be changing PRM/CM bits
+ * directly; that's a layering violation -- those bits are the responsibility
+ * of the OMAP PM core code.
+ */
+
 #include <linux/platform_device.h>
-#include "prm.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "prm2xxx_3xxx.h"
 #ifdef CONFIG_BRIDGE_DVFS
 #include <plat/omap-pm.h>
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2b660e5..1312ce2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -145,8 +145,9 @@
 #include <plat/omap_hwmod.h>
 #include <plat/prcm.h>
 
-#include "cm.h"
-#include "prm.h"
+#include "cm2xxx_3xxx.h"
+#include "cm44xx.h"
+#include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a8afb61..1f5d68b 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -33,8 +33,8 @@
 #include <plat/clockdomain.h>
 #include <plat/dmtimer.h>
 
-#include "prm.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "prm2xxx_3xxx.h"
 #include "pm.h"
 
 int omap2_pm_debug;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index aea7ced..8ea49dc 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -42,9 +42,9 @@
 #include <plat/dma.h>
 #include <plat/board.h>
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c45b4fa..7e500d8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -41,11 +41,11 @@
 
 #include <asm/tlbflush.h>
 
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 77f42b9..8a0dcd0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -19,6 +19,9 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include "cm2xxx_3xxx.h"
+#include "cm44xx.h"
+#include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 7efdf68..dae767b 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -18,6 +18,7 @@
 
 #include <plat/powerdomain.h>
 #include <plat/prcm.h>
+#include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "powerdomains.h"
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index adc85d3..e136895 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -19,10 +19,8 @@
 #include "powerdomains.h"
 
 #include "prcm-common.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
-#include "cm.h"
-#include "cm-regbits-24xx.h"
 
 /* 24XX powerdomains and dependencies */
 
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 1ddc040..1830c63 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -19,9 +19,9 @@
 #include "powerdomains.h"
 
 #include "prcm-common.h"
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index cf6adfc..069a21d 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -26,7 +26,6 @@
 #include "powerdomains.h"
 
 #include "prcm-common.h"
-#include "prm.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 427ab61..87486f5 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -396,5 +396,11 @@
  */
 #define MAX_MODULE_HARDRESET_WAIT		10000
 
+# ifndef __ASSEMBLER__
+extern void __iomem *prm_base;
+extern void __iomem *cm_base;
+extern void __iomem *cm2_base;
+# endif
+
 #endif
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index aac8070..171c710 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -29,16 +29,17 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm.h"
-#include "prm.h"
+#include "cm2xxx_3xxx.h"
+#include "cm44xx.h"
+#include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
 
-static void __iomem *prm_base;
-static void __iomem *cm_base;
-static void __iomem *cm2_base;
+void __iomem *prm_base;
+void __iomem *cm_base;
+void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
@@ -158,56 +159,6 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 				     prcm_offs, OMAP4_RM_RSTCTRL);
 }
 
-static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
-{
-	BUG_ON(!base);
-	return __raw_readl(base + module + reg);
-}
-
-static inline void __omap_prcm_write(u32 value, void __iomem *base,
-						s16 module, u16 reg)
-{
-	BUG_ON(!base);
-	__raw_writel(value, base + module + reg);
-}
-
-/* Read a register in a PRM module */
-u32 prm_read_mod_reg(s16 module, u16 idx)
-{
-	return __omap_prcm_read(prm_base, module, idx);
-}
-
-/* Write into a register in a PRM module */
-void prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__omap_prcm_write(val, prm_base, module, idx);
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
-{
-	u32 v;
-
-	v = prm_read_mod_reg(module, idx);
-	v &= ~mask;
-	v |= bits;
-	prm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = prm_read_mod_reg(domain, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
 /* Read a PRM register, AND it, and shift the result down to bit 0 */
 u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
 {
@@ -232,30 +183,6 @@ u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
 
 	return v;
 }
-/* Read a register in a CM module */
-u32 cm_read_mod_reg(s16 module, u16 idx)
-{
-	return __omap_prcm_read(cm_base, module, idx);
-}
-
-/* Write into a register in a CM module */
-void cm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__omap_prcm_write(val, cm_base, module, idx);
-}
-
-/* Read-modify-write a register in a CM module. Caller must lock */
-u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
-{
-	u32 v;
-
-	v = cm_read_mod_reg(module, idx);
-	v &= ~mask;
-	v |= bits;
-	cm_write_mod_reg(v, module, idx);
-
-	return v;
-}
 
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
@@ -266,6 +193,9 @@ u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
  *
  * Returns 1 if the module indicated readiness in time, or 0 if it
  * failed to enable in roughly MAX_MODULE_ENABLE_WAIT microseconds.
+ *
+ * XXX This function is deprecated.  It should be removed once the
+ * hwmod conversion is complete.
  */
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 				const char *name)
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
index 0b188ff..6ac9661 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -14,7 +14,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 
 /* Bits shared between registers */
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index ec1a710..64c087a 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -1,6 +1,3 @@
-#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
-#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
-
 /*
  * OMAP3430 Power/Reset Management register bits
  *
@@ -13,8 +10,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
+
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 
 /* Shared register bits */
 
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 25b19b6..6d2776f 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -22,8 +22,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
 
-#include "prm.h"
-
 
 /*
  * Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_IVA_SETUP,
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 10a24ca..39d5621 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -1,304 +1,20 @@
-#ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
-#define __ARCH_ARM_MACH_OMAP2_PRM_H
-
 /*
- * OMAP2/3 Power/Reset Management (PRM) register definitions
+ * OMAP2/3/4 Power/Reset Management (PRM) bitfield definitions
  *
  * Copyright (C) 2007-2009 Texas Instruments, Inc.
  * Copyright (C) 2010 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_H
 
 #include "prcm-common.h"
 
-#define OMAP2420_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
-#define OMAP2430_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
-#define OMAP34XX_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
-
-/*
- * Architecture-specific global PRM registers
- * Use __raw_{read,write}l() with these registers.
- *
- * With a few exceptions, these are the register names beginning with
- * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
- * IRQSTATUS and IRQENABLE bits.)
- *
- */
-
-#define OMAP2_PRCM_REVISION_OFFSET	0x0000
-#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
-#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
-
-#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
-#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0018)
-#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
-#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
-
-#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
-#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
-#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
-#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
-#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
-#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
-#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
-#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0078)
-#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
-#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
-#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
-#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
-#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
-#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
-#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
-#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
-#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
-
-#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
-
-#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0018)
-#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x001c)
-
-#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
-#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060)
-#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070)
-#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0078)
-#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080)
-#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0084)
-#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
-#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
-
-#define OMAP3_PRM_REVISION_OFFSET	0x0004
-#define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
-#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
-#define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
-
-#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
-#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0018)
-#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
-#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001c)
-
-
-#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
-#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
-#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
-#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
-#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
-#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
-#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
-#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
-#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
-#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
-#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
-#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
-#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
-#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
-#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
-#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
-#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
-#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
-#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
-#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
-#define OMAP3_PRM_RSTST_OFFSET	0x0058
-#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
-#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
-#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
-#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
-#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
-#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
-#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
-#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
-#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
-#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
-#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
-#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
-#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
-#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
-#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
-#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
-#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
-#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
-#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
-#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
-#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
-#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
-#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
-#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
-#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
-#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
-#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
-#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
-#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
-#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
-#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
-#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
-#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
-#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
-#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
-#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
-#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
-#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
-#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
-#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
-#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
-
-#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
-#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
-#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
-
-/*
- * Module specific PRM registers from PRM_BASE + domain offset
- *
- * Use prm_{read,write}_mod_reg() with these registers.
- *
- * With a few exceptions, these are the register names beginning with
- * {PM,RM}_* on both architectures.  (The exceptions are the IRQSTATUS
- * and IRQENABLE bits.)
- *
- */
-
-/* Registers appearing on both 24xx and 34xx */
-
-#define OMAP2_RM_RSTCTRL				0x0050
-#define OMAP2_RM_RSTTIME				0x0054
-#define OMAP2_RM_RSTST					0x0058
-#define OMAP2_PM_PWSTCTRL				0x00e0
-#define OMAP2_PM_PWSTST					0x00e4
-
-#define PM_WKEN						0x00a0
-#define PM_WKEN1					PM_WKEN
-#define PM_WKST						0x00b0
-#define PM_WKST1					PM_WKST
-#define PM_WKDEP					0x00c8
-#define PM_EVGENCTRL					0x00d4
-#define PM_EVGENONTIM					0x00d8
-#define PM_EVGENOFFTIM					0x00dc
-
-/* Omap2 specific registers */
-#define OMAP24XX_PM_WKEN2				0x00a4
-#define OMAP24XX_PM_WKST2				0x00b4
-
-#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
-#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
-#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
-#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
-
-/* Omap3 specific registers */
-#define OMAP3430ES2_PM_WKEN3				0x00f0
-#define OMAP3430ES2_PM_WKST3				0x00b8
-
-#define OMAP3430_PM_MPUGRPSEL				0x00a4
-#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
-#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
-
-#define OMAP3430_PM_IVAGRPSEL				0x00a8
-#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
-#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
-
-#define OMAP3430_PM_PREPWSTST				0x00e8
-
-#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
-#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
-
-
-#ifndef __ASSEMBLER__
-
-/* Power/reset management domain register get/set */
-extern u32 prm_read_mod_reg(s16 module, u16 idx);
-extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-
-/* Read-modify-write bits in a PRM register (by domain) */
-static inline u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
-/* These omap2_ PRM functions apply to both OMAP2 and 3 */
-int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
-int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
-int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
-
-#endif
-
-/*
- * Bits common to specific registers
- *
- * The 3430 register and bit names are generally used,
- * since they tend to make more sense
- */
-
-/* PM_EVGENONTIM_MPU */
-/* Named PM_EVEGENONTIM_MPU on the 24XX */
-#define OMAP_ONTIMEVAL_SHIFT				0
-#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
-
-/* PM_EVGENOFFTIM_MPU */
-/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
-#define OMAP_OFFTIMEVAL_SHIFT				0
-#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
-
-/* PRM_CLKSETUP and PRCM_VOLTSETUP */
-/* Named PRCM_CLKSSETUP on the 24XX */
-#define OMAP_SETUP_TIME_SHIFT				0
-#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
-
-/* PRM_CLKSRC_CTRL */
-/* Named PRCM_CLKSRC_CTRL on the 24XX */
-#define OMAP_SYSCLKDIV_SHIFT				6
-#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
-#define OMAP_AUTOEXTCLKMODE_SHIFT			3
-#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
-#define OMAP_SYSCLKSEL_SHIFT				0
-#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
-
-/* PM_EVGENCTRL_MPU */
-#define OMAP_OFFLOADMODE_SHIFT				3
-#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
-#define OMAP_ONLOADMODE_SHIFT				1
-#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
-#define OMAP_ENABLE_MASK				(1 << 0)
-
-/* PRM_RSTTIME */
-/* Named RM_RSTTIME_WKUP on the 24xx */
-#define OMAP_RSTTIME2_SHIFT				8
-#define OMAP_RSTTIME2_MASK				(0x1f << 8)
-#define OMAP_RSTTIME1_SHIFT				0
-#define OMAP_RSTTIME1_MASK				(0xff << 0)
-
-/* PRM_RSTCTRL */
-/* Named RM_RSTCTRL_WKUP on the 24xx */
-/* 2420 calls RST_DPLL3 'RST_DPLL' */
-#define OMAP_RST_DPLL3_MASK				(1 << 2)
-#define OMAP_RST_GS_MASK				(1 << 1)
-
-
-/*
- * Bits common to module-shared registers
- *
- * Not all registers of a particular type support all of these bits -
- * check TRM if you are unsure
- */
-
 /*
  * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
  *
@@ -324,59 +40,6 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
 #define OMAP_POWERSTATEST_MASK				(0x3 << 0)
 
 /*
- * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
- *	 called 'COREWKUP_RST'
- *
- * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
- *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
- */
-#define OMAP_COREDOMAINWKUP_RST_MASK			(1 << 3)
-
-/*
- * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
- *
- * 2430: RM_RSTST_MDM
- *
- * 3430: RM_RSTST_CORE, RM_RSTST_EMU
- */
-#define OMAP_DOMAINWKUP_RST_MASK			(1 << 2)
-
-/*
- * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
- *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
- *
- * 2430: RM_RSTST_MDM
- *
- * 3430: RM_RSTST_CORE, RM_RSTST_EMU
- */
-#define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
-#define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
-
-/*
- * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
- *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
- *
- * 2430: PM_WKDEP_MDM
- *
- * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
- *	 PM_WKDEP_PER
- */
-#define OMAP_EN_WKUP_SHIFT				4
-#define OMAP_EN_WKUP_MASK				(1 << 4)
-
-/*
- * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
- *	 PM_PWSTCTRL_DSP
- *
- * 2430: PM_PWSTCTRL_MDM
- *
- * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
- *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
- *	 PM_PWSTCTRL_NEON
- */
-#define OMAP_LOGICRETSTATE_MASK				(1 << 2)
-
-/*
  * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
  *       PM_PWSTCTRL_DSP, PM_PWSTST_MPU
  *
@@ -390,11 +53,4 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
 #define OMAP_POWERSTATE_MASK				(0x3 << 0)
 
 
-/*
- * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
- * submodule to exit hardreset
- */
-#define MAX_MODULE_HARDRESET_WAIT		10000
-
-
 #endif
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 421771e..064b52a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -12,18 +12,65 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/io.h>
 
 #include <plat/common.h>
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
 
+u32 prm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(prm_base + module + idx);
+}
+
+void prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__raw_writel(val, prm_base + module + idx);
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+
+
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
  * submodules contained in the hwmod module
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
new file mode 100644
index 0000000..ab28517
--- /dev/null
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -0,0 +1,367 @@
+/*
+ * OMAP2/3 Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The PRM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The PRM on OMAP4 has a new register layout, and is handled
+ * in a separate file.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_H
+
+#include "prcm-common.h"
+#include "prm.h"
+
+#define OMAP2420_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+#define OMAP2430_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+#define OMAP34XX_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+
+
+/*
+ * OMAP2-specific global PRM registers
+ * Use __raw_{read,write}l() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRCM_* on 24xx.  (The exceptions are the IRQSTATUS and IRQENABLE
+ * bits.)
+ *
+ */
+
+#define OMAP2_PRCM_REVISION_OFFSET	0x0000
+#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
+#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
+#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
+#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
+#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
+#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
+#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
+#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
+#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
+#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
+#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
+
+#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
+
+/*
+ * OMAP3-specific global PRM registers
+ * Use __raw_{read,write}l() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRM_* on 34xx.  (The exceptions are the IRQSTATUS and IRQENABLE
+ * bits.)
+ */
+
+#define OMAP3_PRM_REVISION_OFFSET	0x0004
+#define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
+#define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001c)
+
+
+#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
+#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
+#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
+#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
+#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
+#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
+#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
+#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
+#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
+#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
+#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
+#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
+#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
+#define OMAP3_PRM_RSTST_OFFSET	0x0058
+#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
+#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
+#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
+#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
+#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
+#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
+#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
+#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
+#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
+#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
+#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
+#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
+#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
+#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
+#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
+#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
+#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
+#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
+#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
+#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
+#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
+#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
+#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
+#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
+#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
+#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
+#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
+#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
+#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+
+#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
+#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
+#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+
+/*
+ * Module specific PRM register offsets from PRM_BASE + domain offset
+ *
+ * Use prm_{read,write}_mod_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * {PM,RM}_* on both OMAP2/3 SoC families..  (The exceptions are the
+ * IRQSTATUS and IRQENABLE bits.)
+ */
+
+/* Register offsets appearing on both OMAP2 and OMAP3 */
+
+#define OMAP2_RM_RSTCTRL				0x0050
+#define OMAP2_RM_RSTTIME				0x0054
+#define OMAP2_RM_RSTST					0x0058
+#define OMAP2_PM_PWSTCTRL				0x00e0
+#define OMAP2_PM_PWSTST					0x00e4
+
+#define PM_WKEN						0x00a0
+#define PM_WKEN1					PM_WKEN
+#define PM_WKST						0x00b0
+#define PM_WKST1					PM_WKST
+#define PM_WKDEP					0x00c8
+#define PM_EVGENCTRL					0x00d4
+#define PM_EVGENONTIM					0x00d8
+#define PM_EVGENOFFTIM					0x00dc
+
+/* OMAP2xxx specific register offsets */
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+/* OMAP3 specific register offsets */
+#define OMAP3430ES2_PM_WKEN3				0x00f0
+#define OMAP3430ES2_PM_WKST3				0x00b8
+
+#define OMAP3430_PM_MPUGRPSEL				0x00a4
+#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
+
+#define OMAP3430_PM_IVAGRPSEL				0x00a8
+#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
+
+#define OMAP3430_PM_PREPWSTST				0x00e8
+
+#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
+#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
+
+
+#ifndef __ASSEMBLER__
+
+/* Power/reset management domain register get/set */
+extern u32 prm_read_mod_reg(s16 module, u16 idx);
+extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+extern u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+
+/* These omap2_ PRM functions apply to both OMAP2 and 3 */
+extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
+extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
+extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
+
+#endif
+
+/*
+ * Bits common to specific registers
+ *
+ * The 3430 register and bit names are generally used,
+ * since they tend to make more sense
+ */
+
+/* PM_EVGENONTIM_MPU */
+/* Named PM_EVEGENONTIM_MPU on the 24XX */
+#define OMAP_ONTIMEVAL_SHIFT				0
+#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PM_EVGENOFFTIM_MPU */
+/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
+#define OMAP_OFFTIMEVAL_SHIFT				0
+#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PRM_CLKSETUP and PRCM_VOLTSETUP */
+/* Named PRCM_CLKSSETUP on the 24XX */
+#define OMAP_SETUP_TIME_SHIFT				0
+#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
+
+/* PRM_CLKSRC_CTRL */
+/* Named PRCM_CLKSRC_CTRL on the 24XX */
+#define OMAP_SYSCLKDIV_SHIFT				6
+#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
+#define OMAP_AUTOEXTCLKMODE_SHIFT			3
+#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
+#define OMAP_SYSCLKSEL_SHIFT				0
+#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
+
+/* PM_EVGENCTRL_MPU */
+#define OMAP_OFFLOADMODE_SHIFT				3
+#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
+#define OMAP_ONLOADMODE_SHIFT				1
+#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
+#define OMAP_ENABLE_MASK				(1 << 0)
+
+/* PRM_RSTTIME */
+/* Named RM_RSTTIME_WKUP on the 24xx */
+#define OMAP_RSTTIME2_SHIFT				8
+#define OMAP_RSTTIME2_MASK				(0x1f << 8)
+#define OMAP_RSTTIME1_SHIFT				0
+#define OMAP_RSTTIME1_MASK				(0xff << 0)
+
+/* PRM_RSTCTRL */
+/* Named RM_RSTCTRL_WKUP on the 24xx */
+/* 2420 calls RST_DPLL3 'RST_DPLL' */
+#define OMAP_RST_DPLL3_MASK				(1 << 2)
+#define OMAP_RST_GS_MASK				(1 << 1)
+
+
+/*
+ * Bits common to module-shared registers
+ *
+ * Not all registers of a particular type support all of these bits -
+ * check TRM if you are unsure
+ */
+
+/*
+ * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
+ *	 called 'COREWKUP_RST'
+ *
+ * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
+ *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
+ */
+#define OMAP_COREDOMAINWKUP_RST_MASK			(1 << 3)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_DOMAINWKUP_RST_MASK			(1 << 2)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
+ *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
+#define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
+
+/*
+ * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
+ *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
+ *
+ * 2430: PM_WKDEP_MDM
+ *
+ * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
+ *	 PM_WKDEP_PER
+ */
+#define OMAP_EN_WKUP_SHIFT				4
+#define OMAP_EN_WKUP_MASK				(1 << 4)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSP
+ *
+ * 2430: PM_PWSTCTRL_MDM
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON
+ */
+#define OMAP_LOGICRETSTATE_MASK				(1 << 2)
+
+
+/*
+ * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
+ * submodule to exit hardreset
+ */
+#define MAX_MODULE_HARDRESET_WAIT		10000
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 0d444a5..3d36149 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -26,6 +26,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM44XX_H
 
 #include "prcm-common.h"
+#include "prm.h"
 
 #define OMAP4430_PRM_BASE		0x4a306000
 
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 4c65f56..da6f3a6 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -27,8 +27,6 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 
-#include "prm.h"
-
 #include <plat/sdrc.h>
 #include "sdrc.h"
 
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 0f4d27a..64778b6 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -28,7 +28,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "clock.h"
 #include <plat/sdrc.h>
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0548bbd..26770d8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -40,9 +40,9 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-#include "prm.h"
+#include "prm2xxx_3xxx.h"
 #include "pm.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index e3b5cd7..98d8232 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -27,8 +27,8 @@
 #include <plat/sram.h>
 #include <mach/io.h>
 
-#include "cm.h"
-#include "prm.h"
+#include "cm2xxx_3xxx.h"
+#include "prm2xxx_3xxx.h"
 #include "sdrc.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 92e6e1a..8e7e6fe 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -27,8 +27,8 @@
 #include <mach/io.h>
 #include <mach/hardware.h>
 
-#include "prm.h"
-#include "cm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 #include "sdrc.h"
 
 	.text
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index ab49736..9ea87f6 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -27,8 +27,8 @@
 #include <mach/io.h>
 #include <mach/hardware.h>
 
-#include "prm.h"
-#include "cm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
 #include "sdrc.h"
 
 	.text
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 3637274..b7aba60 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -32,7 +32,7 @@
 #include <mach/io.h>
 
 #include "sdrc.h"
-#include "cm.h"
+#include "cm2xxx_3xxx.h"
 
 	.text
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index a9d69a0..6b8088e 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -27,6 +27,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
+#include <linux/delay.h>
+
 #include <plat/i2c.h>
 
 struct sys_timer;
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index ab77442..3769fc6 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -34,15 +34,8 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 void omap3_prcm_save_context(void);
 void omap3_prcm_restore_context(void);
 
-u32 prm_read_mod_reg(s16 module, u16 idx);
-void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
 u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
-u32 cm_read_mod_reg(s16 module, u16 idx);
-void cm_write_mod_reg(u32 val, s16 module, u16 idx);
-u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
 #endif
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index fdecd33..95449b9 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -28,6 +28,8 @@
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 
+/* XXX These "sideways" includes are a sign that something is wrong */
+#include "../mach-omap2/cm2xxx_3xxx.h"
 #include "../mach-omap2/cm-regbits-34xx.h"
 
 struct omap_mcbsp **mcbsp_ptr;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 1a686c8..e26e504 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -33,9 +33,10 @@
 
 #include "sram.h"
 #include "fb.h"
+
+/* XXX These "sideways" includes are a sign that something is wrong */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-# include "../mach-omap2/prm.h"
-# include "../mach-omap2/cm.h"
+# include "../mach-omap2/prm2xxx_3xxx.h"
 # include "../mach-omap2/sdrc.h"
 #endif
 
diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
index 1c1f157..7fac488 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -21,6 +21,12 @@
 
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+/*
+ * XXX These mach-omap2/ includes are wrong and should be removed.  No
+ * driver should read or write to PRM/CM registers directly; they
+ * should rely on OMAP core code to do this.
+ */
+#include <mach-omap2/cm2xxx_3xxx.h>
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
 #include <dspbridge/devdefs.h>
-- 
1.7.2.3

