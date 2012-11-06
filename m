From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: OMAP: voltage: move voltdm_reset to
 platform_data header
Date: Tue, 6 Nov 2012 10:49:36 -0800
Message-ID: <20121106184935.GL6801@atomide.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
 <1352127734-30103-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352127734-30103-5-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [121105 07:04]:
> Move voltdm_reset to include/linux/platform_data/voltage-omap.h
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.h              |    1 -
>  include/linux/platform_data/voltage-omap.h |    1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index af9d469..0665f21 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -149,5 +149,4 @@ int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
>  int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
>  			  int (*fn)(struct voltagedomain *voltdm,
>  				    struct powerdomain *pwrdm));
> -void voltdm_reset(struct voltagedomain *voltdm);
>  #endif
> diff --git a/include/linux/platform_data/voltage-omap.h b/include/linux/platform_data/voltage-omap.h
> index 5be4d5d..4eb3d43 100644
> --- a/include/linux/platform_data/voltage-omap.h
> +++ b/include/linux/platform_data/voltage-omap.h
> @@ -36,4 +36,5 @@ int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
>  unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
>  struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
>  		unsigned long volt);
> +void voltdm_reset(struct voltagedomain *voltdm);
>  #endif

The include/linux/platform_data/voltage-omap.h should only contain
pure platform_data, these should internal defines to the driver.

Looks like there are other things there too that's not platform data:

struct voltagedomain *voltdm_lookup(const char *name);
int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
		unsigned long volt);

Can you please add a patch fixing that ASAP?

Thanks,

Tony
