From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: omapfb problem on 3430sdp
Date: Fri, 29 Aug 2008 20:28:33 +0800
Message-ID: <1220012913.14924.55.camel@localhost>
References: <1219829316.15818.77.camel@localhost>
	 <56537.192.168.10.89.1219847223.squirrel@dbdmail.itg.ti.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41988 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbYH2M1F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 08:27:05 -0400
In-Reply-To: <56537.192.168.10.89.1219847223.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iqbal@ti.com
Cc: linux-omap@vger.kernel.org


I have tried. It is not backlight's problem.

I found that only green color was showed, red and blue were filtered. So
the picture looked green and dark.

The color mode is RGB565. I wrote 0x07e0, 0xffe0, and 0xffff to /dev/fb0
respectively. All of them are showed to the same color, it's green.

I am using the latest code from source.mvista.com on omap3430sdp. Does
anybody encounter this problem ?

Thanks
Stanley.


On Wed, 2008-08-27 at 19:57 +0530, iqbal wrote:
> > The linux bootup logo is green, and LCD is dark. It looks like backlight
> > disabled.
> >
> > I commented the following two sentences in lcd_2430.c, there is still
> > the same thing. It seems these two sentences doesn't work.
> >
> >  96         omap_set_gpio_dataout(enable_gpio, 1);
> >  97         omap_set_gpio_dataout(backlight_gpio, 1);
> >
> > Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
> > this problem.  However, the old version in linux-omap-2.6, 2.6.21,
> > doesn't have this problem.
> >
> > Stanley.
> 
> If I use this piece of code in panel suspend and resume, I see that the panel
> backlight is going off on suspend and comes back while calling resume. Give a
> try .
> 
>  static int sdp2430_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
>  {
> +       omap_set_gpio_dataout(backlight_gpio, 0);
> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
> +                               TWL4030_VPLL2_DEDICATED);
> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
> +                               TWL4030_VPLL2_DEV_GRP);
> +       mdelay(4);
>         return 0;
>  }
> 
>  static int sdp2430_panel_resume(struct platform_device *pdev)
>  {
> +       if (lcd_in_use)
> +       return 0;
> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       ENABLE_VPLL2_DEDICATED,TWL4030_VPLL2_DEDICATED);
> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       ENABLE_VPLL2_DEV_GRP,TWL4030_VPLL2_DEV_GRP);
> +       omap_set_gpio_dataout(backlight_gpio, 1);
> +
>         return 0;
>  }
> 
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
