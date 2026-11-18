Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026164;
	b=5rnAS9yJgcjjTyXFqzp+ASiJCJcSdJ3MDGTp4KLwTVjde9JN48rnqVgphk+Zq+yNarTP
	 7WZdF7S5w6jSSIutUwpy44WEYZIOZqnmMdBg+/K97L1LBCLJqSy9PF/xxHgdTRmYNLZdw
	 wuLuRVi/2s8BnMzlBqxIKDIQAc54NQCdkpkhWajbg/S7UeEh7GTxu6F7w8jSyuIjucJM1
	 +riWt0yQuwxqad/ViIG0A2UNmEvm90c9rZJkXM3EGCoDqib76GgHpGG+ewQVyTwnrTbPO
	 o5w/IWUjzfrirjjwYn02lciqyqH2ju1bU3gN8F0On0sJMw0n6btOUlS5GE4Fr1shzMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J7vdS07rOVMmeJWGjnXjAQm2E14T2hLPt/YVGYzgVb0=;
	b=0bFi3aZglDRxhD9iieDLqSzMVbYhO6G/Mg0eFe8GxV4MCQsFTsAWNjGHpggNyRYrEYrU
	 wht3ZYWPiROJi3ey6vPc3g+jBgYWNQHWmq7jq51gtLGdGv500JYKd7AsOr1JUZTMXT/VA
	 xw+pb/nm+fzEw+YU/iBbdRADkW3H2FodnVY0QYFUdSULpJBXruDI+yqPeUQz81XJtGX0A
	 48I/1NDlbfi+ocky/7RjsXf9001OwDqPglmud0cZwrPP5Crk0vW6OHiRymlq2o98XThdl
	 +pEzIOQ1+kuGYJ3BL4MlLa3Z/ylaDWmIIxmfygjKlyZln5dT8+5T+fK/48tHkJzC0gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4mBjuEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729560A260F;
	Wed, 18 Nov 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4mBjuEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067AD1F000C7;
	Wed, 18 Nov 2026 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026164;
	bh=J7vdS07rOVMmeJWGjnXjAQm2E14T2hLPt/YVGYzgVb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a4mBjuELonYMPG9I5byBU1DzNzPQHFF5s+YO86vHPZ/HdbbVV0pM2ml5FPunkPYIv
	 uWX3v3le9n6SyLOl6pW85XNAaIrRaNClXzxNiiZ6QMpDiBsND7EkOVuEd2FZu/Mdh4
	 WrQ24gKgbj5kki/2qSNBGoXrLqXkSbewHc9nXGSSQkbmqO1HnpJ8VSzeJq8D4DM4ql
	 6U35wEKQoj/mF8JDF+8TwZzoWd+fAzAlHmrFyGr/R4AXywRVc88JPkjGFTKlOT68aX
	 Ys53b+NNHOU40kWEfRNgUNVoVIvhRdtl/LafwIwQpTWKVGgTvaEaBnbqoWsBpOGGrg
	 VUAc5+a58sEsA==
Date: Wed, 18 Nov 2026 18:22:40 +0000
From: Lee Jones <lee@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: mfd@lists.linux.dev, tony@atomide.com, linux-omap@vger.kernel.org,
	tharvey@gateworks.com, support.opensource@diasemi.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mfd: gateworks-gsc: Check firmware CRC reads for
 errors
Message-ID: <20261118182240.GH98456@joneslee-macbookpro.roam.internal>
References: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
 <20261107160748370uUkky_wRKP7vtnKU1uRKZ@zte.com.cn>
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
In-Reply-To: <20261107160748370uUkky_wRKP7vtnKU1uRKZ@zte.com.cn>

On Sat, 07 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> gsc_probe() checks the return value of the GSC_FW_VER regmap_read() but
> the two reads of GSC_FW_CRC just below it are not checked.  On an I2C
> error regmap_read() leaves "reg" holding the value of the previous
> successful read (the firmware version, or the CRC low byte), so
> gsc->fwcrc ends up with a wrong value that is later printed as the
> firmware revision, and the error is silently ignored.
> 
> Check both CRC reads and fail the probe with -EIO, matching the handling
> of the version read above.
> 
> Fixes: d85234994b2f ("mfd: Add Gateworks System Controller core driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
> index a3301502ce6a..1d697e82ea29 100644
> --- a/drivers/mfd/gateworks-gsc.c
> +++ b/drivers/mfd/gateworks-gsc.c
> @@ -219,9 +219,11 @@ static int gsc_probe(struct i2c_client *client)
>  		return -EIO;
>  	gsc->fwver = reg;
>  
> -	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
> +	if (regmap_read(gsc->regmap, GSC_FW_CRC, &reg))
> +		return -EIO;

Again, I'd rather you didn't put functions in if() statements.

But worse, you're hiding the real error and forcing -EIO.

Better to propagate the error instead.

>  	gsc->fwcrc = reg;
> -	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
> +	if (regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg))
> +		return -EIO;
>  	gsc->fwcrc |= reg << 8;
>  
>  	gsc->i2c_hwmon = devm_i2c_new_dummy_device(dev, client->adapter,

-- 
Lee Jones
