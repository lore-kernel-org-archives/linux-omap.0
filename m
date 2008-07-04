From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard
Date: Fri, 04 Jul 2008 09:10:51 +0200
Message-ID: <486DCCFB.9060909@googlemail.com>
References: <486DC2AF.4010401@googlemail.com> <20080704095502.a018a17a.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:49016 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbYGDHL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 03:11:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1404887rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2008 00:11:25 -0700 (PDT)
In-Reply-To: <20080704095502.a018a17a.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

Jarkko Nikula wrote:
> On Fri, 04 Jul 2008 08:26:55 +0200
> "ext Dirk Behme" <dirk.behme@googlemail.com> wrote:
> 
> 
>>- Add configuration option for this
>>- Use configuration option in board-omap3beagle
>>- Ensure correct pin mux if I2C2 is enabled, independent of settings 
>>done by bootloader
>>
> 
> Why this CONFIG_I2C2_OMAP_BEAGLE in mux.c?

Because bootloader, e.g. uboot, might have set other mux for these 
pins, e.g. GPIO168 and GPIO183.

Then, if CONFIG_MUX is enabled but I2C2 isn't, don't touch the pin mux 
done by bootloader. But if I2C2 is enabled, make sure that the correct 
mux settings are done independent of bootloader.

Do you think this is wrong?

Thanks

Dirk

> --- linux-beagle.orig/arch/arm/mach-omap2/mux.c
> +++ linux-beagle/arch/arm/mach-omap2/mux.c
> @@ -231,10 +231,12 @@ MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
> +#ifdef CONFIG_I2C2_OMAP_BEAGLE
>  MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
> +#endif
>  MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,
> 
> 

