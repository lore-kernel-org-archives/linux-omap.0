From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Wed, 11 May 2011 09:32:43 +0300
Message-ID: <1305095563.2097.11.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57519 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790Ab1EKRb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 13:31:59 -0400
Received: by ewy2 with SMTP id 2so274938ewy.15
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 10:31:51 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Wed, 2011-05-11 at 10:28 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> > Sent: Monday, May 09, 2011 1:06 PM
> > To: tony@atomide.com
> > Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi; Stanley Miao
> > Subject: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
> > 
> > Port the old omapfb panel driver to DSS2i. This patch changes the board
> > file only, the driver is ported in separate patch.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Stanley Miao <stanley.miao@windriver.com>
> > ---
> >  arch/arm/mach-omap2/board-ldp.c |   73 +++++++++++++++++++++++++++++++++-
> > ----

<snip>

> > +static struct panel_generic_dpi_data ldp_panel_data = {
> > +	.name			= "2430sdp",
> 
> LDP is a 3430 board.

That is just the name of the panel, used to find the right timings from
the panel database. I first ported 2430sdp board, and called the panel
that. The timings looked the same on LDP board, so I deduced it's the
same panel, and used the same name.

However, if you do have the board, can you find the name and type of the
panel? It's usually printed in the backside of the panel, which of
course may not be accessible easily.

Or, if you or anyone else knows where to find information about the LDP
board, schematics or datasheets, that could help also.

> > +static void __init ldp_display_init(void)
> > +{
> > +	int r;
> > +
> > +	struct gpio gpios[] = {
> > +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
> > +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
> > +		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
> > +		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD
> > BACKLIGHT"},
> > +	};
> > +
> > +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> > +	if (r) {
> > +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> > +		return;
> > +	}
> 
> If I test with this patch, this request is returning error.

Hmm. Well, the GPIOs are the same as in the old driver. However, the old
driver doesn't even seem to check if it manages to request the GPIOs, so
it may well be that it was failing also.

Can you check from /sys/class/gpio/ if some of the GPIOs are already
allocated: 207, 199, 55, 56?

The definition of two of those GPIOs look kinda funny to me: (15 +
OMAP_MAX_GPIO_LINES). I don't know what OMAP_MAX_GPIO_LINES means, but
it sure doesn't sound ok to have a GPIO number that is 15 over the
maximum =).

 Tomi


