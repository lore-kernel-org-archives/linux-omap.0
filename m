Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06082E1EFC
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757903; cv=none; b=eYK7ry56UlAlrySgC/9cWUOnA4mYzf2/S4iurzwdgBxCSWYMaQzrBLxUKxitV8rW8jgmBpXXzXHp0wry/W7Dcj33WjCIOfhoB2AAytLDte35SUIfruuYXz75vv2oQdO1Y8BUURSHsaUhWudbLItSFDy2kfsXpJqofptc1oqRIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757903; c=relaxed/simple;
	bh=G9zzbkUUMAkORAuT7yKEFCmmFIF56otd76cutMRNMYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJCjUBlVOaDEwRDAGd61kMkj1mbFVusvhS/GxLw1vn8f3Jm1qOmEIMonQdXlgXCKbBiO+a9NE9gGt5QgNXsEdGj31+eOI5ngh9EutSFIJPkzOZ7rTrPI4S2QUlIRuRhe4gtDRucII0qqHSWu3Mt5tDZp5p3kTMJW9x5CgnlkTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae3a2f6007so42820475ad.2
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 16:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757900; x=1773362700;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBIID2C3tYCLC3ROIp9HZ27Vwpuc9s7YKBLnBBIirXY=;
        b=vo9TNLhIdTGamjI5saM8JiwWJzQFMnhYbogCSqJdtVm0v8jhENbrxmteYpZB5NY8DA
         ODpKDn7jw+e95/cHhUesE/WKBv+2BBFFFxVN1F+z1JNrS5wVzAE9C9bCiSfCGR3aF/VK
         kZe/sKHto7rr2RCWaFkhDvkyTmTgt6H1cFYNSgHBUpaG73YYTcijxCocgbTIxPHMjc4d
         Oa/pTro/yVMkUpKCpTCz1awSO/7aGBbJUf6csC60z9bqqHSkbalQvEsXfzpOhTdrSLto
         UGzeTFiiGhM5EnBlUJKCK9QIo4Z5uvN7hxGUG/yEI1oKi6v5uqhydFBbWAgIThwtmROz
         GIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJG95+Wjv20/n3pmvdE4mMCIeTd+XET+9gEEPf+DD4ccmx57IMqIn49NlsNZlmGfUTYNVlfy0xz5oZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9ZqRZGJKdJPWw9W9I24CtSGdw3tGZEUlbA2XuMpsI1vwHT29
	XyAyc8tuReUPStCLq8dGowMdk0CbEwhU9BvZmV98EJJLeVkMBlDneyiyj/T5lLu6Cxtmrktk9c1
	ylvmtgIA=
X-Gm-Gg: ATEYQzzY61vJwvnEWsC8YXJGnOF9Jvyb3aQXt1YnwSaH/qYwHyu95g3pAvMUvjX5nlH
	o3htPXYeOVwXaxcNSRs+92/BgyQ48SrQudpzYgRaPbH6v1LibluE2Ya3WFHze1yUXXyD2il6aFR
	32/V4oUaE3MjU9z1FzE52crOSUuirjLYFP+mQCtrtfuTO3oeYg89liIdjOBpiJ0e6AU3CrxMLCU
	mYs2DqXNC6lYmpFeTHjW0bVMawo6LwJqWH3GCdosKQ2s24qBrnWDhR29hN9CaIKfhfoTjRZzyHw
	hqlKPvtDmZIVNaLyrRAKUaTK8Fw2sFcLF0J/zsFQ6+HLqYYjcUJ2cv63bQfWJDTGCGent6bG8Q1
	y5zCEwHpCPkEEFfNspzY5OsbApjf9k8C4dVdnXy7cFI/5DGIaQmh7iHROh6qEiXV1KAp30GZCEt
	JpkuccEzDMvEHlAx4g8CYr
X-Received: by 2002:a17:903:18d:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2ae8241df4emr3858265ad.12.1772757900350;
        Thu, 05 Mar 2026 16:45:00 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm180143885ad.44.2026.03.05.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:44:59 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Frank Rowand
 <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony
 Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, brgl@kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
In-Reply-To: <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
 <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 16:44:59 -0800
Message-ID: <7hy0k5okfo.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> writes:

> Setup a software node hierarchy for the latch2 GPIO controller defining
> the required hog and stop using legacy machine hog API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 16392720296cd224732450c85419c35bbab506f6..1bec4fa0bd5e8bfc58103d1f24b22176707fd26f 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -556,10 +556,30 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_nand_gpio_table,
>  };
>  
> -static struct gpiod_hog ams_delta_gpio_hogs[] = {
> -	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
> -		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
> -	{},
> +static const struct software_node latch2_gpio_swnode = {
> +	.name = LATCH2_LABEL,
> +};
> +
> +static const u32 latch2_hog_gpios[] = { LATCH2_PIN_KEYBRD_DATAOUT, 0 };
> +
> +static const struct property_entry latch2_gpio_hog_props[] = {
> +	PROPERTY_ENTRY_BOOL("gpio-hog"),
> +	PROPERTY_ENTRY_U32_ARRAY("gpios", latch2_hog_gpios),
> +	PROPERTY_ENTRY_STRING("line-name", "keybrd_dataout"),
> +	PROPERTY_ENTRY_BOOL("output-low"),
> +	{ }
> +};
> +
> +static const struct software_node latch2_gpio_hog_swnode = {
> +	.parent = &latch2_gpio_swnode,
> +	.name = "latch2-hog",
> +	.properties = latch2_gpio_hog_props,
> +};
> +
> +static const struct software_node *const latch2_gpio_swnodes[] = {
> +	&latch2_gpio_swnode,
> +	&latch2_gpio_hog_swnode,
> +	NULL
>  };
>  
>  static struct plat_serial8250_port ams_delta_modem_ports[];
> @@ -684,7 +704,6 @@ static void __init ams_delta_init(void)
>  
>  	omap_gpio_deps_init();
>  	ams_delta_latch2_init();
> -	gpiod_add_hogs(ams_delta_gpio_hogs);
>  
>  	omap_serial_init();
>  	omap_register_i2c_bus(1, 100, NULL, 0);
> @@ -693,6 +712,9 @@ static void __init ams_delta_init(void)
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>  
>  	platform_device_register_full(&latch1_gpio_devinfo);
> +
> +	software_node_register_node_group(latch2_gpio_swnodes);
> +	latch2_gpio_devinfo.fwnode = software_node_fwnode(&latch2_gpio_swnode);
>  	platform_device_register_full(&latch2_gpio_devinfo);
>  
>  	/*
>
> -- 
> 2.47.3
