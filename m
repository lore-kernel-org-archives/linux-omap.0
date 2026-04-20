Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39F4C81
	for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643619; cv=none; b=rLEoB+iqIY90lLc6RWw/OuIrx1mHYsv73MDWotvQNsroDrHqxOuNKHY3meB4CCjJkYpYnK9I+gHrgtPT6Jg2N1kd5UXtxgv2irPDlzLjBcOwgFslVrynN+SFPzg6QTI+61vN5vMPftU9Oh8GMlxWttoz/Y88IloAu0wouIBgU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643619; c=relaxed/simple;
	bh=gDoBAxabA/vuB2DuUd7qLM2A4GacNMLMKn8azMkS+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkqNJfPC1g+7M6YfiCOccdANJGYU5zxVrTFyIyyk792oUbcV1PpG3AWEElntzT97y0+cD07z89xkOJbrGhrpl5Wu+l8o+71rZFf/gv1+1gc/hFGrVWKGOh7a+euTOOF004Ov4UdZL7ZLVY+44liszYD+809Q1JigQRTFs2nJxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaPUgd0p; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaPUgd0p"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2264305eec.1
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776643617; x=1777248417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDe9T+Ne4Qdf5vTIpzGNL8rfAB6MOiSoIWj2DlQdxfo=;
        b=FaPUgd0p50N1S1v66COpoGRpZ6UNUn9aTHy7FxI2N+/yuEOlWH/pPwi5hZ8jwOy6Yy
         0CHFxCFdQixMJp9jS5OBuK1n2isPCTLw21tRrcPHpa4Sx1t0GkDW0nabpGGHA47HLnZw
         2fHImW8+8ygByMw/2M29ZuB3rAyzhLRR7hyxKkJGY6ZZ3yAi90DafylpXzPQqyO9ZHVx
         SFmO5XaFWhnfqfXqeOh/p7MexB7vtQ/7btkgI16UU+3URPQSL5UKyHlHvYToD8p92U05
         Gu44NwYiUxvA4m3q/U3OIZd/vyWhYqvdaPFvqqMyrWY4wcH3XNezDNVUqSY1cQU6ID/u
         +pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643617; x=1777248417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDe9T+Ne4Qdf5vTIpzGNL8rfAB6MOiSoIWj2DlQdxfo=;
        b=NbYBl/UjBBt/Fgu5licZZQoCj1Fif1Jfsq5A1ON+C6sEwKLO1ZTeHOIyVfngWW5AEW
         lozqmoMVh/ykE2WxPlcIGkMpQ4bKvNPeJEIIX+OdnxrKkGrNd6mkpuAl9BqAZ1sTn3gs
         3KCYENcwj8uEeZx7IYsdnvnlXpWLEULcpr5QQg5CVlgbO/vB9gopk945qc74L1gp8rYF
         nQ3fqiBoaOkmqcrjAoUTfD4ri3tabkFMh8oCqKl3jQFEyaLASoT/I3x12ZwCUVzicIk3
         c0O2eGFgnsJjWyHH9l1hxybwnpPqRD9cpiCcQS1TIkJwC9r2NFtbYXUqImc0xWpjaQ63
         rvAw==
X-Forwarded-Encrypted: i=1; AFNElJ9p2A2qx81BuCwx0+I7EiWLckc4Zkubj/RTgCstXRvNHuOh7wFL5nkWev5x6eeq9v2p0OHob/sj/6Y1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Bs2CW+EPRLbU3D2KZfDhf7rXVX/T1R3nk5N4fAbaWsHf/9QE
	K6GXj9PUe8kwJVjFsFJSeKLdIXkI8YyeQbkRQvW4WK+4gbzcTTeyaOFJ
