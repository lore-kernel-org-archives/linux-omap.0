From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] omap_hsmmc: Fix for the db clock failure message
Date: Tue, 18 Aug 2009 03:34:13 +0530 (IST)
Message-ID: <60037.192.168.10.88.1250546653.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi,

This patch applies on top of the series "[PATCH V2 0/32] mmc and omap_hsmmc
patches" posted by Adrian Hunter.

Regards,
Madhu
-------------------------------------------------



This patch removes the error message "Failed to get debounce clock.." printed
out by the HSMMC driver on OMAP3430. The debounce clock needs to be handled only
for OMAP2430.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   63 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/omap_hsmmc.c
+++ linux-2.6/drivers/mmc/host/omap_hsmmc.c
@@ -735,8 +735,10 @@ static int omap_hsmmc_switch_opcond(stru
 	/* Disable the clocks */
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
-	if (host->dbclk_enabled)
+	if (cpu_is_omap2430() && host->dbclk_enabled) {
 		clk_disable(host->dbclk);
+		host->dbclk_enabled = 0;
+	}

 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -746,9 +748,14 @@ static int omap_hsmmc_switch_opcond(stru
 		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
 					       vdd);
 	clk_enable(host->iclk);
-	if (host->dbclk_enabled)
-		clk_enable(host->dbclk);
 	clk_enable(host->fclk);
+	if (cpu_is_omap2430() && !host->dbclk_enabled) {
+		if (clk_enable(host->dbclk) != 0)
+			dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
+						" clk failed\n");
+		else
+			host->dbclk_enabled = 1;
+	}

 	if (ret != 0)
 		goto err;
@@ -1697,18 +1704,21 @@ static int __init omap_hsmmc_probe(struc
 		goto err1;
 	}

-	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
-	/*
-	 * MMC can still work without debounce clock.
-	 */
-	if (IS_ERR(host->dbclk))
-		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clock\n");
-	else
-		if (clk_enable(host->dbclk) != 0)
-			dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
-							" clk failed\n");
+	if (cpu_is_omap2430()) {
+		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
+		/*
+		 * MMC can still work without debounce clock.
+		 */
+		if (IS_ERR(host->dbclk))
+			dev_warn(mmc_dev(host->mmc),
+				"Failed to get debounce clock\n");
 		else
-			host->dbclk_enabled = 1;
+			if (clk_enable(host->dbclk) != 0)
+				dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
+							" clk failed\n");
+			else
+				host->dbclk_enabled = 1;
+	}

 	/* Since we do only SG emulation, we can have as many segs
 	 * as we want. */
@@ -1825,8 +1835,9 @@ err_irq:
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
-	if (host->dbclk_enabled) {
-		clk_disable(host->dbclk);
+	if (cpu_is_omap2430()) {
+		if (host->dbclk_enabled)
+			clk_disable(host->dbclk);
 		clk_put(host->dbclk);
 	}

@@ -1859,8 +1870,9 @@ static int omap_hsmmc_remove(struct plat
 		clk_disable(host->iclk);
 		clk_put(host->fclk);
 		clk_put(host->iclk);
-		if (host->dbclk_enabled) {
-			clk_disable(host->dbclk);
+		if (cpu_is_omap2430()) {
+			if (host->dbclk_enabled)
+				clk_disable(host->dbclk);
 			clk_put(host->dbclk);
 		}

@@ -1910,8 +1922,10 @@ static int omap_hsmmc_suspend(struct pla
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
-			if (host->dbclk_enabled)
+			if (cpu_is_omap2430() && host->dbclk_enabled) {
 				clk_disable(host->dbclk);
+				host->dbclk_enabled = 0;
+			}
 		} else {
 			host->suspended = 0;
 			if (host->pdata->resume) {
@@ -1942,14 +1956,19 @@ static int omap_hsmmc_resume(struct plat
 		if (ret)
 			goto clk_en_err;

-		if (host->dbclk_enabled)
-			clk_enable(host->dbclk);
-
 		if (mmc_host_enable(host->mmc) != 0) {
 			clk_disable(host->iclk);
 			goto clk_en_err;
 		}

+		if (cpu_is_omap2430() && !host->dbclk_enabled) {
+			if (clk_enable(host->dbclk) != 0)
+				dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
+							" clk failed\n");
+			else
+				host->dbclk_enabled = 1;
+		}
+
 		omap_hsmmc_conf_bus_power(host);

 		if (host->pdata->resume) {



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
