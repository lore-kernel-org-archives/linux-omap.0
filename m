From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add
 of_dev_auxdata to pass d_can raminit
Date: Wed, 5 Sep 2012 16:18:38 -0700
Message-ID: <20120905231837.GI1303@atomide.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <1346843564-25343-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346843564-25343-4-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* AnilKumar Ch <anilkumar@ti.com> [120905 04:14]:
> Add of_dev_auxdata to pass d_can raminit callback APIs to initialize
> d_can RAM. D_CAN RAM initialization bits are present in CONTROL module
> address space, which can be accessed by platform specific code. So
> callback functions are added to serve this purpose, this can done by
> using of_dev_auxdata.
> 
> Two callback APIs are added to of_dev_auxdata used by two instances of
> D_CAN IP. These callback functions are used to enable/disable D_CAN RAM
> from CAN driver.

I'd like to avoid the callbacks to the platform code where possible as
that's the biggest pain we already have moving things to work with device
tree for the existing drivers.

And I'm pretty convinced that whatever is done with callbacks should be
done with some Linux generic framework from the driver that has it's own
binding, such as clock framework, regulator framework, pinctrl framework,
runtime PM etc.

> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -37,11 +40,46 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> +void d_can_hw_raminit(unsigned int instance, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> +	if (enable) {
> +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> +		val |= AM33XX_DCAN_RAMINIT_START_MASK(instance);
> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> +	} else {
> +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> +	}
> +}

This part does not look good to me, this is tweaking the omap control
module register bits directly. To me it seems that the above should
be implemented in the omap/am33xx hwmod code that gets initialized when
the dcan driver calls pm_runtime_enable()? Paul, got any other ideas?

Regards,

Tony
