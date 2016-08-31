From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs" to the regulator tree
Date: Wed, 31 Aug 2016 16:01:15 +0100
Message-ID: <20160831150115.GP9415@dell>
References: <1466412218-5906-9-git-send-email-j-keerthy@ti.com>
 <E1bXZja-0000XE-A6@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1bXZja-0000XE-A6@debutante>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Aug 2016, Mark Brown wrote:

> The patch
> 
>    regulator: tps65218: do not disable DCDC3 during poweroff on broken PMICs

Looks like I also need this patch.

Would you be kind enough to shoot me a pull-request please?

> has been applied to the regulator tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From 23a34f9d03a5d40a6234855bc069da370708cc9e Mon Sep 17 00:00:00 2001
> From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Date: Wed, 10 Aug 2016 17:53:55 +0530
> Subject: [PATCH] regulator: tps65218: do not disable DCDC3 during poweroff on
>  broken PMICs
> 
> Some versions of tps65218 do not seem to support poweroff modes properly
> if DCDC3 regulator is shut-down. Thus, keep it enabled even during
> poweroff if the version info matches the broken silicon revision.
> 
> Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/regulator/tps65218-regulator.c | 8 ++++++++
>  include/linux/mfd/tps65218.h           | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
> index d1e631d64a20..eb0f5b13841a 100644
> --- a/drivers/regulator/tps65218-regulator.c
> +++ b/drivers/regulator/tps65218-regulator.c
> @@ -180,6 +180,14 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
>  	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
>  		return -EINVAL;
>  
> +	/*
> +	 * Certain revisions of TPS65218 will need to have DCDC3 regulator
> +	 * enabled always, otherwise an immediate system reboot will occur
> +	 * during poweroff.
> +	 */
> +	if (rid == TPS65218_DCDC_3 && tps->rev == TPS65218_REV_2_1)
> +		return 0;
> +
>  	if (!tps->info[rid]->strobe) {
>  		if (rid == TPS65218_DCDC_3)
>  			tps->info[rid]->strobe = 3;
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
> index 85e464e32c43..d1db9527fab5 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -63,6 +63,11 @@
>  #define TPS65218_CHIPID_CHIP_MASK	0xF8
>  #define TPS65218_CHIPID_REV_MASK	0x07
>  
> +#define TPS65218_REV_1_0		0x0
> +#define TPS65218_REV_1_1		0x1
> +#define TPS65218_REV_2_0		0x2
> +#define TPS65218_REV_2_1		0x3
> +
>  #define TPS65218_INT1_VPRG		BIT(5)
>  #define TPS65218_INT1_AC		BIT(4)
>  #define TPS65218_INT1_PB		BIT(3)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
