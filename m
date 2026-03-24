Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667963DC4B4
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368996; cv=none; b=g/SljkD8gzad/yj4cX6TECepR7MQO02RBUCimhvm1bX6swWpRqAzj14bUAjY7XRE9+ezDL5si3MZwAMHywyqw6so9dsG46T0ni4d1xyHlRZw5oQShgxn0Penok+nQmsfDIWHg9nyZJ+g1ME+CpbBpCkGp38kmYektkJUH6jWLCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368996; c=relaxed/simple;
	bh=BIc3wHAs8s2sPATriFf+fq+uKIS7NsyRMXlyBl5vVsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLb2bPJv+p1wT5QuZI7m47oK57ct6TvvUl5KRhULDad8FujO6noiHNQSVcKZbvDxTrzYPp0mFV6/BN7sChUKiOTGUkTAjR9dIslEuq1DH6WXr9GZXSd33oMGaxzVSfyCzSexld6Ez0IwkRWWf+Lba/MF5iQPNP6JpNQC6yyqdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so444569e0c.2
        for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2026 09:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368993; x=1774973793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmRf0clXa/z48rdOhDwIqsCZTl6MAr1IPl0XdGWzmtg=;
        b=H3Jko78uEaBx66Ddcm/I3cEW+bF6Pqq2i7kh/RC2mHQAMlMPSSIItaMFhQUEwSN7f+
         8B35v/K976XeQmG20JKkC4f9cRBsvNgW7umGsLD36hwrwDYUKmr2Ca+hUP4BIpNf1QLz
         DjIsM6Vk8HqTond9sERQJMt/xIhseogkxSqSDuirNbzFGfdJPnW+3rFOSWFCGNvCKPFH
         afJ9lU0/lfbvGNVvku2WplxxfF1g8ep0U4c0gFzDyJVAw7V1NBdtF3e4S3A2pNHDz1Fu
         xgaBHZg7uq8c3VwjNZJICoriS0golwDKRwKMa+7VYOGGJmpjOMULQFjOq5MYIvtCGwBc
         alMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuxxZBPMQZYJBXQP2ARUufg9g2gTpA2MFozlWOcKNZCM0TlY2kU6oVARDkZ02FO+A7VprAydkne3JV@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzbWYfhCAYEGBTd0a4DGOrd5St0pZzBiNOY71e86TdenG3KGU
	zxAYNziFfbelQKSlmZY0NQK1KdnMDme4m4HpPVI0s4pYDdq1x6s8WGRKydFlfWEsZn4=
X-Gm-Gg: ATEYQzwXufsJUQRyc4Eldqokc036u6pM6KRyGKS0HD3NWx3FFcJvok9aiNLQa48Ff8L
	HZYFUkkQQWs0WipjKdS9KQy2ZouTATpdTRQeNTswdlSUMWCUjbDi2Wvyp5jU5AOG4YRyBSt3ZYU
	1LLzb60t+P0DYDv1xuxL01+eCDfoR91WhqLjKUkkq50HD6ZopVvbn0h0NmTT5RoP1hVlnKYSMFg
	fySZS8BKps1748XE9xCm/PmrKCim8aL1wtzlwYxA+CUCn14xLbw5UvdSF6cUe4nyHRtrmomPP3M
	Q6Vgu33lcPVE5cqbsfl0CEvi1aqTBbQNqksZceWoGQ4xfE2VaEe7PpQzdBVFof2JwT5uP9KS8WB
	ltyGXXC3zSeFUwc6d7mZpXKcbjKWqoz3br/n9UDRCYcGxE6m7ZlkucI8xGXsbLWUyV+jdzTZBpg
	AAbyf3iscFSs1TDD2vDll99HjcfeY12VVOfFm/GaTpmEMsc7t7hN4I59+EjMis
X-Received: by 2002:a05:6122:4902:b0:56b:a6b4:5902 with SMTP id 71dfb90a1353d-56d220be510mr255712e0c.16.1774368993169;
        Tue, 24 Mar 2026 09:16:33 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddb6d041sm16457154e0c.1.2026.03.24.09.16.31
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:16:31 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-602903ad849so545917137.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2026 09:16:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoPefN7ZLxTofar4Kt1gIKOd6BRgkSiyQJ2S7i8BHu+uawCSd1u18j5/l9cd1vHiWxj9NtpjF71fin@vger.kernel.org
X-Received: by 2002:a05:6102:5801:b0:603:270c:9ece with SMTP id
 ada2fe7eead31-60386ebc7d7mr249544137.11.1774368990997; Tue, 24 Mar 2026
 09:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com> <20260309-gpio-hog-fwnode-v2-2-4e61f3dbf06a@oss.qualcomm.com>
