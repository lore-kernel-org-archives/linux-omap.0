Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555080;
	b=mdPcLON9cIcrBwRQ+FErV+tdUrdWXbnPtiA3LWTWqyMIf5YoLkQ5LPARsbcjT7ezP/u1
	 JKEUuhsm4T0VMj8gzNzf7e8ekG0RVGkMFihKJfi4gLtHPOg0MgYZ+v/VQJve2Nj/zUuYy
	 ph8NpORDgEyeyixdpsR4nAMREKkvMLk9exeaJ1D2GFe2M3F9rKaTvwtdQvmOh6LPlLXnA
	 fRrhxQhgZClzSiPFSJRocUmrfTO158WzkoXT+ytfIJGHnvPNL8WCIJ+WNczdIdnwrojhH
	 jdnC2saXNitZjumjQ75vhQw337Tb1aViu5avVPvVb1UgouFGm4iJHR4V4umLim5xidw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555080;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gnvsu0TDZ5slNtZXuUskfju+pk2M78SPgeweXv/OO6g=;
	b=WoP4wekixMLj5ZE2soEHC4kPZPbpl68HPbLR53MT+7saeYZnEG+AVD6v6UjC6k4fGPFK
	 tzMRL9E+ZyaSxy6DPluU0glasIPxDHTQvLkixwh0VWMwVP1MkzYr4FyR5Bw8Xi98Nx0Dh
	 AbbJCnFIMDV1t8z9468pP45HvAHOZBrUl6cE+oEqoz7ExCH/q/lswHZSs1sFppBXe7YNq
	 aJL5zHUfv/wEk1jxzTXiQ0zHxcmBLlPGaWkGX0tvWp12lav8GMTqxQuYT7QG0y66dNURu
	 6Q50943RumGypBNE1NFRd91Q4SD05FIvHWqOa9c3yUNAul4KVMlyhiTlrRqC0ljZsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=8OcmMhbM;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5F606A32E;
	Tue, 24 Nov 2026 21:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D5F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=8OcmMhbM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=gnvsu0TDZ5slNtZXuUskfju+pk2M78SPgeweXv/OO6g=; t=1795555070; x=1796764670; 
	b=8OcmMhbMFvDN43DdqUAbNeJOgoYCaWiHKUPe5/1ABjKq+HbI+phrPqB+TEStgxKTPPW3A2O0LnO
	UUbBO+S8aRQ/u6AiOhen4rCGw5WVdayB7PnQdVKArg3H27tZ45KdyBIkebU+4oMPZ+5TGImXtxQv+
	OnQXEfQkuPZzFtanS7eQu+hvFZqIymb9oXSJBIP0Sn0PhVzjuh15/hPJpbOZ6YJm15BdX6PiQ59H0
	92VITcOfNTjrU8aqiaihQUo1VIECQnWJu4kkzb5qwv51k98fIvDLiCWaWCkcoh6RbD9tWxb+NqM+C
	NXbSvZCeGaqxFsWPM4CQlVWtzNc9bwP+3UaA==;
Date: Tue, 24 Nov 2026 22:16:10 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King
 <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Helge Deller
 <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jarkko Nikula
 <jarkko.nikula@bitmer.com>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 20/20] ARM: OMAP2+: Remove Pandora platform-data
 quirks
Message-ID: <20261124221610.2938d62f@kemnade.info>
In-Reply-To: <1cb5bd7216b334e8c4eff21ff3463deeb6109595.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
	<1cb5bd7216b334e8c4eff21ff3463deeb6109595.1795505160.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 08:26:00 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> The Pandora backlight is now described in the device tree and driven by
> pwm-backlight. The sound card also uses device-tree descriptions for its
> codec and amplifier GPIOs instead of legacy GPIO lookup tables.
> 
> Remove omap3_pandora_legacy_init(), its backlight platform device and
> audio GPIO lookup table, and the associated board compatibility entries.
> These platform-data quirks are no longer needed.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> 
> Notes:
>     Changes against V1:
>     - Andreas Kemnade raised bisectability and intermediate driver
>       availability concerns for the V1 pdata-quirks removal.
>     - Correct the legacy backlight name and explain removal of both backlight platform data and audio GPIO lookup tables.
>     - Commit-message review assisted by ChatGPT.
> 
>  arch/arm/mach-omap2/pdata-quirks.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index b947bacf23a37..aca7097a692ed 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -268,27 +268,6 @@ static void __init omap3_logicpd_torpedo_init(void)
>  	omap3_gpio126_127_129();
>  }
>  
> -/* omap3pandora legacy devices */
> -
> -static struct platform_device pandora_backlight = {
> -	.name	= "pandora-backlight",
> -	.id	= -1,
> -};
> -
> -static struct gpiod_lookup_table pandora_soc_audio_gpios = {
> -	.dev_id = "soc-audio",
> -	.table = {
> -		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
> -		{ }
> -	},
> -};
> -
> -static void __init omap3_pandora_legacy_init(void)
> -{

maybe ask here for pwm-backlight node? Then this all can be untangled a bit.
so something like if (of_find_compatible_node(NULL, NULL,"pwm-backlight"))

if that node is available do not register that device.
Such a change can go in as soon as we have consensous that pwm-backlight
is the way to go.

After all is in, in a final cleanup step, remove the pandora_bl and
the quirk.

> -	platform_device_register(&pandora_backlight);
> -	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
> -}
>  #endif /* CONFIG_ARCH_OMAP3 */
>  
>  #ifdef CONFIG_SOC_DRA7XX
> @@ -514,8 +493,6 @@ static struct pdata_init pdata_quirks[] __initdata = {
>  	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
>  	{ "ti,am3517-evm", am3517_evm_legacy_init, },
>  	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
> -	{ "openpandora,omap3-pandora-600mhz", omap3_pandora_legacy_init, },
> -	{ "openpandora,omap3-pandora-1ghz", omap3_pandora_legacy_init, },
>  #endif
>  	{ /* sentinel */ },
>  };
Regards,
Andreas
