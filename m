From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/4] mfd: omap: control: core system
	control driver
Date: Wed, 8 Aug 2012 07:05:07 -0700
Message-ID: <20120808140507.GF11011@atomide.com>
References: <500FD2EC.7060208@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <500FD2EC.7060208@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120725 04:10]:
> +
> +u32 omap_control_status_read(void)
> +{
> +	return __raw_readl(omap_control_base);
> +}

Ah OK it's changed here.. Sorry I was looking at the older
version.

> +void __init of_omap_control_init(const struct of_device_id *matches)
> +{
> +	struct device_node *np;
> +	struct property *pp = 0;
> +
> +	for_each_matching_node(np, matches) {
> +		pp = of_find_property(np, "reg", NULL);
> +		if(pp) {
> +			omap_control_phys_base = (unsigned long)be32_to_cpup(pp->value);
> +			omap_control_mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
> +			/*
> +			 * Map control module register CONTROL_STATUS register:
> +			 * omap24xx - OMAP24XX_CONTROL_STATUS
> +			 * am33xx   - AM33XX_CONTROL_STATUS
> +			 * omap34xx - OMAP343X_CONTROL_STATUS
> +			 * omap44xx - OMAP4_CTRL_MODULE_CORE_STATUS
> +			 * omap54xx - OMAP5XXX_CONTROL_STATUS
> +			 */
> +			omap_control_base = ioremap(omap_control_phys_base, omap_control_mapsize);
> +		}
> +	}
> +}

You should probably add a function for setting omap_control_base
separately from *set_globals* in arch/arm/mach-omap2/common.c.
That way it's initialized early for id.c, and you can initialize
everything else later as regular device drivers.

FYI, we want to initialize as much as possible late so we have
proper debugging console set up in case things go wrong.

Regards,

Tony
