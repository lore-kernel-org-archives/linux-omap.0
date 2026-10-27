Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111489;
	b=4hgPor3BfS7YERZkazJWKd1siFnstE9wraXS9o+UYCWx0NK9ZzR0Xz41BfZ52N6Iczan
	 eArmMukITWniLRvtGMh1m9vRhRbQ1ouf0J2Gzw4Ky4H0s3KaRKJxsC9QjF3s8VbJdNv3u
	 ga/zD2l/g3H4yYbJwN0T4GSFJBb7psCZ0kFfHBUF2BhXfsqR/xu8KkA9Vxdfa7OH+qoLO
	 4UdepjVwiGWOVvy++ph+E0X1k4G5tH5WTFQfTS7e8jgchKhaqmA5LKOg2c1lA+/niuZwH
	 PMgR3NCL4VfOZLX7TsdtQgZcADgT1RjLieUuTgkeUghrvWiWVSujZM+h4eO2YUosibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=b1g0szBCeXDxU9FyY8J94lKomFprzrjStJo4frqTB60=;
	b=vDM2yBfOugGBqK+wKg6eBy0Gu6nbnvxFtBn30vxAQ9RS6U82qCEwOCdfBd2OZuhzyOaW
	 ME1za1CkSQBHeR4bgWwb1IcHf7xr4NUrnDJ1TUz2x5FPEXtuqkRM4EQVMEPnroeRr9Q9V
	 4BH3vh28Occ1G1kRHKIUcD+WVvjWVIKKBuY5SJNX3rqTbYTVKeHqvhyfqhoPN3N7/2vor
	 MAzhEMJHA1h3tdCHAJj8Rwc5vwcPmB+9EQfe/S6C68QjAjxZSUQX2TVEi/SR3axsLv1Ze
	 YeV6k+MDobDjuR1vXjGegq+nzdVvCEg9XHJtgh9EyI5fH6mijDn0V5mChS7MRw5Ee9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETXZBDFs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E9606A324;
	Tue, 27 Oct 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETXZBDFs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047801F01825;
	Tue, 27 Oct 2026 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111488;
	bh=b1g0szBCeXDxU9FyY8J94lKomFprzrjStJo4frqTB60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETXZBDFsCSirDEPc2jx2POeuny1OazaVyHnLgIqMvCX4j5iOVSgQ4WiEfDA7ryzHf
	 mkNA7y1g41MCcTAPQW8/ALcjiyRMNo3HterpajlfUOggaOOhp0tP2GMVTZXW14flu5
	 qJVPtKpcpMtACstCPb9Jude0JHMpBlx438jJsLtMjSkeeAHGytq9ydj9tQ2xLqTb+x
	 93UTYhfyS9pnhtCFk43whjtndCi0oxYIQzsgxIwx7SpSVtgWwIKE2Vh4OVOrjQfJl7
	 xEi0/oxgT+oQ27aSn7yWaEhM5kMEA8caZZ1zaj/BwFfHilWqSt8MEXt0szkslGLCUZ
	 U1F1sX071eJyQ==
Date: Tue, 27 Oct 2026 14:31:24 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Dmitry Osipenko <digetx@gmail.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mfd: tps65910: Add restart handler
Message-ID: <179206474862.1869456.3359147212046371469@kernel.org>
References: <20261015102320.23760-1-clamor95@gmail.com>
 <20261015102320.23760-3-clamor95@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015102320.23760-3-clamor95@gmail.com>
X-AI-Review-Draft: <20261015102320.23760-3-clamor95@gmail.com>

--- checkpatch.pl: clean (0 issues) ---

On Thu, 15 Oct 2026, Svyatoslav Ryhel wrote:

> From: Dmitry Osipenko <digetx@gmail.com>
>
> Add restart handler to reset hardware properly on system reboot.
>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS TF700T
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/mfd/tps65910.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 18b76359046b8..a1734fee1485a 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -440,6 +440,20 @@ static int tps65910_power_off(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>
> +static int tps65910_restart(struct sys_off_data *data)
> +{
> +	struct i2c_client *tps65910_i2c_client = data->cb_data;
> +	struct tps65910 *tps65910;
> +
> +	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);

Same here.

> +
> +	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
> +			   DEVCTRL_DEV_OFF_RST_MASK | DEVCTRL_DEV_ON_MASK,
> +			   DEVCTRL_DEV_OFF_RST_MASK);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int tps65910_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> @@ -525,6 +539,14 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
>  				"failed to register power-off handler: %d\n", ret);
>  			return ret;
>  		}
> +
> +		ret = devm_register_restart_handler(&i2c->dev,
> +						    tps65910_restart, i2c);
> +		if (ret) {
> +			dev_err(&i2c->dev,
> +				"failed to register restart handler: %d\n", ret);
> +			return ret;

And here.

> +		}
>  	}
>
>  	ret = devm_mfd_add_devices(tps65910->dev, -1,
> -- 
> 2.53.0
>

-- 
Lee Jones
