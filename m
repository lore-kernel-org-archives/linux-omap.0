From: "iqbal" <iqbal@ti.com>
Subject: Re: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 19:57:03 +0530 (IST)
Message-ID: <56537.192.168.10.89.1219847223.squirrel@dbdmail.itg.ti.com>
References: <1219829316.15818.77.camel@localhost>
Reply-To: iqbal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbYH0O1J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2008 10:27:09 -0400
In-Reply-To: <1219829316.15818.77.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stanley.miao@windriver.com
Cc: linux-omap@vger.kernel.org


> The linux bootup logo is green, and LCD is dark. It looks like backlight
> disabled.
>
> I commented the following two sentences in lcd_2430.c, there is still
> the same thing. It seems these two sentences doesn't work.
>
>  96         omap_set_gpio_dataout(enable_gpio, 1);
>  97         omap_set_gpio_dataout(backlight_gpio, 1);
>
> Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
> this problem.  However, the old version in linux-omap-2.6, 2.6.21,
> doesn't have this problem.
>
> Stanley.

If I use this piece of code in panel suspend and resume, I see that the panel
backlight is going off on suspend and comes back while calling resume. Give a
try .

 static int sdp2430_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
+       omap_set_gpio_dataout(backlight_gpio, 0);
+       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
+                               TWL4030_VPLL2_DEDICATED);
+       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
+                               TWL4030_VPLL2_DEV_GRP);
+       mdelay(4);
        return 0;
 }

 static int sdp2430_panel_resume(struct platform_device *pdev)
 {
+       if (lcd_in_use)
+       return 0;
+       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                       ENABLE_VPLL2_DEDICATED,TWL4030_VPLL2_DEDICATED);
+       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                       ENABLE_VPLL2_DEV_GRP,TWL4030_VPLL2_DEV_GRP);
+       omap_set_gpio_dataout(backlight_gpio, 1);
+
        return 0;
 }

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


