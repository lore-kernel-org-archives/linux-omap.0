From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Thu, 19 Sep 2013 16:05:36 +0300
Message-ID: <1379595943-14622-9-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Some platforms have a PHY hooked up to the
SATA controller. The PHY needs to be initialized
and powered up for SATA to work. We do that
using the PHY framework.

[Roger Q] Cleaned up.

CC: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |    2 +-
 drivers/ata/Kconfig                                |    1 +
 drivers/ata/ahci.h                                 |    2 +
 drivers/ata/ahci_platform.c                        |   31 +++++++++++++++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 89de156..c6c549a 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -4,7 +4,7 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible        : compatible list, contains "snps,spear-ahci"
+- compatible        : compatible list, contains "snps,spear-ahci" or "snps,dwc-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4e73772..a53ef27 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -91,6 +91,7 @@ config SATA_AHCI
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
+	select GENERIC_PHY
 	help
 	  This option enables support for Platform AHCI Serial ATA
 	  controllers.
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1145637..94484cb 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -37,6 +37,7 @@
 
 #include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/phy/phy.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -322,6 +323,7 @@ struct ahci_host_priv {
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clk;		/* Only for platforms supporting clk */
+	struct phy		*phy;		/* If platforms use phy */
 	void			*plat_data;	/* Other platform data */
 };
 
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 2daaee0..f812ffa 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <linux/phy/phy.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -141,16 +142,32 @@ static int ahci_probe(struct platform_device *pdev)
 		}
 	}
 
+	hpriv->phy = devm_phy_get(dev, "sata-phy");
+	if (IS_ERR(hpriv->phy)) {
+		dev_err(dev, "can't get phy\n");
+		/* return only if -EPROBE_DEFER */
+		if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
+			rc = -EPROBE_DEFER;
+			goto disable_unprepare_clk;
+		}
+	}
+
 	/*
 	 * Some platforms might need to prepare for mmio region access,
 	 * which could be done in the following init call. So, the mmio
 	 * region shouldn't be accessed before init (if provided) has
 	 * returned successfully.
 	 */
+
+	if (!(IS_ERR(hpriv->phy))) {
+		phy_init(hpriv->phy);
+		phy_power_on(hpriv->phy);
+	}
+
 	if (pdata && pdata->init) {
 		rc = pdata->init(dev, hpriv->mmio);
 		if (rc)
-			goto disable_unprepare_clk;
+			goto disable_phy;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -220,6 +237,12 @@ static int ahci_probe(struct platform_device *pdev)
 pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
+disable_phy:
+	if (!IS_ERR(hpriv->phy)) {
+		phy_power_off(hpriv->phy);
+		phy_exit(hpriv->phy);
+	}
+
 disable_unprepare_clk:
 	if (!IS_ERR(hpriv->clk))
 		clk_disable_unprepare(hpriv->clk);
@@ -238,6 +261,11 @@ static void ahci_host_stop(struct ata_host *host)
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
+	if (!IS_ERR(hpriv->phy)) {
+		phy_power_off(hpriv->phy);
+		phy_exit(hpriv->phy);
+	}
+
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
@@ -328,6 +356,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
+	{ .compatible = "snps,dwc-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
