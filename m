From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 12/11] ARM: OMAP: Fix relative includes for fpga.h
Date: Mon, 12 Nov 2012 11:47:34 +0100
Message-ID: <50A0D3C6.4070206@ti.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local> <20121031215252.GB15766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33448 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2KLKrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 05:47:47 -0500
In-Reply-To: <20121031215252.GB15766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

After rebasing on top of your omap-for-v3.8/tmp-merge, I realized that this patch is generating a build break due to removal of the fpga.h include from debug-leds.c.

arch/arm/plat-omap/debug-leds.c: In function 'fpga_probe':
arch/arm/plat-omap/debug-leds.c:114:9: error: 'H2P2_DBG_FPGA_SIZE' undeclared (first use in this function)
arch/arm/plat-omap/debug-leds.c:114:9: note: each undeclared identifier is reported only once for each function it appears in

It does not appear with the omap2plus_config but will appear if you enable the NEW_LEDS support that enable OMAP_DEBUG_LEDS.

I'm not sure why the size is still hard coded. In theory, assuming the resource is properly initialized, resource_size should be usable.
The patch below is fixing that.

Regards,
Benoit

---
>From 81e1c3dddd1cd78b1f5a04983cf920b287764f11 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 12 Nov 2012 11:44:03 +0100
Subject: [PATCH] ARM: OMAP: debug-leds: Use resource_size instead of hard coded macro

The debug-leds driver should not rely on hard coded macro for
the iomem size but use the resource size instead.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/debug-leds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index c43ea21..aa7ebc6 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -111,7 +111,7 @@ static int fpga_probe(struct platform_device *pdev)
 	if (!iomem)
 		return -ENODEV;
 
-	fpga = ioremap(iomem->start, H2P2_DBG_FPGA_SIZE);
+	fpga = ioremap(iomem->start, resource_size(iomem));
 	__raw_writew(0xff, &fpga->leds);
 
 	for (i = 0; i < ARRAY_SIZE(dbg_leds); i++) {
-- 
1.7.0.4

