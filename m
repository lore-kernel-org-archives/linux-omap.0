Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642758124E;
	Wed,  9 Sep 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970089; cv=none; b=McTES+UTezaQjw+xoUlq++L54ZYssuQQKH9LGAtWwnYUEalhflTTu3iBoMZIuODB4TjD8QamXlHjqxn4zNkn5bbumUgpAxQktFkfJDNUYXKzMwUPIH/h/F21UshJcpkn37w78JyWiUKAuxVUdQdKD0AXOnsY2IixeaZTH/LMoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970089; c=relaxed/simple;
	bh=tkaAhqeEYkEodfy8OsxfJfnG3t0wx8Y1psJJPit8mNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVZWtDsWUiyNcwgurUGj1kkuzcWi+E3O/j4TIo2fYRPqd4obF8gLDM7vXKcyR04UIBnTV7qt/uRXBUagQxD3U2t4XBsQ6ci2ko2JMiJ610oFKzgUStHo4wiLNUFd3NLoZaT4Vlz9EPOtS2He8AlY2AjK8Nb1oQosaxtsZZxMHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7WmWBti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7WmWBti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353001F00A3E;
	Wed,  9 Sep 2026 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970088;
	bh=xfh6dQwvhJNBpZKgTnhO+xK92GSq+lmModl5wWIGjuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D7WmWBtiXCIe5SG3D8cRAEjOqty4zUOe9OTItrGucs+Q9qiZSKr2RPvFHQ2nwo61q
	 hEjkiKme6f5fJwjIK9l/BFSjmkbIZ+/sq2Uw+vMrBIi5DnavUW8iiU8yOp+LHa1r6k
	 mi9AP82ugFByN5NxAB5K42b+4n7uDj9OIwtakBbrIcnV0XxN5ISJT1BjB3MRNkrxk8
	 pUalZcDKp9O8ae8CUQop9SdH+sflmHAp7lAT/rgkSV1J7JuIP0IQO4s3WXO6lOZxr4
	 3vJAlQsrkh+M3/6MQE22gS4wSszn+aU5EQDEZWvXEZ2ocFEw4Hg4cc/RpdB9FrTJ6P
	 d3qUIx1zwC0rA==
Date: Wed, 9 Sep 2026 18:07:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 4/7] phy: cpcap-usb: add DCP detection and make UART
 idle mode optional
Message-ID: <oheoylzdj3arrnfdm6747cuubllkdmg4gx7vm3zhs3owuooj4v@zdbytrztbdp4>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-5-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-5-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:07PM +0300, Ivaylo Dimitrov wrote:
> Handle DCP separately from USB host connections using CPCAP charger
> detection status.
> 
> Make the existing idle UART mode optional via the "enable_uart" module
> parameter. When disabled (default), the PHY remains in its USB/charger
> detection configuration while idle.
> 
> Also initialize the PHY into the baseline configuration required for
> reliable charger detection during probe.
> 
> Use the optional "safe" pinctrl state before switching between modes to
> avoid glitches on USB or UART lines.
> 

Looks like this change is doing multiple things at once. Please split the
changes logically to separate patches.

> Note: Enabling UART idle mode increases idle power consumption (by 25mW
> on droid4).
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> # Conflicts:
> #	drivers/phy/motorola/phy-cpcap-usb.c

What is this conflict?

