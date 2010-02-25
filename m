From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 1/2 V2] OMAP: DSS: Add display board file for zoom boards
Date: Thu, 25 Feb 2010 10:10:27 -0600
Message-ID: <A24693684029E5489D1D202277BE89445398E7A7@dlee02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8B93@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8C25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40689 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932586Ab0BYQKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 11:10:32 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8C25@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Manjunath,

From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
Sent: Thursday, February 11, 2010 5:35 AM
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Y, Kishore
> Sent: Thursday, February 11, 2010 3:33 PM

<snip>

> > +
> > +static void zoom_lcd_tv_panel_init(void)
> > +{
> > +	int ret;
> > +	unsigned char lcd_panel_reset_gpio;
> > +
> > +	if (omap_rev() > OMAP3430_REV_ES3_0) {
> > +		/* Production Zoom2 board:
> > +		 * GPIO-96 is the LCD_RESET_GPIO
> > +		 */
> > +		lcd_panel_reset_gpio = LCD_PANEL_RESET_GPIO_PROD;
> > +	} else {
> > +		/* Pilot Zoom2 board:
> > +		 * GPIO-55 is the LCD_RESET_GPIO
> > +		 */
> > +		lcd_panel_reset_gpio = LCD_PANEL_RESET_GPIO_PILOT;
> > +	}
> 
> How about:
> 
> lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
> LCD_PANEL_RESET_GPIO_PROD :
> 						LCD_PANEL_RESET_GPIO_PILOT;

This approach has been discussed many times before, and found incorrect. There is no way to auto-detect valid GPIO for reset as of now. For example: Zoom Pilot + 3630 SOM case will fail here.

I'll push again for my thoughts on this one...

There MUST be a configurable option in kernel menuconfig to select the board revision (Pilot, pre-production). That is the only clean way I can see this could actually work.

Regards,
Sergio

<snip>
