From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ARM: OMAP: Improve a size determination in two functions
Date: Tue, 3 Oct 2017 22:14:20 +0200
Message-ID: <8735e7ee-a744-cda4-005b-7a32075655a5@users.sourceforge.net>
References: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Oct 2017 20:46:48 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-omap/dma.c     | 2 +-
 arch/arm/plat-omap/dmtimer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6ede0427548c..409e4ecaebe9 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1316,7 +1316,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	enable_1510_mode	= d->dev_caps & ENABLE_1510_MODE;
 
 	dma_chan = devm_kcalloc(&pdev->dev, dma_lch_count,
-				sizeof(struct omap_dma_lch), GFP_KERNEL);
+				sizeof(*dma_chan), GFP_KERNEL);
 	if (!dma_chan)
 		return -ENOMEM;
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 446ac0e3a35a..14779d6f425d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -857,7 +857,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
+	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
-- 
2.14.2
