From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Tue, 17 May 2011 15:28:13 +0300
Message-ID: <4DD269DD.8020006@compulab.co.il>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>	 <1305535980.2002.34.camel@deskari>  <4DD106BD.4070009@compulab.co.il>	 <1305632940.1847.8.camel@deskari> <1305633414.1847.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:60635
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754052Ab1EQM2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 08:28:16 -0400
In-Reply-To: <1305633414.1847.11.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On 05/17/11 14:56, Tomi Valkeinen wrote:
> On Tue, 2011-05-17 at 14:49 +0300, Tomi Valkeinen wrote:
>> On Mon, 2011-05-16 at 14:13 +0300, Igor Grinberg wrote:
>>> On 05/16/11 11:53, Tomi Valkeinen wrote:
>>>> +static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
>>>> +{
>>>> +	int r;
>>>> +
>>>> +	struct gpio gpios[] = {
>>>> +		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
>>>> +		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
>>>> +	};
>>>> +
>>>> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
>>>> +	if (r)
>>>> +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
>>>> +
>>>> +	ldp_backlight_gpio = gpio + 15;
>>>> +	ldp_lcd_enable_gpio = gpio + 7;
>>> If the gpio_request_array() fails (though it shouldn't),
>>> won't it be right to set both variables to -EINVAL?
>> Ah, yes. I'll fix that.
>>
>> Do you know what will happen if twl_gpio_setup fails? Just an error
>> print, or will TWL driver fail?

I'm currently based on Tony's devel-cleanup branch (which is v2.6.39-rc4-...)
this is what twl4030-gpio.c does:

status = pdata->setup(&pdev->dev,
                pdata->gpio_base, TWL4030_GPIO_MAX);
if (status)
            dev_dbg(&pdev->dev, "setup --> %d\n", status);

so yes it is just an error print.

> And I wonder if gpio_is_valid() works correctly for GPIOs from an gpio
> expander? With a quick search, gpio_is_valid returns true if gpio is
> between [0, 256[, and doesn't care if there are gpio expanders or not...

Right, a sanity check only...
I guess each time 256 is not enough it just gets bumped up...
This can be a problem some day...
May be it should be a part of struct gpio_chip so the responsibility for
gpio validity will be on the driver in charge of that gpio?
But that is totally different discussion.

Regarding:

> We still don't know if it works or not =).

I thought Mayuresh checked this and confirmed, no?



-- 
Regards,
Igor.

