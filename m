From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] usb: musb: Fix use for of_property_read_bool for disabled multipoint
Date: Thu,  5 Feb 2015 08:35:12 -0800
Message-ID: <1423154113-23463-2-git-send-email-tony@atomide.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:46428 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967063AbbBEQiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 11:38:09 -0500
In-Reply-To: <1423154113-23463-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

The value for the multipoint dts property is ignored when parsing with
of_property_read_bool, so we currently have multipoint always set as 1
even if value 0 is specified in the dts file.

Let's fix this to read the value too instead of just the property like
the binding documentation says as otherwise MUSB will fail to work
on devices with Mentor configuration that does not support multipoint.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_dsps.c | 7 +++++--
 drivers/usb/musb/omap2430.c  | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -687,7 +687,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	struct musb_hdrc_config	*config;
 	struct platform_device *musb;
 	struct device_node *dn = parent->dev.of_node;
-	int ret;
+	int ret, val;
 
 	memset(resources, 0, sizeof(resources));
 	res = platform_get_resource_byname(parent, IORESOURCE_MEM, "mc");
@@ -739,7 +739,10 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	pdata.mode = get_musb_port_mode(dev);
 	/* DT keeps this entry in mA, musb expects it as per USB spec */
 	pdata.power = get_int_prop(dn, "mentor,power") / 2;
-	config->multipoint = of_property_read_bool(dn, "mentor,multipoint");
+
+	ret = of_property_read_u8(dn, "mentor,multipoint", &val);
+	if (!ret && val)
+		config->multipoint = true;
 
 	ret = platform_device_add_data(musb, &pdata, sizeof(pdata));
 	if (ret) {
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -516,7 +516,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	struct omap2430_glue		*glue;
 	struct device_node		*np = pdev->dev.of_node;
 	struct musb_hdrc_config		*config;
-	int				ret = -ENOMEM;
+	int				ret = -ENOMEM, val;
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
@@ -559,7 +559,10 @@ static int omap2430_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
 		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
 		of_property_read_u32(np, "power", (u32 *)&pdata->power);
-		config->multipoint = of_property_read_bool(np, "multipoint");
+
+		ret = of_property_read_u8(np, "multipoint", &val);
+		if (!ret && val)
+			config->multipoint = true;
 
 		pdata->board_data	= data;
 		pdata->config		= config;
-- 
2.1.4

