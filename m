Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62483C00B4
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993644; cv=none; b=ZOw5xFkmAsTRSIWJ1ZEqipgeC8hl/B32cjOtBkcC/d+dJVC4TIXL0uc003eyPIhvMXY20ZaF29i0xD9YU9WbGIqaDlNI1p3yAzc64SlGMzNwe6rbxaa6zZVk3uF8VtX69hVENna/i28hvNT1dmZwhUmn2J59KaRai/8SvvyIEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993644; c=relaxed/simple;
	bh=cysOwS5g5dZRSxtVrJ3zv/VB5w+D2iLkyCuaPMhXFP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfoF2fAaiSVPpYUhmDSh3DTs708LgOv3RTJC8HqWx5lADGMAd4xHFhbImTR6ISTsB8SdW6A+xQZpA4VxvHjbsF9ES5EaNyPIMPVnx6rC+1CHb5gn6ATRiUwOl9GZQGHdv6EP8i59c2RoiZQQ2eZv07/4P4dex6WOwzWHhvlQ3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c5386f1c9fso929667385a.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 03:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993640; x=1769598440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSYJm8i9wWqRvGvRTZz6VIsl7/oMewZT8tw/+hAgWzw=;
        b=JC0jS3Ev696s8+R8f2Jj7t1wS9O5g4tXX/ul8ZaYOq1+mUxgWgAl3JSODQrHO37yeZ
         +kNK/I5mmKoQyM1ZrVMx28btlrWTb3ijF70fjVWxOQ2mp4/JocYG+xNMK5LGROC+hHv0
         3ZuW/mtuG0hj2Y0mSoz3dvOXwVjVAK5tbiP0PZFHfKxliKgeiXF+44OjSmFVrkviKMbX
         6vUYkiKOuLUKepqMD6dwwjRVgqTlZAkPG6QFSacsGsxZM2ElZJPc6OjKjZKEn8U0Ch6X
         jzA3EggwEpi4JgeFBbVib0sXOUbTNOceGu4W4vpZtze2L2w2oVOU+30Tcap3A+E9XzM1
         cxJw==
X-Forwarded-Encrypted: i=1; AJvYcCWXcKC9SaBBKZw+whM3bJpSnggBx3vyIzyS83KDlRgkIWkPy+sEsvPisaqHppRGTnGnlR2c761y9F/P@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAq48fb3iY+gBapN7wtSwKnQ2xIoHc4QaSTg7sDfUlGgF+Qcf
	icEPX+x5aK5iviUrCaf/oa1D+yQ3O5jQ2YRoAzxvGVFR4VyiLwg3YtGEuC62l4I8
X-Gm-Gg: AZuq6aLquD47znA46y6tEo4ETd20iIBKmcMJBe1sfSbEbpKPgtHiiwQCMizfySgoMGi
	CX8iRqoSKijyxeFimMaliEsgTHA29l5oNTg6YiV0GG2a5eK1yY63XTDv+zbAQDErVw0Y4yuDcbq
	ILk3in0vY+lb1EeGxNE6/TLR7etbaun/wl5AiESmiK2MYEJkyKR5CY61nEEoxVd1g7zRyWULnxj
	OZln2n7Dr7o3cBZnjrdx0zepwEO+Xqxku6uw5Eh/X2zb6O2iHDFKq49UOgy36qmos7oKJWAx5E+
	El46DSOTmWW8FKiN6Yad0qCbbRkJqA+1iEuRD9TGxY7yOGPSk187DQ7gpV4wpCufZK08Mqjm8L7
	rfEFg8mL5jGiQdgMyBLD+onzF2N7Jvu3lNhxXhi0YaSZ/ymGLBCOUHxyN2l7uBexiVMRRp2Hm2n
	XTpEfcexNUu0jeitl0DwU8+GFLNip4G+NnKV3iM8jHeij4I8BHxhoB
X-Received: by 2002:a05:622a:1488:b0:501:8643:aed3 with SMTP id d75a77b69052e-502a1e41444mr233850841cf.35.1768993640553;
        Wed, 21 Jan 2026 03:07:20 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1c1c4sm106831361cf.33.2026.01.21.03.07.20
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 03:07:20 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c537a42b53so958263985a.0
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 03:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNmidqc5+sJuxQy6utTbfY2xi+AxK3q7CuAIuWtlVwfApC6r4j+ZUdKkeL28cpWF1NRke/z6Py9uxZ@vger.kernel.org
X-Received: by 2002:a05:6102:2ad6:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5f1a716fcbcmr6150752137.31.1768993204250; Wed, 21 Jan 2026
 03:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com> <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 11:59:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
X-Gm-Features: AZwV_QifTISU05sQ0lYySqx5XyPjAzUqa1H8fmOUOfLhWhGN7rzCzfM2UGq26-s
Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mux: add help text for MULTIPLEXER config option
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

On Wed, 21 Jan 2026 at 11:02, Josua Mayer <josua@solid-run.com> wrote:
> Add help text for CONFIG_MULTIPLEXER to allow enabling this option
> through the kernel configuration without explicit "select" driver
> dependencies.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -5,6 +5,14 @@
>
>  config MULTIPLEXER
>         tristate
> +       help
> +         Generic Multiplexer Support.
> +
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>

Unfortunately it doesn't work like that. As the tristate has no prompt
specified, the user will never be asked about this.
You should use something like below:

--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,10 +4,8 @@
 #

 config MULTIPLEXER
-       tristate
+       tristate "Generic Multiplexer Support" if COMPILE_TEST
        help
-         Generic Multiplexer Support.
-
          This framework is designed to abstract multiplexer handling for
          devices via various GPIO-, MMIO/Regmap or specific multiplexer
          controller chips.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
