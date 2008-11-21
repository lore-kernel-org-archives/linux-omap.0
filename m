From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP: Switch to gpio_direction_output in OMAP_LDP.
Date: Fri, 21 Nov 2008 15:50:42 +0800
Message-ID: <1227253842.14497.75.camel@localhost>
References: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com>
	 <200811201111.09749.david-b@pacbell.net>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51003 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYKUHob (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:44:31 -0500
In-Reply-To: <200811201111.09749.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, 2008-11-20 at 11:11 -0800, David Brownell wrote:
> On Thursday 20 November 2008, Stanley.Miao wrote:
> > -       omap_set_gpio_direction(LCD_PANEL_QVGA_GPIO, 0);
> > -       omap_set_gpio_direction(LCD_PANEL_RESET_GPIO, 0);
> >         gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
> >         gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
> 
> Nothing does
> 
> 	gpio_request(LCD_PANEL_QVGA_GPIO, "qvga something");
> 	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
> 

Accepted, change omap_request_gpio() to gpio_request().

> And by removing the initial direction setting call (above),
> behavior of at least the reset line changes:  it's no longer
> pullsed low.
> 
> It'd be better to change the direction setting calls above
> (setting an initial low value), and then make the calls
> below use gpio_set_value().
> 
>   
> >  #ifdef CONFIG_FB_OMAP_LCD_VGA
> > -       omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 0);
> > +       gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
> >  #else
> > -       omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 1);
> > +       gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
> >  #endif
> > -       omap_set_gpio_dataout(LCD_PANEL_RESET_GPIO, 1);
> > +       gpio_direction_output(LCD_PANEL_RESET_GPIO, 1);
> 
> Use gpio_set_value() to replace omap_set_gpio_dataout(), except
> when initializing.  The reset pin *was* being toggled...

These actions are in init function. so keep omap_set_gpio_dataout() in
place.

Thanks for your review, I will resend it.

Stanley.

> 
> - Dave
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
