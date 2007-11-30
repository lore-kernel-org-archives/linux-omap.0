From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH] [MUSB] fix bug: when no USB device is plugged into the
	port of EZKIT-BF548, USB OTG host mode got BUG()
Date: Fri, 30 Nov 2007 18:11:16 +0800
Message-ID: <1196417476.9628.17.camel@roc-laptop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Subject: [PATCH] [MUSB] fix bug: when no USB device is plugged into the port of EZKIT-BF548, USB OTG host mode got BUG()

Move IRQ workqueue init before request_irq, otherwise host SUSPEND irq
will call schedule_work() and BUG_ON() will fire because musb_irq_work did
not initialised.

We recorded it at
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3740

Although the Blackfin port of MUSB is not merged, this bug should be
common for other platform with MUSB

Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/usb/musb/musb_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 33774a6..008f42c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1992,6 +1992,9 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (status < 0)
 		goto fail2;
 
+	/* Init IRQ workqueue before request_irq */
+	INIT_WORK(&musb->irq_work, musb_irq_work);
+
 	/* attach to the IRQ */
 	if (request_irq (nIrq, musb->isr, 0, dev->bus_id, musb)) {
 		dev_err(dev, "request_irq %d failed!\n", nIrq);
@@ -2071,8 +2074,6 @@ fail:
 		return status;
 	}
 
-	INIT_WORK(&musb->irq_work, musb_irq_work);
-
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_vbus);
-- 
1.5.3
