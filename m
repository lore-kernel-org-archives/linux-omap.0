From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] PM: Enable DVFS for Zoom2
Date: Fri, 31 Jul 2009 10:55:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5850808@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305F29A04@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbZGaFZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 01:25:47 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6V5Pfnt006119
	for <linux-omap@vger.kernel.org>; Fri, 31 Jul 2009 00:25:47 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n6V5PffP015320
	for <linux-omap@vger.kernel.org>; Fri, 31 Jul 2009 10:55:41 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305F29A04@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

NAK

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Reddy,
>Teerth
>Sent: Thursday, July 30, 2009 8:02 AM
>To: linux-omap@vger.kernel.org
>Subject: [PATCH] PM: Enable DVFS for Zoom2
>
>From: Teerth Reddy <teerth@ti.com>
>
>This patch enables DVFS for Zoom2 and initializes the SDRC params and
>OPP tables.

You seem to have based the patch of 2.6.29 kernel.
The number of parameters of omap2_init_common_hw() is different

Any upstream patches should be done of latest k.org or l-o

In this particular case, 
I maintain the Zoom2 support on my git tree at [1] on zoom2 head.
This is to make easy for Tony to pull zoom2 patches when he is back.
You can base your dvfs patch of that branch and I will put it in my tree.

Regards,
Vikram 

[1]
http://dev.omapzoom.org/?p=vikram/omap3.git;a=summary


>
>Signed-off-by: Teerth Reddy <teerth@ti.com>
>---
> arch/arm/mach-omap2/board-zoom2.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
>index 5742b55..f29c476 100644
>--- a/arch/arm/mach-omap2/board-zoom2.c
>+++ b/arch/arm/mach-omap2/board-zoom2.c
>@@ -28,6 +28,7 @@
>
> #include "mmc-twl4030.h"
> #include "omap3-opp.h"
>+#include "sdram-micron-mt46h32m32lf-6.h"
>
> #define ZOOM2_QUART_PHYS        0x10000000
> #define ZOOM2_QUART_VIRT        0xFB000000
>@@ -109,7 +110,7 @@ static void __init omap_zoom2_init_irq(void)
> {
> 	omap_board_config = zoom2_config;
> 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
>-	omap2_init_common_hw(NULL, omap3_mpu_rate_table,
>+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> 	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> 	omap_init_irq();
> 	omap_gpio_init();
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

