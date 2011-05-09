From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAP: 2420SDP: Port the display driver to new DSS2
Date: Mon, 09 May 2011 19:57:02 +0300
Message-ID: <1304960222.2215.47.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-4-git-send-email-tomi.valkeinen@ti.com>
	 <4DC7A3F3.1060302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38188 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753501Ab1EIQ5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 12:57:10 -0400
Received: by eyf5 with SMTP id 5so3285973eyf.1
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 09:57:07 -0700 (PDT)
In-Reply-To: <4DC7A3F3.1060302@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Hunyue Yau <hyau@mvista.com>

On Mon, 2011-05-09 at 11:21 +0300, Igor Grinberg wrote:
> Hi Tomi,
> 
> On 05/09/11 10:36, Tomi Valkeinen wrote:
> 
> > Port the old omapfb panel driver to DSS2. This patch changes the board
> > file only, the driver is ported in separate patch.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Hunyue Yau <hyau@mvista.com>

<snip>

> > +static void __init sdp2430_display_init(void)
> > +{
> > +	int r;
> > +
> > +	r = gpio_request_one(SDP2430_LCD_PANEL_ENABLE_GPIO,
> > +			GPIOF_OUT_INIT_LOW, "LCD reset");
> > +	if (r) {
> > +		printk(KERN_ERR "failed to get LCD reset GPIO\n");
> > +		goto err0;
> > +	}
> > +
> > +	r = gpio_request_one(SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
> > +			GPIOF_OUT_INIT_LOW, "LCD Backlight");
> > +	if (r) {
> > +		printk(KERN_ERR "failed to get LCD backlight GPIO\n");
> 
> can both printks be pr_err?
> 
> > +		goto err1;
> > +	}
> > +
> > +	omap_display_init(&sdp2430_dss_data);
> > +
> > +	return;
> > +err1:
> > +	gpio_free(SDP2430_LCD_PANEL_ENABLE_GPIO);
> > +err0:
> > +	return;
> > +}
> 
> I think using gpio_request_array() will be much cleaner here...

Right, thanks. It turned out much cleaner:

+static void __init sdp2430_display_init(void)
+{
+       int r;
+
+       static struct gpio gpios[] __initdata = {
+               { SDP2430_LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
+                       "LCD reset" },
+               { SDP2430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW,
+                       "LCD Backlight" },
+       };
+
+       r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+       if (r) {
+               pr_err("Cannot request LCD GPIOs, error %d\n", r);
+               return;
+       }
+
+       omap_display_init(&sdp2430_dss_data);
+}

 Tomi



