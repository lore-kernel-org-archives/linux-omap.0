From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: Switch to gpio_direction_output in OMAP_LDP.
Date: Thu, 20 Nov 2008 11:11:09 -0800
Message-ID: <200811201111.09749.david-b@pacbell.net>
References: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:26392 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752663AbYKTTLL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 14:11:11 -0500
In-Reply-To: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Thursday 20 November 2008, Stanley.Miao wrote:
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_direction(LCD_PANEL_QVGA_GPIO, 0)=
;
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_direction(LCD_PANEL_RESET_GPIO, 0=
);
> =A0=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(LCD_PANEL_ENABLE_GPIO, =
0);
> =A0=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(LCD_PANEL_BACKLIGHT_GPI=
O, 0);

Nothing does

	gpio_request(LCD_PANEL_QVGA_GPIO, "qvga something");
	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");

And by removing the initial direction setting call (above),
behavior of at least the reset line changes:  it's no longer
pullsed low.

It'd be better to change the direction setting calls above
(setting an initial low value), and then make the calls
below use gpio_set_value().

 =A0
> =A0#ifdef CONFIG_FB_OMAP_LCD_VGA
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 0);
> +=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
> =A0#else
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 1);
> +=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
> =A0#endif
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_dataout(LCD_PANEL_RESET_GPIO, 1);
> +=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(LCD_PANEL_RESET_GPIO, 1);

Use gpio_set_value() to replace omap_set_gpio_dataout(), except
when initializing.  The reset pin *was* being toggled...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
