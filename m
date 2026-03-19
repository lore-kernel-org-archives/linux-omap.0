Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513883BC678;
	Thu, 19 Mar 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919454; cv=none; b=MGkZAe1/NCqCERJPhCZCc3Jkpa8FGwIxOl48vz7zUdgd1udnqkVr7BN9pVw7MuozGtnpsoB3wAgBXYd9IftVhoVbdKJa9mJQfwrCfKZ/U9tKrrXZEqgQ3v/TWOdgh4fWZz3yj8uAP9RhAX0E8Se0NWQRKpEN08iqZq0GLwHWiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919454; c=relaxed/simple;
	bh=qyYfHN3/rEddBDUxIvXPa1XmaXZUY9tQUYPYQxlmioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFp4OwPAxkK5mEe25uPOdgY8ssLJonHoP0DbVApidTA7v6CzMYrUdriXMj2DX/nwotFFs6vpHtuM+itnHZN6YD8D2Wr1MIzjvuOFPuwL0Xk7oDzJccQUtmsn/cuYlJScrXNnGChb920GY/2A4cQpK79R3jF6nG9ffdAacOzXwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql9sZNAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql9sZNAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13790C19424;
	Thu, 19 Mar 2026 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773919454;
	bh=qyYfHN3/rEddBDUxIvXPa1XmaXZUY9tQUYPYQxlmioI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ql9sZNAJ5IJDjLCE93U34vjaePEdQ7ctkWPb/kks8sNCMuk+0pfl/hPLsUo7j54T4
	 bsbKOtQNUkMuhWfl9eHcdrNWA1jeHqW4N8v8IdEjs/7H1vsZRpMbIEirhEUa7TE7x+
	 sZDfX2SdQ3BMx7DAUNnY3muvx1eEoRo6WfAxXQDk+AuBE5JnSA7RY41EapzfUCxeDU
	 82sSgkOCGnJba1aFvm0S77EWd9d3+jzwiKjXruyui57pXMVZiO9GjbvfxgJACffHuV
	 h+qr+TQHZ4C4Lh4LcGt1u8361xGnHVQ5fZzPOFDBQRXegb/zASSzKNJi0O1g6C8BKj
	 WxHrDSZ1X6oZA==
Date: Thu, 19 Mar 2026 11:24:05 +0000
From: Lee Jones <lee@kernel.org>
To: Akashdeep Kaur <a-kaur@ti.com>
Cc: praneeth@ti.com, nm@ti.com, afd@ti.com, vigneshr@ti.com,
	kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info,
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	s-ramamoorthy@ti.com, vishalm@ti.com, sebin.francis@ti.com,
	d-gole@ti.com, k-willis@ti.com
Subject: Re: [PATCH 2/2] mfd: tps65219: Make poweroff handler conditional on
 system-power-controller
Message-ID: <20260319112405.GJ554736@google.com>
References: <20260310111846.1084623-1-a-kaur@ti.com>
 <20260310111846.1084623-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310111846.1084623-3-a-kaur@ti.com>

On Tue, 10 Mar 2026, Akashdeep Kaur wrote:

> Currently, the TPS65219 driver unconditionally registers a poweroff
> handler. This causes issues on systems where a different component
> (such as TF-A firmware) should handle system poweroff instead.
> 
> Make the poweroff handler registration conditional based on the
> "system-power-controller" device tree property. This follows the
> standard kernel pattern where only the designated power controller
> registers for system poweroff operations.
> 
> On systems where the property is absent, the PMIC will not register
> a poweroff handler, allowing other poweroff mechanisms to function.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  drivers/mfd/tps65219.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 7275dcdb7c44..beb816707d8f 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -541,13 +541,19 @@ static int tps65219_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = devm_register_power_off_handler(tps->dev,
> -					      tps65219_power_off_handler,
> -					      tps);
> -	if (ret) {
> -		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
> -		return ret;
> +	/*
> +	 * Only register PMIC power-off handler if system-power-controller
> +	 * property is present.
> +	 */
> +	if (of_device_is_system_power_controller(tps->dev->of_node)) {

The function name `of_device_is_system_power_controller()` is quite
self-descriptive. Is this comment really necessary? The code seems clear
enough without it.

> +		ret = devm_register_power_off_handler(tps->dev,
> +						      tps65219_power_off_handler,
> +						      tps);
> +		if (ret)
> +			return dev_err_probe(tps->dev, ret,
> +					"failed to register power-off handler\n");
>  	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
