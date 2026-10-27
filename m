Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111443;
	b=HIAZ/ph+0OIqbDNDEkrivcydkpHbmweZfiCAW5E/Ed8K2lSpHg3p0PVhgb2iBas9N3ZG
	 WNOjz4VWRoWVLSZ03LQk5GUkhPdDtJoSkXYqIX3GApUReiu6yubnbmqFzrWXwLJa4H5vG
	 rqOrMUCQUF4nRyUtPm2DylHBy6Ym3qtCJdXuqXLnUxX7BbPngqDftEY54BkAmTbdeDr7Z
	 vNGqTQch+yj9hMHnMqR6NCp9MNs972Wv+/+n3OKbeeDCe2sGzlNA1b5UXSjyZEfU8DwM4
	 ybfRgAePBVMmAohY1oSqV/kVNt+FhixKE7JmqWls5RrFC2qnoWzC2s7dNAKfVnQpyKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=875c48MPp5tNhjkEcrdTRwt1cE10gnl1fAKukqWl4zY=;
	b=sOZNjad+ofCQRwS7/lwfeQoiEDeq+H7bFU4nK8yy28dwXfh9/ZVjn6iSZyaB1FP3bHwP
	 +G1Ek+ppCvYyPda8RBYLz5paIQCJ8NhOACuWjKMwxOvmcXx4sn+A6mVaT/HsapYlkFNJV
	 0Zd2hMfkjPyOQmeB5TbndFAdYp+LzvgAr2A7vtQYP18XXnzTp9wCGIF6kmuE6x5KssMcV
	 C8/GPcw3/YEYDIWAIPkhd+lkjc/SDnMcwMpgpQrI1vtSTD3US1diwbMOSOo9DZ/HVtPUd
	 a+r/beDzjebxIhXbSriRw5m+4i4l2QORCjFKdUhyl52c7RkZHilK03IKmVdYhBmzCrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMaG+KSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86D606A33B;
	Tue, 27 Oct 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMaG+KSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551E1F031ED;
	Tue, 27 Oct 2026 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111442;
	bh=875c48MPp5tNhjkEcrdTRwt1cE10gnl1fAKukqWl4zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMaG+KSMuG4kEPWwYTx4NbPcyBiFPOlNPta0gG59lyw/Q0tgutRZJgiE4s6S069qM
	 DuuUxN1ktE5ccRCZLCFeap9sT5nXL6ZlVNsFxRbLTRmlTXsdLaqzvlsaxx4mkZf/PX
	 U2uj3q2LfU4AJzBQFoBI4iEJa7h1xcy27SFj/5xq6XRGztX70n1588iqu4H5Q2ja5v
	 4WzWXBhJ1y3My+1lqVrKCp8oQ67v3pHx7vmvmir5fkltiHVRB/wjaN0WgRHE9jrNUB
	 8HqmMyOnNLGdM9QraTJ5IKjoqOif+y6oV2+K52FrrnSoH2rJW8gVaqVC71daw2QFI2
	 MIfnyDNWNqWqQ==
Date: Tue, 27 Oct 2026 14:30:38 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Dmitry Osipenko <digetx@gmail.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mfd: tps65910: Use
 devm_register_power_off_handler()
Message-ID: <179206477112.1869456.15984957352026081702@kernel.org>
References: <20261015102320.23760-1-clamor95@gmail.com>
 <20261015102320.23760-2-clamor95@gmail.com>
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
In-Reply-To: <20261015102320.23760-2-clamor95@gmail.com>
X-AI-Review-Draft: <20261015102320.23760-2-clamor95@gmail.com>

--- checkpatch.pl: clean (0 issues) ---

On Thu, 15 Oct 2026, Svyatoslav Ryhel wrote:

> From: Dmitry Osipenko <digetx@gmail.com>
>
> Use devm_register_power_off_handler() that replaces global pm_power_off
> variable and allows to register multiple power-off handlers.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/mfd/tps65910.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 6243b66b1b6f2..18b76359046b8 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -16,6 +16,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/mfd/core.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/tps65910.h>
>  #include <linux/of.h>
> @@ -425,9 +426,9 @@ struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
>  }
>  #endif
>
> -static struct i2c_client *tps65910_i2c_client;
> -static void tps65910_power_off(void)
> +static int tps65910_power_off(struct sys_off_data *data)
>  {
> +	struct i2c_client *tps65910_i2c_client = data->cb_data;
>  	struct tps65910 *tps65910;
>
>  	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);

Why not pass 'tps65910' directly as 'cb_data' instead of 'i2c' and save this
lookup?

> @@ -435,6 +436,8 @@ static void tps65910_power_off(void)
>  	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
>  			   DEVCTRL_DEV_OFF_MASK | DEVCTRL_DEV_ON_MASK,
>  			   DEVCTRL_DEV_OFF_MASK);
> +
> +	return NOTIFY_DONE;
>  }
>
>  static int tps65910_i2c_probe(struct i2c_client *i2c)
> @@ -501,7 +504,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
>  	tps65910_ck32k_init(tps65910, pmic_plat_data);
>  	tps65910_sleepinit(tps65910, pmic_plat_data);
>
> -	if (pmic_plat_data->pm_off && !pm_power_off) {
> +	if (pmic_plat_data->pm_off) {
>  		/*
>  		 * The PWR_OFF bit needs to be set separately, before
>  		 * transitioning to the OFF state. It enables the "sequential"
> @@ -515,8 +518,13 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
>  			return ret;
>  		}
>
> -		tps65910_i2c_client = i2c;
> -		pm_power_off = tps65910_power_off;
> +		ret = devm_register_power_off_handler(&i2c->dev,
> +						      tps65910_power_off, i2c);
> +		if (ret) {
> +			dev_err(&i2c->dev,
> +				"failed to register power-off handler: %d\n", ret);
> +			return ret;
> +		}

dev_err_probe()?

>  	}
>
>  	ret = devm_mfd_add_devices(tps65910->dev, -1,
> -- 
> 2.53.0
>

-- 
Lee Jones
