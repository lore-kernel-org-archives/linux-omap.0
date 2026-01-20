Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE383A7E13
	for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931698; cv=none; b=XIgs09d2gO2WH4s2bI1DpFs/2XtBJK6BhKPzjghBDhiG9Ka+kK3XAZWcxaRUjQXrKKT39dltwGkscpGsfFR0hzc7K/OWF2u9iNKt+MVS1kzZ8gfvPNsCWC28wgHFrmjOPxg4mXEegr/WujuVKE3DaBi/NjU/PMfLxgt2WktgD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931698; c=relaxed/simple;
	bh=3/JP3tCIvtYedAAyMYL0a51zMnc14SZU20ikWY9BXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdur9pD+j3+5vC+A95UE1OYMNLJc+M6PtuXB6+shdfBV3Zjp11zaGVw3FbIowaZkMsmoPax6il1ZHJd/3MDJJAUydgQrmYI5fWS58j4X8xg8W7A9tieZw/szX7GA0zttV3lH3ahO2ilM8CRAkgarcJ63osczG9/DsM/VnpAQyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50145cede6eso45419661cf.2
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2026 09:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931696; x=1769536496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcPNSr1vco6+E9e0XJi5xyBPxmbRiBl/7/yDisLqrnI=;
        b=LlTFNx0G6ZD8EOht2LSTk2trBa6D8IkjWPcqLr7/aoMzG7RGW/fEe9g6p+Y0kUvDiw
         prb04xWHwGCMW8xW8Do7veDI/KFlf92+dX4hPkblC0jCqWVTH1t8XseVf4nUkax87ioU
         /f9AT2sJAfw90YwKgr88inT8A4iggdbzxef0JAnX1tFSEH5oX6/phV2zq1N+yPPYxvAE
         bLKlWW3L19qhTpT8GdvtPdN1bBbP6hV/3Yj3e6RA0Tl6Yxc8isWhaYmaAmPNsbPG+GWb
         k/yOUB5b+4cnSHa8gkecsoq/h0Bv9koxD+O+9A36x4F8aKQDGxSpe7oJOhc1IUzbLXtg
         QsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFObTfClnHrVBHj5qZKgy2rJA+78RVa7LFCl+jfdHEOFlgRzZw+NRr2lQLes4OV1dEjNtoRsS23VAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMgULG8dSgzV16l4SUUUNUXcyKdmZDYrSrTtkd8+bMPRigdj/
	4vHAeP3rEUo2sEvDjZDg5iOCgUVhB9iMKe1sjDsLzPh+fuwUDx/cAU0axi0f1IIc
X-Gm-Gg: AY/fxX6zn/CrXN3WQYSMXtt1+4UVUSIy1ODDj3Vv152pg1G2MKW/0CnE0UmUSBnz5rQ
	GGObRUk/jAfa63aF1mWP6Bp0T3i/o13cg+FNghKdbQokARYzAxL/U2bIrZjlTBSTphrVPE6UYvT
	5zaPoqXd886K+0RXr5PjTV8ilbNpVb0fJj3A6dBVMrxewkDYcelDPLkPwTiqXp+O2Vwr1/RM7JH
	40oI4emLQ6DudL6ls2dRZpo08noaM6j9GD4p+TO8k1noi7adQ+jQj5QvwNrOcqEdsbLjNaUhbHt
	AurOBy+nzXzZiVcEfwRxj3PZK0APHsQm74zat7XvjmMbm7jaygkMDuUl5vn7R55a5fSsMvkx1bV
	4T72COOYbJr2yjFpwAO5+muS/Ub4jSNNnqVqirpE8Ez+RfYv1R1MPgXZhYX9qSVAw5Y4k+6dAsW
	JGpMpDi/K5AWT5sYfoMqhtINz5/dGNhHvIYmegSkDwvOl6E8M=
X-Received: by 2002:a17:90b:5443:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-3527313c126mr13186797a91.8.1768925143054;
        Tue, 20 Jan 2026 08:05:43 -0800 (PST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35272f4a9a1sm12402050a91.0.2026.01.20.08.05.42
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:05:42 -0800 (PST)
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f1fb91996so12475858c88.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2026 08:05:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaQov7Cv9kGSTksz8oWFmKktJknJIcKalyeCazUOkhHS/Yx9/ThkFjFN4y/JTgc8ZnYCymV1wALh1r@vger.kernel.org
X-Received: by 2002:a05:6102:b15:b0:5df:c094:628d with SMTP id
 ada2fe7eead31-5f1a6fa3ca2mr4116825137.3.1768924652088; Tue, 20 Jan 2026
 07:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 16:57:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
X-Gm-Features: AZwV_QgiDRrYV1BByFjO2lg9vbxQpf_lMefb8OE6E5E-nZ3iF4svsU32o-Zkiz4
Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
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
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
>
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
>
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
>
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
>
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
>
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
>
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -46,6 +46,16 @@ static const struct class mux_class = {
>         .name = "mux",
>  };
>
> +/*
> + * struct devm_mux_state_state -       Tracks managed resources for mux-state objects.

Please run scripts/checkpatch.pl:

    WARNING: please, no space before tabs
    #80: FILE: drivers/mux/core.c:50:
    + * struct devm_mux_state_state - ^ITracks managed resources for
mux-state objects.$

> + * @mux:                               Pointer to a mux state.
> + * @exit:                              An optional callback to execte before free.
> + */
> +struct devm_mux_state_state {
> +       struct mux_state *mstate;
> +       int (*exit)(struct mux_state *mstate);
> +};
> +
>  static DEFINE_IDA(mux_ida);
>
>  static int __init mux_init(void)

> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h

> +static inline void mux_control_put(struct mux_control *mux)
> +{
> +       return;
> +}

    WARNING: void function return statements are not generally useful
    #441: FILE: include/linux/mux/consumer.h:139:
    + return;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
