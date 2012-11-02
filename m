From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 5/5] usb: musb: dsps: control module handling (quirk)
Date: Fri, 2 Nov 2012 22:02:53 +0530
Message-ID: <329ef24ebe4c496dcfe3bb1b6a53d71175b2732b.1351870620.git.afzal@ti.com>
References: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1351870620.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: "Santhapuri, Damodar" <damodar.santhapuri@ti.com>

am335x uses nop transceiver driver and need to enable builtin phy
by writing into usb_ctrl register available in system control
module register space. This is being added at musb glue driver
layer until a separate system control module driver is available.

Proper solution is to make use of control module driver, but it is
not expected to be ready soon.

Other options available are providing control module register space
as memory resource via DT or using omap hwmod.

DT approach has been rejected by Rob Herring, while resources are
being moved from hwmod to DT. And both of the above approaches
require that control module registers be configured in wrapper
itself requring a quirk in driver as well as DT or hwmod.

Here another option is used, providing driver with control module
register physical address. Even though this a hack, there is no other
option left till control module driver is ready. As of now only
am335x is using dsps wrapper, and so driver is made aware of am335x
control module physical address.

Please note that this is a temporary arrangment till omap control
module driver is available.

[afzal@ti.com: limit quirk to dsps wrapper]

Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/usb/musb/musb_dsps.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index c90e4d3..e770f79 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -124,8 +124,44 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer[2];	/* otg_workaround timer */
 	unsigned long last_timer[2];    /* last timer data for each instance */
+	u32 __iomem *usb_ctrl[2];
 };
 
+#define	DSPS_AM33XX_CONTROL_MODULE_PHYS_0	0x44e10620
+#define	DSPS_AM33XX_CONTROL_MODULE_PHYS_1	0x44e10628
+
+static const resource_size_t dsps_control_module_phys[] = {
+	DSPS_AM33XX_CONTROL_MODULE_PHYS_0,
+	DSPS_AM33XX_CONTROL_MODULE_PHYS_1,
+};
+
+/**
+ * musb_dsps_phy_control - phy on/off
+ * @glue: struct dsps_glue *
+ * @id: musb instance
+ * @on: flag for phy to be switched on or off
+ *
+ * This is to enable the PHY using usb_ctrl register in system control
+ * module space.
+ *
+ * XXX: This function will be removed once we have a seperate driver for
+ * control module
+ */
+static void musb_dsps_phy_control(struct dsps_glue *glue, u8 id, u8 on)
+{
+	u32 usbphycfg;
+
+	usbphycfg = readl(glue->usb_ctrl[id]);
+
+	if (on) {
+		usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
+		usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
+	} else {
+		usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
+	}
+
+	writel(usbphycfg, glue->usb_ctrl[id]);
+}
 /**
  * dsps_musb_enable - enable interrupts
  */
@@ -393,6 +429,9 @@ static int dsps_musb_init(struct musb *musb)
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
 
+	/* Start the on-chip PHY and its PLL. */
+	musb_dsps_phy_control(glue, pdev->id, 1);
+
 	musb->isr = dsps_interrupt;
 
 	/* reset the otgdisable bit, needed for host mode to work */
@@ -418,6 +457,9 @@ static int dsps_musb_exit(struct musb *musb)
 
 	del_timer_sync(&glue->timer[pdev->id]);
 
+	/* Shutdown the on-chip PHY and its PLL. */
+	musb_dsps_phy_control(glue, pdev->id, 0);
+
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
 	usb_nop_xceiv_unregister();
@@ -450,6 +492,17 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	char res_name[10];
 	int ret;
 
+	resources[0].start = dsps_control_module_phys[id];
+	resources[0].end = resources[0].start + SZ_4 - 1;
+	resources[0].flags = IORESOURCE_MEM;
+
+	glue->usb_ctrl[id] = devm_request_and_ioremap(&pdev->dev, resources);
+	if (glue->usb_ctrl[id] == NULL) {
+		dev_err(dev, "Failed to obtain usb_ctrl%d memory\n", id);
+		ret = -ENODEV;
+		goto err0;
+	}
+
 	/* first resource is for usbss, so start index from 1 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, id + 1);
 	if (!res) {
@@ -636,11 +689,27 @@ static int __devexit dsps_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dsps_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	int i;
+
+	for (i = 0; i < wrp->instances; i++)
+		musb_dsps_phy_control(glue, i, 0);
+
 	return 0;
 }
 
 static int dsps_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	int i;
+
+	for (i = 0; i < wrp->instances; i++)
+		musb_dsps_phy_control(glue, i, 1);
+
 	return 0;
 }
 #endif
-- 
1.7.12

