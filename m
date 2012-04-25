From: NeilBrown <neilb@suse.de>
Subject: [PATCH 1/6] twl4030_charger: Fix some typos
Date: Wed, 25 Apr 2012 17:33:10 +1000
Message-ID: <20120425073310.20124.1097.stgit@notabene.brown>
References: <20120425072931.20124.56635.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120425072931.20124.56635.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

Signed-off-by:  NeilBrown <neilb@suse.de>
---

 drivers/power/twl4030_charger.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index fdad850..3e6e991 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -103,7 +103,7 @@ static int twl4030_bci_read(u8 reg, u8 *val)
 
 static int twl4030_clear_set_boot_bci(u8 clear, u8 set)
 {
-	return twl4030_clear_set(TWL4030_MODULE_PM_MASTER, 0,
+	return twl4030_clear_set(TWL4030_MODULE_PM_MASTER, clear,
 			TWL4030_CONFIG_DONE | TWL4030_BCIAUTOWEN | set,
 			TWL4030_PM_MASTER_BOOT_BCI);
 }
@@ -151,14 +151,14 @@ static int twl4030_bci_have_vbus(struct twl4030_bci *bci)
 }
 
 /*
- * Enable/Disable USB Charge funtionality.
+ * Enable/Disable USB Charge functionality.
  */
 static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
 
 	if (enable) {
-		/* Check for USB charger conneted */
+		/* Check for USB charger connected */
 		if (!twl4030_bci_have_vbus(bci))
 			return -ENODEV;
 
