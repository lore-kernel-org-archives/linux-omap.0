From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH]Separate out 3430 LCD panel support from 2430
	file
Date: Tue, 8 Jul 2008 10:48:15 +0300
Message-ID: <20080708074814.GB17594@atomide.com>
References: <1215001464-12691-1-git-send-email-iqbal@ti.com> <fb249edb0807040932k4f2977a4w380b50e7f3cce197@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63764 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYGHHsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 03:48:20 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0807040932k4f2977a4w380b50e7f3cce197@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: iqbal@ti.com, linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [080704 19:34]:
> 2008/7/2  <iqbal@ti.com>:
> > From: Iqbal Shareef <iqbal@ti.com>
> >
> > Separate out 3430 LCD panel support from 2430 SDP.
> >
> > Currently the support for the LCD on 3430SDP is added in the lcd_2430sdp.c
> > file. This patch separates it out to a new file.
> 
> Isn't this a bit step backwards?  Code reuse is generally a good thing
> if it doesn't clutter the code too much, and if you do diff -pNaur
> lcd_2430sdp.c lcd_3430sdp.c in the current tree you will see that they
> are very similar.

Good point. I'll revert this patch, that should fix the compile issue
too.

Tony

> Additionally this patch leaves some of the 3430SDP code in
> lcd_2430sdp.c, you will still find this:
> #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO 	24
> #define SDP3430_LCD_PANEL_ENABLE_GPIO 		28
> ...
> 	if (machine_is_omap_3430sdp()) {
> 		enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
> 		backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
> 	} else {
> 		enable_gpio    = SDP2430_LCD_PANEL_ENABLE_GPIO;
> 		backlight_gpio = SDP2430_LCD_PANEL_BACKLIGHT_GPIO;
> 	}
> ...
> 	if (machine_is_omap_3430sdp()) {
> 		ded_reg = TWL4030_VAUX3_DEDICATED;
> 		ded_val = ENABLE_VAUX3_DEDICATED;
> 		grp_reg = TWL4030_VAUX3_DEV_GRP;
> 		grp_val = ENABLE_VAUX3_DEV_GRP;
> 	} else {
> 		ded_reg = TWL4030_VAUX2_DEDICATED;
> 		ded_val = ENABLE_VAUX2_DEDICATED;
> 		grp_reg = TWL4030_VAUX2_DEV_GRP;
> 		grp_val = ENABLE_VAUX2_DEV_GRP;
> 	}
> 
> Another thing that isn't explained is why the GPIO numbers for
> backlight and enable changed from 24 and 28 to 8 and 5.
> 
> Regards,
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
