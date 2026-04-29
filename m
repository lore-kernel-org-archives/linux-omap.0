Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FF33D50F;
	Wed, 29 Apr 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467594; cv=none; b=pEBU6KoSwq5tBJwAFnxIUWw8sovOWUdAfEiYqxZyABMf5mgaAN1Ok4B0+dXE7T11TcfldzfrSLl15bU80NpF1KCtXbvqhzCszzNkPJ2/tPU2tmYABU9oZglta/AOtoRVHPNyDpJPUdDpHil4OxJ98L7YZSNPtLUgaDTxRS/UNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467594; c=relaxed/simple;
	bh=itCUdp0qfhOdoXs3RS0X/frBVYWTq7r2bblSxigHR2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9h+2xwhC14ABeua70dvMtTnEpqlTsOzglsbGeUzE4dQMDaLMjeHjzvDdpWLWE1kpQDtLEVZy0VA5TcZPjQUsMCTf4sw9sD6+sEDcfEERr7ESMNnG1rnfNFz+q3dibVUQ1bQNSuuZIh3zjCg79DBPqrNNy23EH8tOAo8sbo10lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njTTQiDz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njTTQiDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217ECC19425;
	Wed, 29 Apr 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777467594;
	bh=itCUdp0qfhOdoXs3RS0X/frBVYWTq7r2bblSxigHR2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njTTQiDzekZrnVdrEhDG7C/is7kE5Aid5Pg9sA8ucky/yyopcdoL8qK5t4lbgV4j8
	 Z7OsLw/ZO/e1X5+ehQD/se+iCdIKIttecFNkxx8ciWpJIC3zFDhxPn80wDVrz5MnoY
	 dECTKHcv93VrVZFUaY2Lb2p5Fdy6PH82TfnnJ1vXtJivkwtE4TFyovO2/rnB1XiU5v
	 pEO/Q1jZEuUZEq0cm6cXRgE1VGwaXsWS3t6xIUX3PFTPiXwCcwqzlGuhrgCJ0BjQBx
	 VPiUFa8DZ3ZACs75EFu0ZwNks8HZmk4cWjDhhODv7Bs4+PeryvrNprDWvciFY+I33+
	 vLcSCQ9CIkmNQ==
Date: Wed, 29 Apr 2026 13:59:48 +0100
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
Subject: Re: [PATCH v2 07/11] mfd: omap-usb-host: Refactor suspend and resume
 callbacks
Message-ID: <20260429125948.GC1806155@google.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-7-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-omap4-fix-usb-support-v2-7-1c1e11b190dc@bootlin.com>

On Mon, 30 Mar 2026, Thomas Richard wrote:

> The clock handling logic in suspend and resume callbacks is very similar.
> Create a new usbhs_clocks_enable() function to avoid code duplication.
> Also remove ftrace-like debug messages.

They're not similar at all - they use opposing calls.

Bundling them up like this makes them _more_ complicated and hurts readability IMHO.

> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/omap-usb-host.c | 94 ++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index ac974285be34..17a54f0087c3 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -270,48 +270,56 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
>  	}
>  }
>  
> -static int usbhs_runtime_resume(struct device *dev)
> +static int usbhs_clocks_enable(struct device *dev, bool enable)
>  {
> -	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
> -	struct usbhs_omap_platform_data	*pdata = omap->pdata;
> -	int i, r;
> -
> -	dev_dbg(dev, "usbhs_runtime_resume\n");
> +	struct usbhs_hcd_omap *omap = dev_get_drvdata(dev);
> +	struct usbhs_omap_platform_data *pdata = omap->pdata;
> +	int r = 0, i;
>  
> -	omap_tll_enable(pdata);
> -
> -	if (!IS_ERR(omap->ehci_logic_fck))
> -		clk_prepare_enable(omap->ehci_logic_fck);
> +	if (!enable && !IS_ERR(omap->ehci_logic_fck))
> +		clk_disable_unprepare(omap->ehci_logic_fck);
>  
>  	for (i = 0; i < omap->nports; i++) {
>  		switch (pdata->port_mode[i]) {
>  		case OMAP_EHCI_PORT_MODE_HSIC:
>  			if (!IS_ERR(omap->hsic60m_clk[i])) {
> -				r = clk_prepare_enable(omap->hsic60m_clk[i]);
> -				if (r) {
> -					dev_err(dev,
> -					 "Can't enable port %d hsic60m clk:%d\n",
> -					 i, r);
> +				if (enable) {
> +					r = clk_prepare_enable(omap->hsic60m_clk[i]);
> +					if (r) {
> +						dev_err(dev,
> +							"Can't enable port %d hsic60m clk:%d\n",
> +							i, r);
> +					}
> +				} else {
> +					clk_disable_unprepare(omap->hsic60m_clk[i]);
>  				}
>  			}
>  
>  			if (!IS_ERR(omap->hsic480m_clk[i])) {
> -				r = clk_prepare_enable(omap->hsic480m_clk[i]);
> -				if (r) {
> -					dev_err(dev,
> -					 "Can't enable port %d hsic480m clk:%d\n",
> -					 i, r);
> +				if (enable) {
> +					r = clk_prepare_enable(omap->hsic480m_clk[i]);
> +					if (r) {
> +						dev_err(dev,
> +							"Can't enable port %d hsic480m clk:%d\n",
> +							i, r);
> +					}
> +				} else {
> +					clk_disable_unprepare(omap->hsic480m_clk[i]);
>  				}
>  			}
>  			fallthrough;	/* as HSIC mode needs utmi_clk */
>  
>  		case OMAP_EHCI_PORT_MODE_TLL:
>  			if (!IS_ERR(omap->utmi_clk[i])) {
> -				r = clk_prepare_enable(omap->utmi_clk[i]);
> -				if (r) {
> -					dev_err(dev,
> -					 "Can't enable port %d clk : %d\n",
> -					 i, r);
> +				if (enable) {
> +					r = clk_prepare_enable(omap->utmi_clk[i]);
> +					if (r) {
> +						dev_err(dev,
> +							"Can't enable port %d clk : %d\n",
> +							i, r);
> +					}
> +				} else {
> +					clk_disable_unprepare(omap->utmi_clk[i]);
>  				}
>  			}
>  			break;
> @@ -320,38 +328,28 @@ static int usbhs_runtime_resume(struct device *dev)
>  		}
>  	}
>  
> -	return 0;
> +	if (enable && !IS_ERR(omap->ehci_logic_fck))
> +		r = clk_prepare_enable(omap->ehci_logic_fck);
> +
> +	return r;
>  }
>  
> -static int usbhs_runtime_suspend(struct device *dev)
> +static int usbhs_runtime_resume(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
>  	struct usbhs_omap_platform_data	*pdata = omap->pdata;
> -	int i;
>  
> -	dev_dbg(dev, "usbhs_runtime_suspend\n");
> -
> -	for (i = 0; i < omap->nports; i++) {
> -		switch (pdata->port_mode[i]) {
> -		case OMAP_EHCI_PORT_MODE_HSIC:
> -			if (!IS_ERR(omap->hsic60m_clk[i]))
> -				clk_disable_unprepare(omap->hsic60m_clk[i]);
> +	omap_tll_enable(pdata);
>  
> -			if (!IS_ERR(omap->hsic480m_clk[i]))
> -				clk_disable_unprepare(omap->hsic480m_clk[i]);
> -			fallthrough;	/* as utmi_clks were used in HSIC mode */
> +	return usbhs_clocks_enable(dev, true);
> +}
>  
> -		case OMAP_EHCI_PORT_MODE_TLL:
> -			if (!IS_ERR(omap->utmi_clk[i]))
> -				clk_disable_unprepare(omap->utmi_clk[i]);
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> +static int usbhs_runtime_suspend(struct device *dev)
> +{
> +	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
> +	struct usbhs_omap_platform_data	*pdata = omap->pdata;
>  
> -	if (!IS_ERR(omap->ehci_logic_fck))
> -		clk_disable_unprepare(omap->ehci_logic_fck);
> +	usbhs_clocks_enable(dev, false);
>  
>  	omap_tll_disable(pdata);
>  
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