X-Gm-Gg: AeBDievMQne4Deor+NG8Io1RxfsJ4dDz94Cwj/9IgGMBUbBl8KNVDe/Q60fk8BdXSnR
	eDMHRB/Y0knWaQXjbOcAUyELq2/nKQisumf+w78/G4KwY26Dg77hAXyfUuX5w0x7yUYDmp1gjsW
	y8IWd+/qF0spxRbKxqMED8kbkFGSzXAIeZqKiTZPihDYQXYZkyPj3YJ2OzCinGrU1Y6tap8V477
	CYTrIkKPVgFmKXyql61Vd0JEYRDaWIN7kKhR8yErbls277/1OmbO0PORU23ZdzdCLQ/rMb9+aa5
	eZDni4SsYxZ2OECDNVAS7rW0ElfvJZnykfZNa6o1xx3n3DbnUGiyAbktVK7I4sZla09rbTEc04P
	ZPJVq8P5AWqa44bJYH7y3NTkoZEIoNkl8Db4AdvHBJwX4zD88cuwKo49+dN+iOkxxdUdtYKwY73
	v7B/vETo+G5tFViyjN/8jlPnZgmTdMdM8aOaFQXD6VvVUyJftmgVR3uFZ4QCpdVD86NeZtKfQTg
	xE=
X-Received: by 2002:a05:7301:3d19:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2e4873f3103mr6158572eec.27.1776643617331;
        Sun, 19 Apr 2026 17:06:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm11564185eec.14.2026.04.19.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 17:06:56 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:06:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: ads7846 - fix up the pendown GPIO setup on
 Nokia 770
Message-ID: <aeVs2VUqPL1v0Vka@google.com>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-3-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419161848.825831-3-aaro.koskinen@iki.fi>

Hi Aaro,

On Sun, Apr 19, 2026 at 07:18:48PM +0300, Aaro Koskinen wrote:
> Commit 767d83361aaa6 ("Input: ads7846 - Convert to use software nodes")
> added gpiod set up for the IRQ in the 770 board file, then another in
> the touchscreen driver for reading the pen state. This will make the probe
> fail:
> 
> [    1.347381] ads7846 spi2.0: failed to request pendown GPIO
> [    1.361846] ads7846: probe of spi2.0 failed with error -16
> 
> I originally tried to fix it using non-exclusive flag, but that was not
> found acceptable. Instead, just use a single gpiod.
> 
> Fixes: 767d83361aaa6 ("Input: ads7846 - Convert to use software nodes")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap1/board-nokia770.c | 11 -----------
>  drivers/input/touchscreen/ads7846.c  | 12 +++++++-----
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index a5bf5554800f..8b8013ab4590 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -285,9 +285,6 @@ static void __init nokia770_cbus_init(void)
>  static struct gpiod_lookup_table nokia770_irq_gpio_table = {
>  	.dev_id = NULL,
>  	.table = {
> -		/* GPIO used by SPI device 1 */
> -		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
> -			    GPIO_ACTIVE_HIGH),
>  		/* GPIO used for retu IRQ */
>  		GPIO_LOOKUP("gpio-48-63", 14, "retu_irq",
>  			    GPIO_ACTIVE_HIGH),
> @@ -307,8 +304,6 @@ static struct gpiod_lookup_table nokia770_irq_gpio_table = {
>  
>  static void __init omap_nokia770_init(void)
>  {
> -	struct gpio_desc *d;
> -
>  	/* On Nokia 770, the SleepX signal is masked with an
>  	 * MPUIO line by default.  It has to be unmasked for it
>  	 * to become functional */
> @@ -322,12 +317,6 @@ static void __init omap_nokia770_init(void)
>  	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
>  
>  	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
> -	d = gpiod_get(NULL, "ads7846_irq", GPIOD_IN);
> -	if (IS_ERR(d))
> -		pr_err("Unable to get ADS7846 IRQ GPIO descriptor\n");
> -	else
> -		nokia770_spi_board_info[1].irq = gpiod_to_irq(d);

No, I think what we need here is a simple gpiod_put(). The mapping is
not going to change unless someone tries to unload gpiochip, but then
the device is not going to work anyway.

Longer term we need to figure out how to describe interrupts with
software nodes (or wait long enough for everything to get converted to
device tree).

Thanks.

-- 
Dmitry
