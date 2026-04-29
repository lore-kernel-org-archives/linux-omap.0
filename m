Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB913B7AE;
	Wed, 29 Apr 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467970; cv=none; b=jfrdyG7A9PIehkSwt6fe0ChePM9v9xhTDJtzOLo9EkYUqQBEc8859MyjcM7VNho8xWCv8SrqT5DH9RlIICHgLX34/w1RxX7jyX1P9m7Ffr6gh0byLKdd86lvrG7Hs6AGfAFk48fLTzS2KE9ZwDwb2hiQfQ9dLTAk7ENp33RhKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467970; c=relaxed/simple;
	bh=5KMpFDl8SEteyr8jXAJyWJJp/ZQzUTISl/L62zpYe4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPdl0zxY98LKpsjotUdyvqqghLgU2SpnSd/WeBM48fxQ6ZNMHmZGOxz3c5a6FSElTC0e+UmqnPhEhSSFu0q9L5kIG5dPeQRcRvihA6GKodNIicDbp/hHlybWk7H/ef4JusbojoWDgl/fibmmUQk0cGH5gCVSfXe2X1dS+kurZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9mAQn8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9mAQn8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008ADC19425;
	Wed, 29 Apr 2026 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777467969;
	bh=5KMpFDl8SEteyr8jXAJyWJJp/ZQzUTISl/L62zpYe4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9mAQn8DTmvS9vN3IVYNGlXzcYvxmx4OH6lOx4Y8241yrqgSoHz0A0nH2fOVk/7bc
	 af7adFgkmTPyJuytewWA18RS46wSBOnn6Nykv6cu0DXkrfWnt0PGVj1VwhgsyT5y0e
	 zeSeDa+DejFYYBDl6RzubfjQdOonUxGQcY+gB+hk1U11mX9aIHfhONIjOIPzr1JhfS
	 VoCPLijRzjdYIMK+ATVneoGbgbkGIGCQ1mv1Ig0qdSRrWMTeGYqtQrWjmRN2tExYzB
	 waGMgmhpPrV98f6FDRO0xH0/1EeNgrz1KuGuK/vCUk8Al9ZS+79aWS8LFItUV/Vfyq
	 vyhcGi6Tfo95w==
Date: Wed, 29 Apr 2026 14:06:04 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 10/11] mfd: omap-usb-host: Add pbias regulator support
Message-ID: <20260429130604.GD1806155@google.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-10-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-omap4-fix-usb-support-v2-10-1c1e11b190dc@bootlin.com>

On Mon, 30 Mar 2026, Thomas Richard wrote:

> Add pbias regulator support to enable SIM_VDDS supply and unlock USB I/O
> cell. Previously, this was handled by the bootloader, now the kernel can
> take responsibility for managing the PBIAS regulator, ensuring correct
> operation regardless of the bootloader.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/omap-usb-host.c | 55 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 17a54f0087c3..907fb614d464 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -15,6 +15,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string_choices.h>
>  
>  #include "omap-usb.h"
>  
> @@ -95,6 +97,8 @@ struct usbhs_hcd_omap {
>  	struct usbhs_omap_platform_data	*pdata;
>  
>  	u32				usbhs_rev;
> +
> +	struct regulator		*pbias;
>  };
>  /*-------------------------------------------------------------------------*/
>  
> @@ -334,26 +338,60 @@ static int usbhs_clocks_enable(struct device *dev, bool enable)
>  	return r;
>  }
>  
> +static int omap_usbhs_set_pbias(struct device *dev, bool power_on)

I think this is a little over-engineered as well.

I'm willing to bet that it saves ~0 LoC.

> +{
> +	struct usbhs_hcd_omap *omap = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!omap->pbias)
> +		return 0;
> +
> +	if (power_on)
> +		ret = regulator_enable(omap->pbias);
> +	else
> +		ret = regulator_disable(omap->pbias);
> +
> +	if (ret)
> +		dev_err(dev, "pbias reg %s failed\n", str_enable_disable(power_on));
> +
> +	return ret;
> +}
> +
>  static int usbhs_runtime_resume(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
>  	struct usbhs_omap_platform_data	*pdata = omap->pdata;
> +	int ret;
>  
>  	omap_tll_enable(pdata);
>  
> -	return usbhs_clocks_enable(dev, true);
> +	ret = usbhs_clocks_enable(dev, true);
> +	if (ret)
> +		return ret;
> +
> +	return omap_usbhs_set_pbias(dev, true);

... but if you _insist_ on doing it this way, at least define the true
to something meaningful.

>  }
>  
>  static int usbhs_runtime_suspend(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
>  	struct usbhs_omap_platform_data	*pdata = omap->pdata;
> +	int ret;
>  
>  	usbhs_clocks_enable(dev, false);
>  
>  	omap_tll_disable(pdata);
>  
> +	ret = omap_usbhs_set_pbias(dev, false);
> +	if (ret)
> +		goto err;
> +
>  	return 0;
> +
> +err:
> +	omap_tll_enable(pdata);
> +	usbhs_clocks_enable(dev, true);
> +	return ret;
>  }
>  
>  static unsigned omap_usbhs_rev1_hostconfig(struct usbhs_hcd_omap *omap,
> @@ -562,6 +600,15 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  
>  	omap->pdata = pdata;
>  
> +	omap->pbias = devm_regulator_get_optional(dev, "pbias");
> +	if (IS_ERR(omap->pbias)) {
> +		if (PTR_ERR(omap->pbias) == -ENODEV)
> +			omap->pbias = NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(omap->pbias),
> +					     "unable to get pbias regulator\n");
> +	}
> +
>  	/* Initialize the TLL subsystem */
>  	omap_tll_init(pdata);
>  
> @@ -757,6 +804,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  	}
>  
>  initialize:
> +	ret = omap_usbhs_set_pbias(dev, true);
> +	if (ret)
> +		goto err_mem;
> +
>  	omap_usbhs_init(dev);
>  
>  	if (dev->of_node) {
> @@ -804,6 +855,8 @@ static void usbhs_omap_remove(struct platform_device *pdev)
>  		of_platform_depopulate(&pdev->dev);
>  	else
>  		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
> +
> +	omap_usbhs_set_pbias(&pdev->dev, false);
>  }
>  
>  static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