> ---
>  drivers/phy/motorola/phy-cpcap-usb.c | 301 +++++++++++++++++++++------
>  1 file changed, 238 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
> index 741145c89e5b..2d770ff19e93 100644
> --- a/drivers/phy/motorola/phy-cpcap-usb.c
> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
> @@ -110,6 +110,15 @@ enum cpcap_gpio_mode {
>  	CPCAP_OTG_DM_DP,
>  };
>  
> +enum cpcap_mode {
> +	CPCAP_UNKNOWN,
> +	CPCAP_IDLE,
> +	CPCAP_CHARGER,
> +	CPCAP_USB,
> +	CPCAP_USB_HOST,
> +	CPCAP_DOCK,
> +};
> +
>  struct cpcap_phy_ddata {
>  	struct regmap *reg;
>  	struct device *dev;
> @@ -119,15 +128,19 @@ struct cpcap_phy_ddata {
>  	struct pinctrl_state *pins_ulpi;
>  	struct pinctrl_state *pins_utmi;
>  	struct pinctrl_state *pins_uart;
> +	struct pinctrl_state *pins_safe;
>  	struct gpio_desc *gpio[2];
>  	struct iio_channel *vbus;
>  	struct iio_channel *id;
>  	struct regulator *vusb;
>  	atomic_t active;
> -	unsigned int vbus_provider:1;
> -	unsigned int docked:1;
> +	enum cpcap_mode mode;
>  };
>  
> +static bool cpcap_enable_uart;
> +module_param_named(enable_uart, cpcap_enable_uart, bool, 0644);
> +MODULE_PARM_DESC(enable_uart,
> +		 "Enable UART on the USB connector while idle (increases power consumption)");

Use of module params is discouraged these days. Also, you are disabling it by
default, which could cause surprises to users who have boards wired up for debug
console. But considering that it consumes a lot of power, I think it is OK to
disable it this way. I can't think of another way to add this knob.

>  static bool cpcap_usb_vbus_valid(struct cpcap_phy_ddata *ddata)
>  {
>  	int error, value = 0;
> @@ -196,8 +209,9 @@ static int cpcap_phy_get_ints_state(struct cpcap_phy_ddata *ddata,
>  	return 0;
>  }
>  

[...]

> @@ -473,21 +559,10 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>  {
>  	int error;
>  
> -	/* Disable lines to prevent glitches from waking up mdm6600 */
> -	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
> +	error = cpcap_usb_set_safe_mode(ddata);
>  	if (error)
>  		return error;
>  
> -	if (ddata->pins_utmi) {
> -		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
> -		if (error) {
> -			dev_err(ddata->dev, "could not set usb mode: %i\n",
> -				error);
> -
> -			return error;
> -		}
> -	}
> -
>  	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC1,
>  				   CPCAP_BIT_VBUSPD, 0);
>  	if (error)
> @@ -503,11 +578,23 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>  		goto out_err;
>  
>  	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
> -				   CPCAP_BIT_USBXCVREN,
> +				   CPCAP_BIT_USBXCVREN |
> +				   CPCAP_BIT_UARTMUX0 |
> +				   CPCAP_BIT_EMUMODE0,

As Sashiko noted, you are not clearing CPCAP_BIT_USBSUSPEND bit set in
cpcap_usb_set_idle_mode().

>  				   CPCAP_BIT_USBXCVREN);
>  	if (error)
>  		goto out_err;
>  
> +	if (ddata->pins_utmi) {
> +		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
> +		if (error) {
> +			dev_err(ddata->dev, "could not set usb mode: %i\n",
> +				error);
> +
> +			return error;
> +		}
> +	}
> +
>  	/* Enable USB mode */
>  	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
>  	if (error)
> @@ -521,6 +608,38 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>  	return error;
>  }
>  
> +static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata)
> +{
> +	int error;
> +
> +	error = cpcap_usb_set_safe_mode(ddata);
> +	if (error)
> +		return error;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
> +				   CPCAP_BIT_USBXCVREN |
> +				   CPCAP_BIT_UARTMUX0 |
> +				   CPCAP_BIT_EMUMODE0, 0);
> +	if (error)
> +		goto out_err;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
> +				   CPCAP_BIT_SUSPEND_SPI, 0);
> +	if (error)
> +		goto out_err;
> +
> +	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
> +	if (error)
> +		goto out_err;
> +
> +	return 0;
> +
> +out_err:
> +	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);

Don't print function names in the error log.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
