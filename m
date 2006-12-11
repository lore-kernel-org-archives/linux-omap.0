From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C-1 init fix for 2430
Date: Mon, 11 Dec 2006 13:46:40 -0800
Message-ID: <20061211214639.GJ6693@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE14@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE14@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061203 12:35]:
> Hi,
> 
>  
> 
> The attached patch fixes/enables the I2C-1 for OMAP2430. 
> 
>  
> 
> Regards,
> 
> Khasim
> 

Content-Description: 2430_i2cinit_fix.patch
> I2C-1 for 2430 was commented previously, enabled in this patch.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  devices.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> =============================================================================
> diff -purN linux-omap/arch/arm/plat-omap/devices.c devpt_branch/arch/arm/plat-omap/devices.c
> --- linux-omap/arch/arm/plat-omap/devices.c	2006-11-28 09:59:29.000000000 -0600
> +++ devpt_branch/arch/arm/plat-omap/devices.c	2006-12-03 11:53:40.000000000 -0600
> @@ -136,8 +136,10 @@ static void omap_init_i2c(void)
>  	 * it can include clocking and address info, maybe more.
>  	 */
>  	if (cpu_is_omap24xx()) {
> -		omap_cfg_reg(M19_24XX_I2C1_SCL);
> -		omap_cfg_reg(L15_24XX_I2C1_SDA);
> +		if(machine_is_omap_h4()){
> +			omap_cfg_reg(M19_24XX_I2C1_SCL);
> +			omap_cfg_reg(L15_24XX_I2C1_SDA);
> +		}
>  	} else {
>  		omap_cfg_reg(I2C_SCL);
>  		omap_cfg_reg(I2C_SDA);
> @@ -501,13 +503,13 @@ static int __init omap_init_devices(void
>  	 * in alphabetical order so they're easier to sort through.
>  	 */
>  	omap_init_dsp();
> -	omap_init_i2c();
>  	omap_init_kp();
>  	omap_init_mmc();
>  	omap_init_uwire();
>  	omap_init_wdt();
>  	omap_init_rng();
>  #endif
> +	omap_init_i2c();
>  	return 0;
>  }
>  arch_initcall(omap_init_devices);

Pushing today.

Tony