In-Reply-To: <20260309-gpio-hog-fwnode-v2-2-4e61f3dbf06a@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 17:16:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6RuZXAozrF5m625ZepJTVVr4pcyKczSk12MedWvoejw@mail.gmail.com>
X-Gm-Features: AQROBzCujwdtX4JkcLDjVnd6LogBn_okx21mGqzFRhZGg9NW5EWThevgncjlCbw
Message-ID: <CAMuHMdX6RuZXAozrF5m625ZepJTVVr4pcyKczSk12MedWvoejw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] gpio: move hogs into GPIO core
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Mon, 9 Mar 2026 at 13:43, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
>
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks for your patch, which is now commit d1d564ec4992945d ("gpio:
move hogs into GPIO core") in gpio/gpio/for-next.

This breaks GPIO on the Renesas Marzen (R-Car H1) board:

    -gpio_rcar ffc40000.gpio: driving 32 GPIOs
    +gpiochip_add_data_with_key: GPIOs 512..543 (ffc40000.gpio) failed
to register, -22
    +gpio_rcar ffc40000.gpio: failed to add GPIO controller
    +gpio_rcar ffc40000.gpio: probe with driver gpio_rcar failed with error -22

> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -960,6 +960,98 @@ static void machine_gpiochip_add(struct gpio_chip *gc)
>         }
>  }
>
> +int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
> +       struct fwnode_reference_args gpiospec;
> +       enum gpiod_flags dflags;
> +       struct gpio_desc *desc;
> +       unsigned long lflags;
> +       const char *name;
> +       int ret, argc;
> +       u32 gpios[3]; /* We support up to three-cell bindings. */
> +       u32 cells;
> +
> +       lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> +       dflags = GPIOD_ASIS;
> +       name = NULL;
> +
> +       argc = fwnode_property_count_u32(fwnode, "gpios");
> +       if (argc < 0)
> +               return argc;
> +       if (argc > 3)
> +               return -EINVAL;

The GPIO hog at [1] has a gpios property with two entries:

    gpios = <17 GPIO_ACTIVE_LOW>, <18 GPIO_ACTIVE_LOW>;

hence argc = 4, which is considered invalid.

The check should take into account the actual value of #gpio-cells,
and handle the presence of multiple GPIOs.

"git grep -Ww gpio-hog -- arch/*/boot/dts/ | grep 'gpios\s*=.*>,'" finds
several other places where multiple GPIOs are specified.

> +
> +       ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios, argc);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (is_of_node(fwnode)) {
> +               /*
> +                * OF-nodes need some additional special handling for
> +                * translating of devicetree flags.
> +                */
> +               ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
> +               if (ret)
> +                       return ret;
> +               if (!ret && argc != cells)
> +                       return -EINVAL;
> +
> +               memset(&gpiospec, 0, sizeof(gpiospec));
> +               gpiospec.fwnode = fwnode;
> +               gpiospec.nargs = argc;
> +
> +               for (int i = 0; i < argc; i++)
> +                       gpiospec.args[i] = gpios[i];
> +
> +               ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               /*
> +                * GPIO_ACTIVE_LOW is currently the only lookup flag
> +                * supported for non-OF firmware nodes.
> +                */
> +               if (gpios[1])
> +                       lflags |= GPIO_ACTIVE_LOW;
> +       }
> +
> +       if (fwnode_property_present(fwnode, "input"))
> +               dflags |= GPIOD_IN;
> +       else if (fwnode_property_present(fwnode, "output-low"))
> +               dflags |= GPIOD_OUT_LOW;
> +       else if (fwnode_property_present(fwnode, "output-high"))
> +               dflags |= GPIOD_OUT_HIGH;
> +       else
> +               return -EINVAL;
> +
> +       fwnode_property_read_string(fwnode, "line-name", &name);
> +
> +       desc = gpiochip_get_desc(gc, gpios[0]);
> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);
> +
> +       return gpiod_hog(desc, name, lflags, dflags);
> +}

[1] https://elixir.bootlin.com/linux/v6.19.9/source/arch/arm/boot/dts/renesas/r8a7779-marzen.dts#L196

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
