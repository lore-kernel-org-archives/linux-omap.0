From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Wed, 31 Aug 2016 09:31:14 +0100
Message-ID: <20160831083114.GP10121@dell>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1bXZjd-0000YR-7n@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Aug 2016, Mark Brown wrote:

> The patch
> 
>    mfd: tps65218: add version check to the PMIC probe

Why did you take this patch?

I now have a merge conflict.

Did you provide a pull-request that I can use to resolve?

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
> From f11fa1796a4b4f8c6d4ced37e8824276ec57057d Mon Sep 17 00:00:00 2001
> From: Tero Kristo <t-kristo@ti.com>
> Date: Wed, 10 Aug 2016 17:53:54 +0530
> Subject: [PATCH] mfd: tps65218: add version check to the PMIC probe
> 
> Version information will be needed to handle some error cases under the
> regulator driver, so store the information once during MFD probe.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/tps65218.c       | 9 +++++++++
>  include/linux/mfd/tps65218.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 80b9dc363cd8..ba610adbdbff 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -219,6 +219,7 @@ static int tps65218_probe(struct i2c_client *client,
>  	struct tps65218 *tps;
>  	const struct of_device_id *match;
>  	int ret;
> +	unsigned int chipid;
>  
>  	match = of_match_device(of_tps65218_match_table, &client->dev);
>  	if (!match) {
> @@ -250,6 +251,14 @@ static int tps65218_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = tps65218_reg_read(tps, TPS65218_REG_CHIPID, &chipid);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
> +		return ret;
> +	}
> +
> +	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
> +
>  	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
>  				   &client->dev);
>  	if (ret < 0)
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
> index 7fdf5326f34e..85e464e32c43 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -267,6 +267,7 @@ struct tps_info {
>  struct tps65218 {
>  	struct device *dev;
>  	unsigned int id;
> +	u8 rev;
>  
>  	struct mutex tps_lock;		/* lock guarding the data structure */
>  	/* IRQ Data */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
