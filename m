From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] mfd: twl4030-power: use 'ti,system-power-controller'
 as alternative way to support system power off
Date: Mon, 8 Sep 2014 17:01:26 -0700
Message-ID: <20140909000126.GU3238@atomide.com>
References: <1409771208-21867-1-git-send-email-nm@ti.com>
 <1409771208-21867-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409771208-21867-3-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140903 12:07]:
> ti,system-power-controller is more or less the standard way of
> indicating that the PMIC is the system wide power controller and hence
> may be used to switch off the system. Almost ALL TI PMIC drivers and
> many Maxim PMIC drivers follow the same style.
> 
> So support 'ti,system-power-controller' in addition to the usual
> 'ti,use_poweroff' to indicate that the PMIC instance has control for
> switching off the system.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mfd/twl4030-power.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 3bc969a..1c129ba 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -627,6 +627,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
>  	if (pdata && pdata->use_poweroff)
>  		return true;
>  
> +	if (of_property_read_bool(node, "ti,system-power-controller"))
> +		return true;
> +
>  	if (of_property_read_bool(node, "ti,use_poweroff"))
>  		return true;
>  
> -- 
> 1.7.9.5
> 
