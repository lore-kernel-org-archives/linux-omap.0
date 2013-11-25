From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 09/10] phy: omap-usb2: move omap_usb.h from linux/usb/ to linux/phy/
Date: Mon, 25 Nov 2013 15:31:29 +0530
Message-ID: <1385373690-12170-10-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385373690-12170-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, kishon@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

No functional change. Moved omap_usb.h from linux/usb/ to linux/phy/.
Also removed the unused members of struct omap_usb (after phy-omap-pipe3
started using it's own header file)

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-omap-usb2.c           |    2 +-
 include/linux/{usb => phy}/omap_usb.h |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
 rename include/linux/{usb => phy}/omap_usb.h (95%)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 9b3e867..d738dc3 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/io.h>
-#include <linux/usb/omap_usb.h>
+#include <linux/phy/omap_usb.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/include/linux/usb/omap_usb.h b/include/linux/phy/omap_usb.h
similarity index 95%
rename from include/linux/usb/omap_usb.h
rename to include/linux/phy/omap_usb.h
index 6ae2936..19d343c3 100644
--- a/include/linux/usb/omap_usb.h
+++ b/include/linux/phy/omap_usb.h
@@ -33,13 +33,10 @@ struct usb_dpll_params {
 struct omap_usb {
 	struct usb_phy		phy;
 	struct phy_companion	*comparator;
-	void __iomem		*pll_ctrl_base;
 	struct device		*dev;
 	struct device		*control_dev;
 	struct clk		*wkupclk;
-	struct clk		*sys_clk;
 	struct clk		*optclk;
-	u8			is_suspended:1;
 };
 
 #define	phy_to_omapusb(x)	container_of((x), struct omap_usb, phy)
-- 
1.7.10.4
