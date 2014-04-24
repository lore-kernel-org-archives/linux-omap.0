From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 09/26] ARM: OMAP: dmtimer: Get rid of check for mem resource error
Date: Thu, 24 Apr 2014 16:43:52 -0500
Message-ID: <1398375849-6017-10-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

The subsequent devm_ioremap_resource will catch it and print an error, let it
be checked there.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7e806f9..1fd30fa 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -810,10 +810,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
 
 	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
 	if (!timer) {
-- 
1.7.9.5
