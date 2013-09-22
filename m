From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Sun, 22 Sep 2013 22:22:31 +0400
Message-ID: <523F3567.80303@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-9-git-send-email-rogerq@ti.com>
Sender: linux-ide-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 09/19/2013 05:05 PM, Roger Quadros wrote:

> From: Balaji T K <balajitk@ti.com>

> Some platforms have a PHY hooked up to the
> SATA controller. The PHY needs to be initialized
> and powered up for SATA to work. We do that
> using the PHY framework.

> [Roger Q] Cleaned up.

> CC: Tejun Heo <tj@kernel.org>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
[...]

> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 1145637..94484cb 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -37,6 +37,7 @@
>
>   #include <linux/clk.h>
>   #include <linux/libata.h>
> +#include <linux/phy/phy.h>

struct phy;

should suffice.

> @@ -322,6 +323,7 @@ struct ahci_host_priv {
>   	u32			em_buf_sz;	/* EM buffer size in byte */
>   	u32			em_msg_type;	/* EM message type */
>   	struct clk		*clk;		/* Only for platforms supporting clk */
> +	struct phy		*phy;		/* If platforms use phy */
>   	void			*plat_data;	/* Other platform data */
>   };
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 2daaee0..f812ffa 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/libata.h>
>   #include <linux/ahci_platform.h>
> +#include <linux/phy/phy.h>

    Why include it from both ahci.h and here?

>   #include "ahci.h"
>
>   static void ahci_host_stop(struct ata_host *host);
> @@ -141,16 +142,32 @@ static int ahci_probe(struct platform_device *pdev)
>   		}
>   	}
>
> +	hpriv->phy = devm_phy_get(dev, "sata-phy");
> +	if (IS_ERR(hpriv->phy)) {
> +		dev_err(dev, "can't get phy\n");

    Don't think it's a good idea to complain about missing PHY when the driver 
doesn't even use it.

> +		/* return only if -EPROBE_DEFER */
> +		if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
> +			rc = -EPROBE_DEFER;
> +			goto disable_unprepare_clk;
> +		}
> +	}
> +
>   	/*
>   	 * Some platforms might need to prepare for mmio region access,
>   	 * which could be done in the following init call. So, the mmio
>   	 * region shouldn't be accessed before init (if provided) has
>   	 * returned successfully.
>   	 */
> +
> +	if (!(IS_ERR(hpriv->phy))) {

    () not needed around IS_ERR() invocation.

> +		phy_init(hpriv->phy);
> +		phy_power_on(hpriv->phy);
> +	}
> +

    I think this is misplaced, i.e. it should precede the comment.

>   	if (pdata && pdata->init) {
>   		rc = pdata->init(dev, hpriv->mmio);
>   		if (rc)
> -			goto disable_unprepare_clk;
> +			goto disable_phy;
>   	}
>
>   	ahci_save_initial_config(dev, hpriv,
[...]
> @@ -328,6 +356,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
>   static const struct of_device_id ahci_of_match[] = {
>   	{ .compatible = "snps,spear-ahci", },
>   	{ .compatible = "snps,exynos5440-ahci", },
> +	{ .compatible = "snps,dwc-ahci", },

    Looks like the binding documentation is incomplete -- it doesn't list 
"snps,exynos5440-ahci"...

WBR, Sergei

