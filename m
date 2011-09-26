From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 07/13] omap: mcbsp: Use per instance register cache size
Date: Mon, 26 Sep 2011 10:45:43 +0300
Message-ID: <1317023150-6730-8-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49016 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab1IZHqf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 03:46:35 -0400
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Rationale here is to remove one global variable and to make possible to have
variable size McBSP register maps inside SoC.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    3 ++-
 arch/arm/plat-omap/mcbsp.c              |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 0fad63c..648344a 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -359,6 +359,7 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 	void *reg_cache;
+	int reg_cache_size;
 };
 
 /**
@@ -370,7 +371,7 @@ struct omap_mcbsp_dev_attr {
 };
 
 extern struct omap_mcbsp **mcbsp_ptr;
-extern int omap_mcbsp_count, omap_mcbsp_cache_size;
+extern int omap_mcbsp_count;
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 234ab16..3ad536e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -31,7 +31,7 @@
 #include "../mach-omap2/cm-regbits-34xx.h"
 
 struct omap_mcbsp **mcbsp_ptr;
-int omap_mcbsp_count, omap_mcbsp_cache_size;
+int omap_mcbsp_count;
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
@@ -678,7 +678,7 @@ int omap_mcbsp_request(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	reg_cache = kzalloc(omap_mcbsp_cache_size, GFP_KERNEL);
+	reg_cache = kzalloc(mcbsp->reg_cache_size, GFP_KERNEL);
 	if (!reg_cache) {
 		return -ENOMEM;
 	}
@@ -1225,7 +1225,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 		}
 	}
 	mcbsp->phys_base = res->start;
-	omap_mcbsp_cache_size = resource_size(res);
+	mcbsp->reg_cache_size = resource_size(res);
 	mcbsp->io_base = ioremap(res->start, resource_size(res));
 	if (!mcbsp->io_base) {
 		ret = -ENOMEM;
-- 
1.7.6.3

