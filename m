Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024647;
	b=PJBx6VcU2A4uu7h7wPokJyttaid/nyUioOPg8itfEIgoIFRAJQrEIN8qKCc/i8VIPsqI
	 Hb93eIWpIZ90ZR7O6iwXX4ITtwYkWFYS/x73XMA+xETkdugU4B6N0vikzwR9Bfw7lab0+
	 duI6PJpJFKaJk3UYbTK5z7ajw3ld19qtPyfjQuDeGSNfW/hxNnLTDOtAjnm1tmTZd7oPk
	 dxf9kUClgDbTGpEqDeFQOCiWZYb7VQXgGpqmigNfrabcxVlR+v6euIKlbNdyEcVnYgNeZ
	 xsxwUhvpxc58wEjzC4+mqyMH8rFPVa5FPb1Iai3gP2aTWvP4S8lD2DPj9mkW4dL+2eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024647;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=uAd3MUk9qYtbze38uBTrXfFgtr/gz/IeQWxE+iY3ORY=;
	b=4gbJ8bNEmbBBsPz9o+n4jcdK/rlUdbo7FY2aRzj8uJM9J3T0TYjw+gRdgRSzLH1GMLOm
	 U042j3i4QyxH/7GJ7/AU0UMqHLbtAcsAEFLp8f0xTGxQyJiq1Ec6W3+qGOipwS7GhmV0M
	 eoYV6EyANeoaVL5d0ci5k4olXoaPbnmQhGtUQMiYdjkzpHr8NyYH1dOEjB/i1yZAXxASZ
	 3yL4VRdon6LLw43yEn6hEuKTzyuwWU2u5us1lKxjYvgmyDPeomEadlnnqizKGXSZ3DzVL
	 sm09IKdnS82k8l/QValabSQ4LdsK5I+YzLATOFWj/Iui01mnVWBuGBIscsWxNwYWMiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjXj0INO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57054606A31C;
	Wed, 18 Nov 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjXj0INO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7131F000C4;
	Wed, 18 Nov 2026 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024646;
	bh=uAd3MUk9qYtbze38uBTrXfFgtr/gz/IeQWxE+iY3ORY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AjXj0INOLZZ4UtY6XYtnJ0+s9Nz8424ZXR0rn3JnscN98FY7gWN9amG8CC1wkLmat
	 rcHwX5i2epSeLbKfXyAO4cCuAXaJjtHd1BEXJk01CLc+moE7DOi2PzRI12DFdl3Eov
	 JTnq1ASDiUprECftBPjJeHE8rhjZFUdqOiALjYAe1hqza/NMyKgmdbdheD+rO4FRZV
	 44Thopdq2AEOiDeIaGL1PRn5o7/TXC+e7mvDD5i8Z7JuA/brN2AtlA0FKRub3OKZwV
	 Be9Yr9e+G7w/CoXgdjCwR1YHYOQRo+J4ZiaBoUJgQJxr6BFbCdqAyF464WHiCIoohc
	 PxKvqXkStzjGA==
Date: Wed, 18 Nov 2026 17:57:22 +0000
From: Lee Jones <lee@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: mfd@lists.linux.dev, tony@atomide.com, linux-omap@vger.kernel.org,
	tharvey@gateworks.com, support.opensource@diasemi.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mfd: da9052: Disable IRQ wake on device removal
Message-ID: <179442121138.44545.365837636476170108@kernel.org>
References: <20261107160747079LomNfOJeeu6knwkNqJYTx@zte.com.cn>
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
In-Reply-To: <20261107160747079LomNfOJeeu6knwkNqJYTx@zte.com.cn>
X-AI-Review-Draft: <20261107160747079LomNfOJeeu6knwkNqJYTx@zte.com.cn>

On Sat, 07 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> da9052_irq_init() calls enable_irq_wake() on the chip IRQ but neither the
> error path (when requesting the ADC_EOM IRQ fails) nor da9052_irq_exit()
> (the removal path reached from da9052_i2c_remove()/da9052_spi_remove())
> ever calls disable_irq_wake().  The wakeup configuration is therefore left
> behind when the device is unbound; the IRQ line keeps being treated as a
> wakeup source and, should the descriptor be reused by another device later,
> the stale wake setting persists.
>
> Track whether the wake source was successfully enabled and disable it
> symmetrically on both the probe failure path and in da9052_irq_exit().
>
> Fixes: ed05be56643e ("mfd: da9052: Register ability of device to cause a wake-up interrupt")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
> index abbdbf0337e2..da5bac424efc 100644
> --- a/drivers/mfd/da9052-irq.c
> +++ b/drivers/mfd/da9052-irq.c
> @@ -259,7 +259,8 @@ int da9052_irq_init(struct da9052 *da9052)
>  		goto regmap_err;
>  	}
>
> -	enable_irq_wake(da9052->chip_irq);
> +	if (!enable_irq_wake(da9052->chip_irq))

In general, I'm not a fan of stuffing functions into if()s.

> +		da9052->irq_wake_enabled = true;

Can't this be called after da9052_request_irq()?

Doing so avoids all of this craziness.

>  	ret = da9052_request_irq(da9052, DA9052_IRQ_ADC_EOM, "adc-irq",
>  			    da9052_auxadc_irq, da9052);
> @@ -272,6 +273,10 @@ int da9052_irq_init(struct da9052 *da9052)
>  	return 0;
>
>  request_irq_err:
> +	if (da9052->irq_wake_enabled) {
> +		disable_irq_wake(da9052->chip_irq);
> +		da9052->irq_wake_enabled = false;
> +	}
>  	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
>  regmap_err:
>  	return ret;
> @@ -281,6 +286,10 @@ int da9052_irq_init(struct da9052 *da9052)
>  int da9052_irq_exit(struct da9052 *da9052)
>  {
>  	da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM, da9052);
> +	if (da9052->irq_wake_enabled) {
> +		disable_irq_wake(da9052->chip_irq);
> +		da9052->irq_wake_enabled = false;
> +	}
>  	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
>
>  	return 0;
> diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
> index 9cb2fc2938ce..d7dd36891539 100644
> --- a/include/linux/mfd/da9052/da9052.h
> +++ b/include/linux/mfd/da9052/da9052.h
> @@ -93,6 +93,8 @@ struct da9052 {
>
>  	int chip_irq;
>
> +	bool irq_wake_enabled;

If the above is not possible, why not call disable_irq_wake()
regardless?  It's safe to do so, right?

> +
>  	int fault_log;
>
>  	/* SOC I/O transfer related fixes for DA9052/53 */

-- 
Lee Jones
