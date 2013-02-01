From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe fails
Date: Fri, 1 Feb 2013 10:38:45 -0600
Message-ID: <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41269 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab3BAQiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 11:38:54 -0500
In-Reply-To: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>, Jon Hunter <jon-hunter@ti.com>

If the GPMC probe fails, devices that use the GPMC (such as ethernet
chips, flash memories, etc) can still allocate a GPMC chip-select and
register the device. On the OMAP2420 H4 board, this was causing the
kernel to crash after the gpmc probe failed and the board attempted
to start networking. Prevent this by marking all the chip-selects as
reserved by default and only make them available for devices to request
if the GPMC probe succeeds.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8033cb7..441cc63 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -145,7 +145,8 @@ static unsigned gpmc_irq_start;
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
-static unsigned int gpmc_cs_map;	/* flag for cs which are initialized */
+/* Define chip-selects as reserved by default until probe completes */
+static unsigned int gpmc_cs_map = ((1 << GPMC_CS_NUM) - 1);
 static struct device *gpmc_dev;
 static int gpmc_irq;
 static resource_size_t phys_base, mem_size;
@@ -1174,6 +1175,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
+	/* Now the GPMC is initialised, unreserve the chip-selects */
+	gpmc_cs_map = 0;
+
 	return 0;
 }
 
-- 
1.7.10.4

