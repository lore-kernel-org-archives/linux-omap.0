From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: [PATCH v3 2/2] USB: TWL6025 allow different regulator name
Date: Wed, 18 May 2011 19:32:50 +0100
Message-ID: <1305743570-12074-3-git-send-email-gg@slimlogic.co.uk>
References: <1305743570-12074-1-git-send-email-gg@slimlogic.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305743570-12074-1-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux@slimlogic.co.uk, lrg@ti.com, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

The twl6025 uses a different regulator for USB than the 6030 so select
the correct regulator name depending on the subclass of device.

Since V1

Use features passed via platform data instead of global variable.

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/usb/otg/twl6030-usb.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 3f2e070..cfb5aa7 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -100,6 +100,7 @@ struct twl6030_usb {
 	u8			linkstat;
 	u8			asleep;
 	bool			irq_enabled;
+	unsigned long		features;
 };
 
 #define xceiv_to_twl(x)		container_of((x), struct twl6030_usb, otg)
@@ -204,6 +205,12 @@ static int twl6030_start_srp(struct otg_transceiver *x)
 
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 {
+	char *regulator_name;
+
+	if (twl->features & TWL6025_SUBCLASS)
+		regulator_name = "ldousb";
+	else
+		regulator_name = "vusb";
 
 	/* Set to OTG_REV 1.3 and turn on the ID_WAKEUP_COMP */
 	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x1, TWL6030_BACKUP_REG);
@@ -214,7 +221,7 @@ static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 	/* Program MISC2 register and set bit VUSB_IN_VBAT */
 	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x10, TWL6030_MISC2);
 
-	twl->usb3v3 = regulator_get(twl->dev, "vusb");
+	twl->usb3v3 = regulator_get(twl->dev, regulator_name);
 	if (IS_ERR(twl->usb3v3))
 		return -ENODEV;
 
@@ -409,6 +416,7 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq1		= platform_get_irq(pdev, 0);
 	twl->irq2		= platform_get_irq(pdev, 1);
+	twl->features		= pdata->features;
 	twl->otg.dev		= twl->dev;
 	twl->otg.label		= "twl6030";
 	twl->otg.set_host	= twl6030_set_host;
-- 
1.7.4.1
