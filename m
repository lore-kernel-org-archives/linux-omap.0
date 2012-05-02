From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4-alt 6/6] ARM: OMAP2+: board omap3evm: gpmc driver adaptation
Date: Wed, 2 May 2012 14:16:39 +0530
Message-ID: <cd165db10a6aa14836e2e66c1476a27b84b5cedd.1335941444.git.afzal@ti.com>
References: <cover.1335941443.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40248 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab2EBJDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:03:24 -0400
In-Reply-To: <cover.1335941443.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information

Note: This uses new interface for initializing smsc911x,
old interface should be removed once all boards are
converted to use new interface. So also machine_is_
check in gpmc.c as well as the patch,
"ARM: OMAP2+: gpmc: driver migration hack"

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   14 +++++++++++++-
 arch/arm/mach-omap2/gpmc.c           |    3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index fd1b481..7c83c45 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/gpmc.h>
 #include "common.h"
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
@@ -102,6 +103,12 @@ static void __init omap3_evm_get_revision(void)
 	}
 }
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
 
@@ -122,7 +129,11 @@ static inline void __init omap3evm_init_smsc911x(void)
 			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
 	}
 
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	*gpmc_device_data = gpmc_smsc911x_init_new(&smsc911x_cfg);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -679,6 +690,7 @@ static void __init omap3_evm_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
+	omap_init_gpmc(&gpmc_data);
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
 }
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4dcc141..eb7580d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -875,6 +875,9 @@ static void gpmc_driver_migration(void)
 		.device_pdata	= gpmc_device_data,
 	};
 
+	if (machine_is_omap3evm())
+		return;
+
 	omap_init_gpmc(&gpmc_data);
 }
 
-- 
1.7.10

