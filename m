Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897E1D9663
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632262; cv=none; b=fMqK46swX5XpYuracGzShry0XxKJF6+xvH+a5Amz26zZoOByvpBgijL/yN42dUCiqJFt6XXR9+I/hMBf2IIlTdXWYT+ZfSUYXYj9NNG8b15kvmogV8QobFwalNzekPYKNsvbxvj9lT/5PuqxL/5nj7C/BS0bHmzPIVuUwFt7cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632262; c=relaxed/simple;
	bh=J73vKAZhiN3K6G/5fpGigw+8duj0Td3xLp2ybYYDes8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4bAwDqWnex5H52XJqA1HGvHqNb+tWJMPNRc5X5ii13RNwIugTmElRIHmeaddi9tRyXAn3s/awuScVcjqQn6Dk1ZGLuIPBwaY8iwa7jiOPppgqfv+siAPNkIGpaTPcgliBhvVcT0CrX97r2KzBsrUXRAOSxn6JpBMlOAE7F2WoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-563497c549cso2544942e0c.3
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 02:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632262; x=1771237062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55b+49cOY521wvVXvsz0WcOQjNDu8cxcjrZIHfMxzy4=;
        b=Cxdad/ghLzhl/d0QxJIsXjfEBtmuD3UWDqxJezTv/ulfJdEu7FfPZ6Pvu2da+Yz9br
         2Qe8FWBKOxHL/J4+XVpEP7RoQ2Y+PoX+BxU5oMuGtbNO+AlivPAXTGIJuN0+Cy33+GBF
         YOIQhDwYTCrUXgBQTbdaDNc520A3Uxa0/jXGqZ/Us93d6bYAF3IgUwKJha7J9Ml06prc
         GTyWosV60AOFdeW5zqTn3EJs4p30W/2iXLhotdlN39jze07uYTcQN4QQWDEXByN018fu
         9/GLy1ZTQzLhplXTc0YM0jQD8dc0c3D2b0dnCBRym0oo83p0h6HyOZfcBkixeSa4R/M9
         ON5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVopSG8UAf5hLkArJFNgUHCwDrZnkfiuNRX9twYm6FKrozqLFpVe2+dFCm1cIbrfN2WAMWJZTR1cZ6n@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHXJi0xx7PjxGlcdEldoYO+4sqSNJKUibt01YGSxE6ZxFPdpY
	Bcd6P6Rm+2xrMnZDd13cQXccKM+s+l104SjDKvKBoets9VhCGbp59cO8BYPUTkJz
X-Gm-Gg: AZuq6aJRiTcaLJxE0/7PFfntcaiP1v1ThZTH+eruLvyB4x6BRoXsiJQEvmntT9N32/9
	/HisW3IgB50FjyiP7gyX5JPxcY28y2udAdgbvX3tUqf4XBl30L5ZY/W/9T8qFfh0GC57rfQBYkw
	NIHSeoPhecx7lBoT3tVsfEK0JgM8oTpnmZBV7lLgifewcfM0eRqVFDwuMOBSgYzjR62tEy4XRcD
	n4PWXnhGxOmSJ+I6AmC9itJDt9pzZn4Cd/9eg6JUADjHD+EVFi3Tm7LlGu16aRF1jflnhUvyDcd
	bqFw/rd+IOIw64H9GEJFF8/f6XTFGPmZ7wTp8tS398zdTU95KE0/XxsDK2ubrjVQBjH7q32ESht
	5TwsqzDhaf6rLhJgB391eAwXp2Jdv5o+InneBPdeA7cIh79moCTqjnp070f8c+CsYRBQTcZdywB
	LidLHw/GS53An2gRGqKLxSiYYd2YViGBDBv0E+YyIs1lJ+UhR2f/Ov
X-Received: by 2002:a05:6122:a19:b0:566:3b13:8208 with SMTP id 71dfb90a1353d-56705e8e97amr2654568e0c.5.1770632261643;
        Mon, 09 Feb 2026 02:17:41 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5670719c5f5sm3873655e0c.0.2026.02.09.02.17.38
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:17:40 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563497c549cso2544904e0c.3
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 02:17:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzvSaQahwibXKZKygwJeK2SRpoY0j655z40g6rjm1ypAvFGjaqZwzCQTP6iV4d6MmuZ8ZxQonNIwMx@vger.kernel.org
X-Received: by 2002:a05:6122:3c54:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-56705febb0fmr2935090e0c.17.1770632257982; Mon, 09 Feb 2026
 02:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com> <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
In-Reply-To: <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 11:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
X-Gm-Features: AZwV_QizeLChl5bqEs0QtuubG3nlVKZbEpUJtWLc1m5RmCDOEU_VrUSeQPEZi-k
Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
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
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> > On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >> On 03/02/2026 15:01, Josua Mayer wrote:
> >>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling thi=
s
> >>> option thorugh the kernel configuration without explicit "select" dri=
ver
> >>> dependencies.
> >>>
> >>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>> ---
> >>>    drivers/mux/Kconfig | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>> index c68132e38138..e31c46820bdf 100644
> >>> --- a/drivers/mux/Kconfig
> >>> +++ b/drivers/mux/Kconfig
> >>> @@ -4,7 +4,13 @@
> >>>    #
> >>>
> >>>    config MULTIPLEXER
> >>> -     tristate
> >>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >> This didn't do what I thought it would.
> >> It was my intention to allow enabling this through menuconfig / .confi=
g.
> >>
> >> With the syntax above menuconfig shows:
> >>
> >> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >> =E2=94=82 Type  : tristate
> >> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >> =E2=94=82   Prompt: Generic Multiplexer Support
> >> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>
> >> This means it cannot be selected.
> > Looks like you haven't enabled COMPILE_TEST first?
> Correct.
> But CONFIG_MULTIPLEXER should be visible always,
> not just when COMPILE_TEST is set.

Why should it always be visible? All users select it?

> >> Instead I (think I) should use
> >> default m if COMPILE_TEST
> > No, merely enabling COMPILE_TEST must not enable additional
> > functionality.
> >
> >> Since my patch-set broke x86_64 allmodconfig and failed merge into
> >> linux-next,
> >> this presents an opportunity to change the above as well with v9.
> > Ulf has already applied this series to mmc/next.
> What would be the process to fix the build error for x86_64 allmodconfig
> now?

Incremental patches, cfr. Ulf's response to [PATCH v9 0/7].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
