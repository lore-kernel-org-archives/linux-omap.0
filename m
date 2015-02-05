From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] usb: musb: Fix use for of_property_read_bool for
 disabled multipoint
Date: Thu, 5 Feb 2015 11:13:01 -0800
Message-ID: <20150205191300.GD25235@atomide.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
 <1423154113-23463-2-git-send-email-tony@atomide.com>
 <20150205180905.GE22782@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:55862 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbBETPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 14:15:38 -0500
Content-Disposition: inline
In-Reply-To: <20150205180905.GE22782@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

* Felipe Balbi <balbi@ti.com> [150205 10:12]:
> On Thu, Feb 05, 2015 at 08:35:12AM -0800, Tony Lindgren wrote:
> > The value for the multipoint dts property is ignored when parsing with
> > of_property_read_bool, so we currently have multipoint always set as 1
> > even if value 0 is specified in the dts file.
> > 
> > Let's fix this to read the value too instead of just the property like
> > the binding documentation says as otherwise MUSB will fail to work
> > on devices with Mentor configuration that does not support multipoint.
> > 
> > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> do you mind waiting a little bit to see if my boolean properties with
> value patch is accepted ?

This can wait for v3.20-rc1 for sure but cc stable would be nice to
avoid more pointless debugging by somebody else.
 
> http://marc.info/?l=linux-omap&m=142315930232743&w=2
> 
> At least let's see where the discussion moves.

Cool yeah at least a warning should be printed, sounds like it may
not be usable for fixing $subject though.

I also noticed that a last minute change I did from read_u32 to
read_u8 in $subject patch broke things and introduced new build
warnings. Here's a fixed version back to using read_u32 instead
of read_u8 so we don't need to specify the storage size with
/bits/ 8 values in the dts files.

Regards,

Tony

8< ------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 4 Feb 2015 06:28:49 -0800
Subject: [PATCH] usb: musb: Fix use for of_property_read_bool for disabled multipoint

The value for the multipoint dts property is ignored when parsing with
of_property_read_bool, so we currently have multipoint always set as 1
even if value 0 is specified in the dts file.

Let's fix this to read the value too instead of just the property like
the binding documentation says as otherwise MUSB will fail to work
on devices with Mentor configuration that does not support multipoint.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
+	ret = of_property_read_u32(dn, "mentor,multipoint", &val);
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
+		ret = of_property_read_u32(np, "multipoint", &val);
+		if (!ret && val)
+			config->multipoint = true;
 
 		pdata->board_data	= data;
 		pdata->config		= config;
