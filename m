Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18225221F24
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021293; cv=none; b=VHtFlegCTMKICewm6ImUl91FFiSQUAoL5ccaVN/1gQEMHWIMoLF5EKcJi5lCK+7O93SzbEyoHnP56RBF7jvpxx+ACbL/3UyCQLHxCUWSRUyYnfzQLr1FzIaxIMH+A/0o1ZldUh/QM2Ar6L1oM3yBIg+/04zadDImgtqZTn1S/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021293; c=relaxed/simple;
	bh=b7bATi+E9HIWEWXTAIwNa4451ABKjWAafWaU1v8UUAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrpyl4+DKE0Q/qW0sBU4TD5UXYIXUR13OwHRw+ibsBNDORgjh8IxvzglIJEisAmk5R+kf+O0cVqrPsnN9BVA643XF6qGERU6KPtbNOY12iX4Yj/NDuld1tL8Zh0avucW0g8CM8Vj7kpP3QkP5YCLmkqRca4Wt/CARUhg1tTniWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5637886c92aso3165128e0c.0
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 04:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021290; x=1772626090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TQ9plTAtoqFGycuAV6Q4VO2kslCQXeQ3NGwgtKeiuo=;
        b=QYdahLOQc9OZI38sEA/JPNmrKiwldUjDtqDjxHY0VCMpu2jfDwHyclmsobGm6Y8/IT
         u+3BUGNU14csioNH3rVEbiibpJ9bWy63Uj4iDbJ09m5DIhHq7F/BbLhQcQsKKeqxzAmv
         h6fmfDuwR8GwSsazcfQVXczRytZKQXuE7CYm5NTWmGFZRluzE7sfgjtL5ebbyIYjZx85
         SxZMC2B0bJPEj8Gxqj+8dvrYC//3COLjy9byBbDtJzquPcSi9zkOaY8XNMIcwPK6oxcM
         zS/ML9Ssy8K0l1EKuwmfVvpL9A/GhMpe8S/pr3S6pWbXGb+EFpvkg+LEMK7BmAVJdy4y
         rG0w==
X-Forwarded-Encrypted: i=1; AJvYcCXSdSD+O/IFZWhr14EWmP9/7ub51nVSQuzBEvHRIWFAzJ70vCa4EKi0aLYJ6V8bFuVVgS3Z8CDchPSg@vger.kernel.org
X-Gm-Message-State: AOJu0YyLV2cTFPFthpRCGVho7p7OZsDo7Fy384tbIMYwSCOaxmKXB5AY
	tlb8BmxITok0kx/CI0RVCxE7sA9C0tnl1rtoMByguOnzg0WYaSCwvDCEQK0hb5T3
X-Gm-Gg: ATEYQzxywJrgBGlezpgFuDwTRjpRRTLawiwl3yeFrcyO1GtKHYfp01ybhiGRtpNbEd6
	qGgcuOjq6kpDr8Qvw/2EfZ90KN2jDZrafMqyI6lOssq9IpEqYB/Eghiu8uGR8mCT5Hu5v/MZ24g
	7pryZa5aHZZoWj4YN6m9aLmfGquuGXmnw0CjvZwE5a/5v3o0hpxTelRK4Iu6lEh1zkw8Ja9Dd/c
	Tsz8EIr+tSDCarrjv30UZzwEKv2Sxy4Scb/VpnXnc+WXX8wE5WDCVpa2xIKGK6rxN48qBYx/EUJ
	gZn24hw/0b3xNMu0qb1BB3W8gNL5G6oMmT1NWoi1LjW34UjBvkj6gA+OnOg19S5IjXKtqWd94l2
	H0RQyd4rAtE7ngpe8XtPqYMz+JHtOvCrYvtJ523HwvlI+ujI36fQFrCRy9ok+QLsjBhEFUhS3f4
	PdZCTVWkFvz64a53y3jpggCrZoQLoxobWwQrYGtGei4BC9wPbt6e67Xp0SV+ct5l9a
X-Received: by 2002:a05:6122:1c04:b0:55b:10d7:51a5 with SMTP id 71dfb90a1353d-56a8bc5731fmr120089e0c.10.1772021290082;
        Wed, 25 Feb 2026 04:08:10 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a7eb67241sm2866498e0c.9.2026.02.25.04.08.09
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:08:10 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a857578a8so140817e0c.3
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 04:08:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDmIZ37+wE7+NesUfrfaPP0SdIlSmhKI5JLew2iePsJC1cR8ffVxeaQ5rM0RooQBHqOKB63svoeWDW@vger.kernel.org
X-Received: by 2002:a05:6122:8c27:b0:563:702b:e2a7 with SMTP id
 71dfb90a1353d-56a8bcb7a04mr108622e0c.19.1772021289726; Wed, 25 Feb 2026
 04:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Feb 2026 13:07:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
X-Gm-Features: AaiRm538QW2lNPSmHsPdoAK0GxPwumP2I07aJZ0lsRKIlDak2p-vOeVkZ133ww0
Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
> The multiplexer subsystem was initially designed only for use by drivers
> that require muxes, and did in particular not consider optional muxes or
> to compile as a module.
>
> Over time several drivers have added a "select MULTIPLEXER" dependency,
> some of which require a mux and some consider it optional. v7.0-rc1
> shows 15 such occurrences in Kconfig files, in a variety of subsystems.
>
> Further some drivers such as gpio-mux are useful on their own (e.g.
> through device-tree idle-state property), but can not currently be
> selected through menuconfig unless another driver selecting MULTIPLEXER
> symbol was enabled first.
>
> The natural step forward to allow enabling mux core and drivers would be
> adding prompt and help text to the existing symbol.
>
> This violates the general kbuild advice to avoid selecting visible
> symbols.
>
> Alternatively addition of a wrapper symbol MUX_CORE was considered,
> which in turn would "select MULTIPLEXER". This however creates new
> issues and confusion as MULTIPLEXER and MUX_CORE need to share the same
> state, i.e. MUX_CORE in menuconfig must not be set to m while
> MULTIPLEXER was selected builtin. Further confusion occurs with Kconfig
> "depends on" relationships that could reference either MUX_CORE or
> MULTIPLEXER.
>
> It is common across the tree for subsystem symbols to be both visible
> and selected, e.g. I2C & SPI. In the same spirit multiplexer needs to
> ignore this particular kbuild rule.
>
> Add prompt and help text to the existing MULTIPLEXER symbol, making it
> visible in (menu)config without breaking existing "select MULTIPLEXER"
> occurrences in the tree.
>
> Select it by default when COMPILE_TEST is set for better coverage.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Please drop this line.  Merely enabling COMPILE_TEST should not
enable extra functionality.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
