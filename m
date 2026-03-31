Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672E3E4C6C;
	Tue, 31 Mar 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976143; cv=none; b=qUCvGm/NyGDaBQmDZtuAwbbMZ1bw9nmfDLLKA3I1SjKU6o2jzPFB7/teuNBefYpFTZc99AIBUCaltGZg06EG8csnxUOqX8YV3WAFh29bc89dMd4M19O0SdXT0N1HTCalNtcwqx/tv96mHXN5P+RQGFkg/w2WlyiR6Dg51lp+hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976143; c=relaxed/simple;
	bh=TXgnhjxpO2HR++8xpxW1ouNg5LDZYEZ5+mSZghxn69Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqwl7hGIT7B/ITPa9kxn28fc+3hkaJHHUYthTHlFnAqdBdBd8Gnl22EvReVokm7gF5z8EP57+wCn+v/eOctJK5tJWjqhv4R0BcNDxsncWoZKYiq4Cyz/ypbXbZbfffl30A/F7Emkgte0BoWD/FEVc1C/09mTsv63zQzYAi2q/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS6jyNFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS6jyNFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB58C2BCB2;
	Tue, 31 Mar 2026 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774976143;
	bh=TXgnhjxpO2HR++8xpxW1ouNg5LDZYEZ5+mSZghxn69Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jS6jyNFhDuJU1B3wxNwrFRZpCxmsLytEE2YMNKa2Gu2JYTedOUfiYZ61xXhouo15n
	 ErVH5jDUSjtI0IP6nT+x8zU2nuMMIVRJLbqdeHRZw9Y0YdEvmxOCgCDQKyE57UO2vt
	 oIrbHd1HFWcBQmjXeBu9LPzs+CPMnMozwV4qoNEUOEZ9BnzjJHuyRPBDK591hs2cSP
	 FoQw8tb8lsWr9DPmguCKMXZ57l7T3nEhd+2IZjhMEGRzAQp8TvNuKZBNLkjSVJeLMF
	 3eJ2I58hExSPnQRm+hCRfUutvWo/t5zgUtE5F5NLOdXhycYsgLER0BkSBWV8JZQxmG
	 FICAKmEP7bvgw==
Date: Tue, 31 Mar 2026 17:55:37 +0100
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
Subject: Re: [PATCH 7/8] mfd: omap-usb-host: Add pbias regulator support
Message-ID: <20260331165537.GJ3795166@google.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
 <20260323-omap4-fix-usb-support-v1-7-b668132124ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-omap4-fix-usb-support-v1-7-b668132124ac@bootlin.com>

On Mon, 23 Mar 2026, Thomas Richard wrote:

> Add pbias regulator support to enable SIM_VDDS supply and unlock USB I/O
> cell. Previously, this was handled by the bootloader, now the kernel can
> take responsibility for managing the PBIAS regulator, ensuring correct
> operation regardless of the bootloader.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/omap-usb-host.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index ac974285be341fa579ef198d1893b77af428b5f8..9e254e00183e940b775d5bde6e891f0d26af27b0 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -15,6 +15,9 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string_choices.h>
> +

?

>  
>  #include "omap-usb.h"
>  
> @@ -95,6 +98,8 @@ struct usbhs_hcd_omap {
>  	struct usbhs_omap_platform_data	*pdata;
>  
>  	u32				usbhs_rev;
> +
> +	struct regulator		*pbias;
>  };
>  /*-------------------------------------------------------------------------*/
>  
> @@ -270,6 +275,25 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
>  	}
>  }
>  
> +static int omap_usbhs_set_pbias(struct device *dev, bool power_on)
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
> @@ -278,6 +302,10 @@ static int usbhs_runtime_resume(struct device *dev)
>  
>  	dev_dbg(dev, "usbhs_runtime_resume\n");
>  
> +	r = omap_usbhs_set_pbias(dev, true);
> +	if (r)
> +		return r;
> +
>  	omap_tll_enable(pdata);
>  
>  	if (!IS_ERR(omap->ehci_logic_fck))
> @@ -355,7 +383,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>  
>  	omap_tll_disable(pdata);
>  
> -	return 0;
> +	return omap_usbhs_set_pbias(dev, false);
>  }
>  
>  static unsigned omap_usbhs_rev1_hostconfig(struct usbhs_hcd_omap *omap,
> @@ -564,6 +592,11 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  
>  	omap->pdata = pdata;
>  
> +	omap->pbias = devm_regulator_get_optional(dev, "pbias");
> +	if (IS_ERR(omap->pbias))
> +		return dev_err_probe(dev, PTR_ERR(omap->pbias),
> +				     "unable to get pbias regulator\n");

You need to check for '-ENODEV' here or you are ignoring the optional part.

> +
>  	/* Initialize the TLL subsystem */
>  	omap_tll_init(pdata);
>  
> @@ -759,6 +792,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  	}
>  
>  initialize:
> +	ret = omap_usbhs_set_pbias(dev, true);
> +	if (ret)
> +		goto err_mem;

Since this regulator is also managed by 'usbhs_runtime_resume' and
'usbhs_runtime_suspend', could manually enabling it here in probe and
disabling it in remove interfere with the reference counting during runtime
PM transitions? Should we consider relying entirely on runtime PM to manage
its state?

> +
>  	omap_usbhs_init(dev);
>  
>  	if (dev->of_node) {
> @@ -806,6 +843,8 @@ static void usbhs_omap_remove(struct platform_device *pdev)
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
Lee Jones [李琼斯]
