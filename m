From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: OMAP2+: Create dummy platform_device for
 pm33xx
Date: Mon, 3 Jul 2017 18:58:44 +0200
Message-ID: <20170703165844.GD27842@localhost>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-6-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519200438.9502-6-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 19, 2017 at 03:04:38PM -0500, Dave Gerlach wrote:
> Add amx3_common_pm_init to create a dummy platform_device for
> pm33xx so that our pm33xx module can probe and am335x and am437x
> platforms to enable basic suspend to mem and standby support.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

> +void __init amx3_common_pm_init(void)
> +{
> +	struct platform_device_info devinfo = { };

You should make sure devinfo is zeroed, and also set .id to -1. 

> +	struct am33xx_pm_platform_data *pdata;
> +
> +	pdata = am33xx_pm_get_pdata();
> +	devinfo.name = "pm33xx";
> +	devinfo.data = pdata;
> +	devinfo.size_data = sizeof(*pdata);
> +	platform_device_register_full(&devinfo);
> +}

Johan
