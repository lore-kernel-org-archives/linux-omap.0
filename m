From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Tue, 17 May 2011 14:56:54 +0300
Message-ID: <1305633414.1847.11.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>
	 <1305535980.2002.34.camel@deskari>  <4DD106BD.4070009@compulab.co.il>
	 <1305632940.1847.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:41007 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754436Ab1EQL46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 07:56:58 -0400
Received: by mail-ey0-f182.google.com with SMTP id 7so272978eyg.27
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 04:56:57 -0700 (PDT)
In-Reply-To: <1305632940.1847.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Tue, 2011-05-17 at 14:49 +0300, Tomi Valkeinen wrote:
> On Mon, 2011-05-16 at 14:13 +0300, Igor Grinberg wrote:
> > On 05/16/11 11:53, Tomi Valkeinen wrote:

> > > +static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
> > > +{
> > > +	int r;
> > > +
> > > +	struct gpio gpios[] = {
> > > +		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
> > > +		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
> > > +	};
> > > +
> > > +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> > > +	if (r)
> > > +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> > > +
> > > +	ldp_backlight_gpio = gpio + 15;
> > > +	ldp_lcd_enable_gpio = gpio + 7;
> > 
> > If the gpio_request_array() fails (though it shouldn't),
> > won't it be right to set both variables to -EINVAL?
> 
> Ah, yes. I'll fix that.
> 
> Do you know what will happen if twl_gpio_setup fails? Just an error
> print, or will TWL driver fail?

And I wonder if gpio_is_valid() works correctly for GPIOs from an gpio
expander? With a quick search, gpio_is_valid returns true if gpio is
between [0, 256[, and doesn't care if there are gpio expanders or not...

 Tomi


