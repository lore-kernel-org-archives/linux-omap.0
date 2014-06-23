From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] regulator: palmas: fix typo in enable_reg calculation
Date: Mon, 23 Jun 2014 17:28:30 -0500
Message-ID: <53A8AA0E.8070705@ti.com>
References: <1403556805-22824-1-git-send-email-swarren@wwwdotorg.org>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403556805-22824-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Alex Courbot <gnurou@gmail.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/23/2014 03:53 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> When setting up .enable_reg for an SMPS regulator, presumably we should
> call PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE, ...) rather than using
> LDO_BASE. This change makes the LCD panel and HDMI work again on the
> NVIDIA Dalmore board anyway.
>
> Cc: Alex Courbot <gnurou@gmail.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Fixes: 318dbb02b50c ("regulator: palmas: Fix SMPS enable/disable/is_enabled")
> Fixes: dbabd624d4eec50b6 ("regulator: palmas: Reemove open coded functions with helper functions")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>   drivers/regulator/palmas-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
> index 3c861d5f9245..93b4ad842901 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -970,7 +970,7 @@ static int palmas_regulators_probe(struct platform_device *pdev)
>   					PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
>
>   			pmic->desc[id].enable_reg =
> -					PALMAS_BASE_TO_REG(PALMAS_LDO_BASE,
> +					PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE,
>   						palmas_regs_info[id].ctrl_addr);
>   			pmic->desc[id].enable_mask =
>   					PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
>


Uggh... my bad..

Thanks for catching this.

Acked-by: Nishanth Menon <nm@ti.com>
