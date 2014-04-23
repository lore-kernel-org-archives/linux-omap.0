From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH 3/3] usb: dwc3-exynos: Make provision for vdd regulators
Date: Wed, 23 Apr 2014 18:26:51 +0900
Message-ID: <00bf01cf5ed6$28de18d0$7a9a4a70$%tikhomirov@samsung.com>
References: <1398082604-3013-1-git-send-email-gautam.vivek@samsung.com>
 <1398082604-3013-3-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41786 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbaDWJ0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 05:26:53 -0400
In-reply-to: <1398082604-3013-3-git-send-email-gautam.vivek@samsung.com>
Content-language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, balbi@ti.com, kgene.kim@samsung.com

Hello,

> -----Original Message-----
> From: Vivek Gautam [mailto:gautamvivek1987@gmail.com] On Behalf Of
> Vivek Gautam
> Sent: Monday, April 21, 2014 9:17 PM
> To: linux-usb@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; gregkh@linuxfoundation.org;
> stern@rowland.harvard.edu; balbi@ti.com; kgene.kim@samsung.com; Vivek
> Gautam; Anton Tikhomirov
> Subject: [PATCH 3/3] usb: dwc3-exynos: Make provision for vdd
> regulators
> 
> Facilitate getting required 3.3V and 1.0V VDD supply for
> DWC3 controller on Exynos.
> 
> With patches for regulators' nodes merged in 3.15:
> c8c253f ARM: dts: Add regulator entries to smdk5420
> 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
> 
> certain perripherals will now need to ensure that,
> they request VDD regulators in their drivers, and enable
> them so as to make them working.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Anton Tikhomirov <av.tikhomirov@samsung.com>
> ---
> 
> Based on 'usb-next' branch of Greg's USB tree.
> Also cleanly applies on 'next' branch of Balbi's USB tree.
> 
>  drivers/usb/dwc3/dwc3-exynos.c |   51
> ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-
> exynos.c
> index 28c8ad7..c9d9102 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -27,6 +27,7 @@
>  #include <linux/usb/usb_phy_gen_xceiv.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
> 
>  struct dwc3_exynos {
>  	struct platform_device	*usb2_phy;
> @@ -34,6 +35,8 @@ struct dwc3_exynos {
>  	struct device		*dev;
> 
>  	struct clk		*clk;
> +	struct regulator	*vdd33;
> +	struct regulator	*vdd10;
>  };
> 
>  static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
> @@ -144,20 +147,46 @@ static int dwc3_exynos_probe(struct
> platform_device *pdev)
> 
>  	clk_prepare_enable(exynos->clk);
> 
> +	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
> +	if (IS_ERR(exynos->vdd33)) {
> +		ret = PTR_ERR(exynos->vdd33);
> +		goto err2;

Is regulator property mandatory for dwc3-exynos? If it is not
and device tree doesn't provide it, dwc3-exynos driver probe shouldn't
fail here.

> +	}
> +	ret = regulator_enable(exynos->vdd33);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable VDD33 supply\n");
> +		goto err2;
> +	}
> +

Thanks

