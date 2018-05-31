From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: mapphone-mdm6600: Fix wrong enum used for status lines
Date: Thu, 31 May 2018 10:05:38 -0700
Message-ID: <20180531170538.32264-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Kbuilt test robot reported:

drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used
uninitialized in this function [-Wuninitialized]
        val |= values[i] << i;
               ~~~~~~^~~

Looking at the phy_mdm6600_status() values does get initialized by
gpiod_get_array_value_cansleep(), but we are using wrong enum
in that function. Let's fix the use, both end up being three though
so urgent rush on this one AFAIK.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for
MDM6600 on Droid 4")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -182,13 +182,13 @@ static void phy_mdm6600_status(struct work_struct *work)
 	ddata = container_of(work, struct phy_mdm6600, status_work.work);
 	dev = ddata->dev;
 
-	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
+	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
 					       values);
 	if (error)
 		return;
 
-	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++) {
+	for (i = 0; i < PHY_MDM6600_NR_STATUS_LINES; i++) {
 		val |= values[i] << i;
 		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
 			__func__, i, values[i], val);
-- 
2.17.0
