From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: [PATCH 2/2] OMAP: 2430SDP: Kill warning: twl4030 keypad
Date: Fri, 25 May 2007 17:32:30 -0500
Message-ID: <782515bb0705251532t389202c4jb794cd1f36e7da7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

struct input_dev has not moved to struct device from class_device. Kill the
re-init till this happens

Signed-off-by: Nishanth Menon <menon.nishanth@gmail.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c
b/drivers/input/keyboard/omap-twl4030keypad.c
index b96e84f..4750dba 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -253,9 +253,6 @@ static int __init omap_kp_probe(struct
platform_device *pdev)
 	omap_twl4030kp->keycodesize	= sizeof(unsigned int);
 	omap_twl4030kp->keycodemax	= pdata->keymapsize;

-	/* Get the debug Device to omap keypad device */
-	dbg_dev = &(omap_twl4030kp->dev);
-
 	ret = input_register_device(omap_twl4030kp);
 	if (ret < 0) {
 		dev_err(dbg_dev, "Unable to register twl4030 keypad device\n");
-- 
1.5.0.6
