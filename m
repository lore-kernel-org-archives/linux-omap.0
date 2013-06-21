From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH 4/4] regulator: Palmas: Add TPS659038 support
Date: Fri, 21 Jun 2013 09:08:26 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EDC8A@DBDE04.ent.ti.com>
References: <1371726135-9891-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371726135-9891-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

> -----Original Message-----
> From: J, KEERTHY
> Sent: Thursday, June 20, 2013 4:32 PM
> To: linux-omap@vger.kernel.org; sameo@linux.intel.com
> Cc: broonie@kernel.org; J, KEERTHY; ldewangan@nvidia.com;
> grant.likely@secretlab.ca; swarren@nvidia.com; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org; gg@slimlogic.co.uk
> Subject: [PATCH 4/4] regulator: Palmas: Add TPS659038 support
> 
> Add TPS659038 support.
> 

Could you pull this one too?

> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Acked-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/regulator/palmas-regulator.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/regulator/palmas-regulator.c
> b/drivers/regulator/palmas-regulator.c
> index 1ae1e83..d0c8785 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -1054,6 +1054,7 @@ static struct of_device_id of_palmas_match_tbl[]
> = {
>  	{ .compatible = "ti,tps65913-pmic", },
>  	{ .compatible = "ti,tps65914-pmic", },
>  	{ .compatible = "ti,tps80036-pmic", },
> +	{ .compatible = "ti,tps659038-pmic", },
>  	{ /* end */ }
>  };
> 
> --
> 1.7.5.4

Regards,
Keerthy
