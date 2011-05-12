From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 14:20:19 +0300
Message-ID: <4DCBC273.9030807@compulab.co.il>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com> <1305095563.2097.11.camel@deskari> <4DCB80DD.5090408@compulab.co.il> <4DCB8937.2060101@compulab.co.il> <4DCB9C71.2020503@compulab.co.il> <EAF47CD23C76F840A9E7FCE10091EFAB033DBC13C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:34389
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752214Ab1ELLUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:20:23 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC13C0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On 05/12/11 11:47, Janorkar, Mayuresh wrote:

>> On 05/12/11 10:16, Igor Grinberg wrote:
>> there is a typo in the function name:
>> s/ldp_twl_gpio_setup/ldp_twl_gpios_setup/
> Also,
>> +	};
>> +
>> +	r = gpio_request_array(twl_gpios, ARRAY_SIZE(gpios));
> This should be ARRAY_SIZE(twl_gpios));

yeah, sorry for that

that is what happening when making patches in a hurry and no checks done

> And one more thing:
> We need to use regulator for OMAP3430.
>
>
> Something like this:
> +/* VPLL2 for digital video outputs */
> +static struct regulator_consumer_supply ldp_vpll2_supplies[] = {
> +        REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +        REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> +};
> +
> +static struct regulator_init_data ldp_vpll2 = {
> +        .constraints = {
> +                .name                   = "VDVI",
> +                .min_uV                 = 1800000,
> +                .max_uV                 = 1800000,
> +                .apply_uV               = true,
> +                .valid_modes_mask       = REGULATOR_MODE_NORMAL
> +                                        | REGULATOR_MODE_STANDBY,
> +                .valid_ops_mask         = REGULATOR_CHANGE_MODE
> +                                        | REGULATOR_CHANGE_STATUS,
> +        },
> +        .num_consumer_supplies  = ARRAY_SIZE(ldp_vpll2_supplies),
> +        .consumer_supplies      = ldp_vpll2_supplies,
> +};
>
> @@ -340,6 +514,7 @@ static struct twl4030_platform_data ldp_twldata = {
>         .vmmc1          = &ldp_vmmc1,
>         .gpio           = &ldp_gpio_data,
>         .keypad         = &ldp_kp_twl4030_data,
> +       .vpll2          = &ldp_vpll2,
>

Right. Do both fixes make it work?

If it is, then Tomi,
will you add both fixes to the patch set with our SOBs?
or do you want this to be sent properly as a follow up?

-- 
Regards,
Igor.

