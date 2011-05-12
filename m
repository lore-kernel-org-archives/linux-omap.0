From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 09:40:29 +0300
Message-ID: <4DCB80DD.5090408@compulab.co.il>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com> <1305095563.2097.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:57787
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751475Ab1ELGkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 02:40:33 -0400
In-Reply-To: <1305095563.2097.11.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>



On 05/11/11 09:32, Tomi Valkeinen wrote:

> On Wed, 2011-05-11 at 10:28 +0530, Janorkar, Mayuresh wrote:
>
>>> +static void __init ldp_display_init(void)
>>> +{
>>> +	int r;
>>> +
>>> +	struct gpio gpios[] = {
>>> +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
>>> +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
>>> +		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
>>> +		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD
>>> BACKLIGHT"},
>>> +	};
>>> +
>>> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
>>> +	if (r) {
>>> +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
>>> +		return;
>>> +	}
>> If I test with this patch, this request is returning error.
> Hmm. Well, the GPIOs are the same as in the old driver. However, the old
> driver doesn't even seem to check if it manages to request the GPIOs, so
> it may well be that it was failing also.
>
> Can you check from /sys/class/gpio/ if some of the GPIOs are already
> allocated: 207, 199, 55, 56?
>
> The definition of two of those GPIOs look kinda funny to me: (15 +
> OMAP_MAX_GPIO_LINES). I don't know what OMAP_MAX_GPIO_LINES means, but
> it sure doesn't sound ok to have a GPIO number that is 15 over the
> maximum =).
>

This means that some kind of gpio expander is used.
I bet those are twl gpios (or may be some other discrete chip).
If those are twl gpios then you need to provide the .setup callback
in struct twl4030_gpio_platform_data which will request and setup those gpios.


-- 
Regards,
Igor.

