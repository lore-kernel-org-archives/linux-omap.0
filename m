From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: [PATCH] Fix mis-reporting USB Mode on sysfs
Date: Thu, 3 May 2007 22:44:28 +0300
Message-ID: <31e679430705031244rc7018b8o5cf0025e63058b3b@mail.gmail.com>
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

	This small patch fixes the mode reporting on sysfs.
	Whithout this, we will always see the device as in
	otg mode.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/usb/musb/tusb6010.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index d9113b0..a94555e 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -417,19 +417,14 @@ void musb_platform_set_mode(struct musb *musb,
u8 musb_mode)
 	u32		otg_stat, phy_otg_ena, phy_otg_ctrl, dev_conf;
 	int		vbus = 0;

-	if (musb->board_mode != MUSB_OTG) {
-		ERR("Changing mode currently only supported in OTG mode\n");
-		return;
-	}
-
 	otg_stat = musb_readl(base, TUSB_DEV_OTG_STAT);
 	phy_otg_ena = musb_readl(base, TUSB_PHY_OTG_CTRL_ENABLE);
 	phy_otg_ctrl = musb_readl(base, TUSB_PHY_OTG_CTRL);
 	dev_conf = musb_readl(base, TUSB_DEV_CONF);

+#ifdef CONFIG_USB_MUSB_OTG
 	switch (musb_mode) {

-#ifdef CONFIG_USB_MUSB_HDRC_HCD
 	case MUSB_HOST:		/* Disable PHY ID detect, ground ID */
 		if (!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS)) {
 			ERR("Already in host mode otg_stat: %08x\n", otg_stat);
@@ -440,10 +435,8 @@ void musb_platform_set_mode(struct musb *musb, u8
musb_mode)
 		dev_conf |= TUSB_DEV_CONF_ID_SEL;
 		dev_conf &= ~TUSB_DEV_CONF_SOFT_ID;
 		vbus = 1;
+		musb->board_mode = MUSB_HOST;
 		break;
-#endif
-
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	case MUSB_PERIPHERAL:	/* Disable PHY ID detect, keep ID pull-up on */
 		if (otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS) {
 			ERR("Already in peripheral mode otg_stat: %08x\n",
@@ -453,16 +446,15 @@ void musb_platform_set_mode(struct musb *musb,
u8 musb_mode)
 		phy_otg_ena |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 		phy_otg_ctrl |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 		dev_conf |= (TUSB_DEV_CONF_ID_SEL | TUSB_DEV_CONF_SOFT_ID);
+		musb->board_mode = MUSB_PERIPHERAL;
 		break;
-#endif

-#ifdef CONFIG_USB_MUSB_OTG
 	case MUSB_OTG:		/* Use PHY ID detection */
 		phy_otg_ena &= ~TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 		phy_otg_ctrl &= ~TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 		dev_conf &= ~(TUSB_DEV_CONF_ID_SEL | TUSB_DEV_CONF_SOFT_ID);
+		musb->board_mode = MUSB_OTG;
 		break;
-#endif

 	default:
 		DBG(2, "Trying to set unknown mode %i\n", musb_mode);
@@ -476,10 +468,10 @@ void musb_platform_set_mode(struct musb *musb,
u8 musb_mode)

 	msleep(1);
 	otg_stat = musb_readl(base, TUSB_DEV_OTG_STAT);
-	if ((musb_mode == MUSB_PERIPHERAL) &&
-		!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS))
-			ERR("Cannot be peripheral with mini-A cable "
-			"otg_stat: %08x\n", otg_stat);
+#else
+	ERR("Changing mode currently only supported in OTG mode\n");
+	return;
+#endif
 }



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
