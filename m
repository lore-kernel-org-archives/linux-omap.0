From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v6] phy: omap-usb2: move omap_usb.h from linux/usb/ to linux/phy/
Date: Fri, 7 Mar 2014 22:18:08 +0530
Message-ID: <1394210888-1587-1-git-send-email-kishon@ti.com>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393846695-14644-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Moved omap_usb.h from linux/usb/ to linux/phy/.
Also removed the unused members of struct omap_usb (after phy-omap-pipe3
started using it's own header file)

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v5:
fixes the following compilation error
drivers/usb/phy/phy-twl6030-usb.c:30:32:
fatal error: linux/usb/omap_usb.h: No such file or directory

 drivers/phy/phy-omap-usb2.c           |    2 +-
 drivers/usb/phy/phy-twl6030-usb.c     |    2 +-
 include/linux/{usb => phy}/omap_usb.h |    3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)
 rename include/linux/{usb => phy}/omap_usb.h (95%)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 705af5a..9c3f056 100644
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
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 214172b..04778cf 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -27,7 +27,7 @@
 #include <linux/io.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/phy_companion.h>
-#include <linux/usb/omap_usb.h>
+#include <linux/phy/omap_usb.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
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
1.7.9.5
