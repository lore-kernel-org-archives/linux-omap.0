From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 6/9] ARM: OMAP2+: gpmc-smsc911x: Adapt to use gpmc driver
Date: Thu, 14 Jun 2012 09:07:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99975F@DBDE01.ent.ti.com>
References: <cover.1339419379.git.afzal@ti.com>
 <fa4fd074305f914d38603443b857422f95680725.1339419379.git.afzal@ti.com>
 <20120614085650.GD12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab2FNJHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:07:54 -0400
In-Reply-To: <20120614085650.GD12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Thu, Jun 14, 2012 at 14:26:52, Tony Lindgren wrote:
> * Afzal Mohammed <afzal@ti.com> [120611 08:20]:
> > +__init gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
> > +{
> > +	int ret;
> > +	struct gpmc_device_pdata *gpmc_pdev;
> > +	struct gpmc_cs_data *gpmc_cs;
> > +
> > +	gpmc_pdev = kzalloc(sizeof(*gpmc_pdev), GFP_KERNEL);
> > +	if (gpmc_pdev == NULL)
> > +		return gpmc_pdev;
> > +
> > +	gpmc_cs = kzalloc(sizeof(*gpmc_cs), GFP_KERNEL);
> > +	if (gpmc_pdev == NULL) {
> > +		kfree(gpmc_pdev);
> > +		return NULL;
> > +	}
> 
> Here your should check for if (!gpmc_cs), not gpmc_cs. Might

My mistake, I will correct it

> Where do gpmc_pdev and gpmc_cs get used? Where are they
> stored to the pdata?

It is done in board file, as in [1]

Regards
Afzal

[1]

ARM: OMAP2+: board omap3evm: use gpmc driver

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 639bd07..aa9429d 100644
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

+static struct gpmc_device_pdata *gpmc_device_data[2];
+
+static struct gpmc_pdata gpmc_data = {
+       .device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>

@@ -122,7 +129,9 @@ static inline void __init omap3evm_init_smsc911x(void)
                        smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
        }

-       gpmc_smsc911x_init(&smsc911x_cfg);
+       *gpmc_device_data = gpmc_smsc911x_update(&smsc911x_cfg);
+       if (!*gpmc_device_data)
+               pr_err("error: unable to initilaize gpmc smsc911x\n");
 }

 #else
@@ -658,6 +667,7 @@ static void __init omap3_evm_init(void)
        usbhs_init(&usbhs_bdata);
        omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
        omap3evm_init_smsc911x();
+       omap_gpmc_init(&gpmc_data);
        omap3_evm_display_init();
        omap3_evm_wl12xx_init();
 }
