From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] phy: ti-pipe3: Program the DPLL even if it was already locked
Date: Wed, 18 May 2016 15:28:06 +0300
Message-ID: <1463574486-30438-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robertcnelson@gmail.com, nm@ti.com, jkridner@gmail.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If bootloader has set a wrong DPLL then we must trash those values
and re-program it anyways. This fixes USB3 devices not being enumerated
on beagle-x15 if usb was started in u-boot.

We don't re-program SATA DPLL if it is locked as it was causing
SATA failures if device was hotpluged after boot.

Reported-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-ti-pipe3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 0a477d2..bf46844 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -293,11 +293,18 @@ static int ti_pipe3_init(struct phy *x)
 		ret = ti_pipe3_dpll_wait_lock(phy);
 	}
 
-	/* Program the DPLL only if not locked */
+	/* SATA has issues if re-programmed when locked */
 	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-	if (!(val & PLL_LOCK))
-		if (ti_pipe3_dpll_program(phy))
-			return -EINVAL;
+	if ((val & PLL_LOCK) && of_device_is_compatible(phy->dev->of_node,
+							"ti,phy-pipe3-sata"))
+		return ret;
+
+	/* Program the DPLL */
+	ret = ti_pipe3_dpll_program(phy);
+	if (ret) {
+		ti_pipe3_disable_clocks(phy);
+		return -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.7.4
