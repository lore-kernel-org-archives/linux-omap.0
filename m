From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Fri, 29 Apr 2011 17:04:09 +0300
Message-ID: <20110429170409.5ad8833b.jhnikula@gmail.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56808 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1D2OEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 10:04:13 -0400
Received: by ewy4 with SMTP id 4so1156533ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 07:04:12 -0700 (PDT)
In-Reply-To: <1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: tony@atomide.com, sakari.ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

On Fri, 29 Apr 2011 15:47:44 +0300
Kalle Jokiniemi <kalle.jokiniemi@nokia.com> wrote:

> +static struct regulator_init_data rx51_vintana1 = {
> +	.constraints = {
> +		.name			= "VINTANA1",
> +		.min_uV			= 1500000,
> +		.max_uV			= 1500000,
> +		.always_on		= true,
...
> +static struct regulator_init_data rx51_vintdig = {
> +	.constraints = {
> +		.name			= "VINTDIG",
> +		.min_uV			= 1500000,
> +		.max_uV			= 1500000,
> +		.always_on		= true,

Are these two used at all? According to public schematics they are
connected to just one capasitor. Could be some needed filtering/charge
pump capacitors for TWL though.

I was thinking are all of these regulators really always_on? How about
letting those without any known user to be switched off?

> @@ -838,6 +911,8 @@ static int __init rx51_i2c_init(void)
>  	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
>  			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
>  	omap_register_i2c_bus(3, 400, NULL, 0);
> +	regulator_has_full_constraints();
> +
>  	return 0;
>  }
>  
Move this somewhere else than in i2c initialization function :-)

-- 
Jarkko
