From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] ARM: OMAP: Delete an error message for a failed memory
 allocation in two functions
Date: Tue, 3 Oct 2017 22:13:19 +0200
Message-ID: <3c43886f-b3ad-26ce-eab3-390e7f483d08@users.sourceforge.net>
References: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Oct 2017 13:10:26 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-omap/dma.c     | 5 +----
 arch/arm/plat-omap/dmtimer.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 1e460b4ee3b9..6ede0427548c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1317,11 +1317,8 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 
 	dma_chan = devm_kcalloc(&pdev->dev, dma_lch_count,
 				sizeof(struct omap_dma_lch), GFP_KERNEL);
-	if (!dma_chan) {
-		dev_err(&pdev->dev, "%s: kzalloc fail\n", __func__);
+	if (!dma_chan)
 		return -ENOMEM;
-	}
-
 
 	if (dma_omap2plus()) {
 		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7a327bd32521..446ac0e3a35a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -858,10 +858,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	}
 
 	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
-	if (!timer) {
-		dev_err(dev, "%s: memory alloc failed!\n", __func__);
+	if (!timer)
 		return  -ENOMEM;
-	}
 
 	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_ioremap_resource(dev, mem);
-- 
2.14.2
