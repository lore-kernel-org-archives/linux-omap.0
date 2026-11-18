Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024222;
	b=B8dE9NlHFBrtPhCrxsICPWCto/B9pBNNYUSknS7/yorUvhMGUmQEoWw+o/AvYVeqoSDf
	 wmeE5qz5iq+IXvGcKHpZ6kMPcUibUylBqNQJYu68rRGeTJfnr923Wp2x4LU2gaMv2Pcyp
	 KvJ06DXnm+Pvp4Xtcahf+bwMBQlcErDevIgiKFXBj+P5hgKl+jcrl7miCNlRkgl7bYEwE
	 qtz2ncGTa4qva+CUIYIhYpURTTfcVA9FWzAoC62ivIOkaCsK2dQVxb/+S8JqLEkvdTQOM
	 PU1/yPK+yyYHvD25D+vBkwEBgaA2DCZZdVfu3HV9eEF/NdbK0c4XV6m/2Hq5PcpcP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EaMgRwbhsvoxj0MihxEeoRWEFQY5WPTDKLvFxtZ7IZk=;
	b=tDfRKWqviSc1bD2T/AUoAjQ1Gokrt9CjKGef8rJlGl1U4lXVhDq7XYFJIok6n6S7Sn8J
	 kkBpGQKi6hCowarzjoDiClCo/WDDsSqrhgG5XZ3nMMly+UGIQ3Gu4PRzqFmk/U+Pd7Rn3
	 18JmhFDYbcOhOo6W/Npd8mvkzcsEAHtU5ndHTpjU4nyAgHg5VY2WjnK06gOGyDJtoDcV9
	 afbLSbUZxc+QWKBJH3PjXyAdLSJL+WslSGKG6UZitTi30NvDAh9ogTTixLex6zqk93JLy
	 /6EBCDOgJAK1dOH3wIj/kK+AdkaY3VWNbScHwbiwCXdnEvYF/Eia78uXS5B2HYOeQ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiKLxuZr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E8606A320;
	Wed, 18 Nov 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiKLxuZr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF95D1F000C4;
	Wed, 18 Nov 2026 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024222;
	bh=EaMgRwbhsvoxj0MihxEeoRWEFQY5WPTDKLvFxtZ7IZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fiKLxuZr+JPHrSWThE1T2JFSapGFYN1Bw8OQ/BUokLeghidC2IoaZPQfA3xIfDp44
	 UU1i9hdgsE/1tpcISfPMTKqurfmRpxqHYj2VznsKWYfjRev3phAll8tkhG76l7HyRQ
	 4vTNfI1sqVu8iQGcMvNTHboiCgCC44lBXyPKTovHXwU59Cn6vEBWNMQOjg5Og1TqG5
	 4Pa7Py/u9eP1i/en10/UKExpvp5MUiU3RJHLKoY/9i7IJlaTC2pEWBno4Vi3uUmZFG
	 KtbBldtwTq/p4G9UzPrlEDluJYfDuZKf0YDHe68A9sJc34lZ4/zlvU3q4I5ZG/fJPg
	 0Me+VOdtRsGVA==
Date: Wed, 18 Nov 2026 17:50:18 +0000
From: Lee Jones <lee@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: mfd@lists.linux.dev, tony@atomide.com, linux-omap@vger.kernel.org,
	tharvey@gateworks.com, support.opensource@diasemi.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: arizona: Free info IRQs on probe failure
Message-ID: <20261118175018.GG98456@joneslee-macbookpro.roam.internal>
References: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
 <20261107160745724MOYYTSmCdHXClJi4gEGfn@zte.com.cn>
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
In-Reply-To: <20261107160745724MOYYTSmCdHXClJi4gEGfn@zte.com.cn>

Arizona people?

On Sat, 07 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> arizona_dev_init() registers three informational IRQs (CLKGEN error,
> Overclocked and Underclocked) with arizona_request_irq() before adding
> the sub-devices.  If mfd_add_devices() fails the error path only calls
> arizona_irq_exit(), which frees the CTRLIF_ERR/BOOT_DONE IRQs and the
> IRQ chip/domain but leaves these three requested IRQs behind; they are
> freed only in arizona_dev_exit() on the normal removal path.
> 
> As a result the three threaded IRQ handlers stay registered and
> irq_dispose_mapping()/irq_domain_remove() in arizona_irq_exit() act on
> virtual IRQs that are still in use.  Free them in the probe failure path
> too, in the same order as arizona_dev_exit().
> 
> Fixes: 3cc729869475 ("mfd: arizona: Core driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 91975536d14d..37cba7047d76 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -1373,6 +1373,9 @@ int arizona_dev_init(struct arizona *arizona)
>  	return 0;
>  
>  err_irq:
> +	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
> +	arizona_free_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, arizona);
> +	arizona_free_irq(arizona, ARIZONA_IRQ_CLKGEN_ERR, arizona);
>  	arizona_irq_exit(arizona);
>  err_pm:
>  	pm_runtime_disable(arizona->dev);

-- 
Lee Jones
