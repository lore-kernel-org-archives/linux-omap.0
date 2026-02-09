Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D972DB7B7
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624765; cv=none; b=MLI/k1DU9opfr6BeYOW2+3xiRHemVk5rldX+/2sF02/8jQWu32pE3uGwYPG2odJVHOSkJmEFY1wl86opPVLASWXPh8I8fYoxe9OSxtQFugYEkeuqD4o51TySU2HRovYOJOgFTUcyrCKv19LxW/RvYmZUY6v6Yh0mtir9wKJvVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624765; c=relaxed/simple;
	bh=jGnKFIqAqLu+rNpANBkHFw8kJ3LdtX3G4oazBBlCuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItN5flSbRFY9Iz4r+6s8m2eFKnKaOTZ4vRZsMLqZ87ccvlRkJKIXSyEvR1y1jUkxfo+ylIJLOnOD8YRbR2QTQOdPspIhx9Hqs3xon2YEewsIcvUW1BVRDa2PYAyb4b3qptzxhhXnKZUNiJuV5mWt25vqTYHq58TiIsZH5qSafKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-503347e8715so34052921cf.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 00:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624764; x=1771229564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9pK4QYIZutXAE3AMWeCiy3lF4Ku+2UbgC78kdie5tY=;
        b=vZx6VoT3zO6DqrSUQCLC5EUWmUdpjOg4oVdzNbD++RbmdgqimKSwHDvBgypjpCJR1U
         fggdj+/yB2fs3uczX40f7jIs6Jdc//d1cHyQ84AMo10jU7Un5zD6537lbdTMI4pUSBsm
         NFMHzX0ahww2tioz9ugGWtmjyZOm4dDAY3N9CvDEmAzK8A50e6N+OTGcxAW2ZhHIjpiE
         DsSVHRTX7eH6cmRQcT5bFb6b/7JEUqqh4AFppb3qGaNO0yyoGC/BaCpCoKaskbQMJH/Q
         B6fRmKXCZboBqQyCJQbAXQQRK+dvUWDghIwf24UDxanWu/rA6VQ4+P3fe8O3tXR9sQKk
         uUCA==
X-Forwarded-Encrypted: i=1; AJvYcCXuTdDHZOjvDIAtR7mrbpYaecmRTG8vMNoeJyh789cM4WUpTdR2FXcfZcuQMg6Dz4+yT83LdHNvb83F@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1hGwsjPcfW5AI0KmyZp0p87Km1WKlFiSknv9DbAbXp7xrpEO
	/E0JDxPkucTmjkGCbwJwjVr5Nf+0IhpGSz481QC1g549xTcndXeILtwmfPoGeKWA
X-Gm-Gg: AZuq6aLIJhixAzoVIa7vvYey8ga/HR7Ksn+1fT6pd/omI9z9TWjH5GrIPlv8qQ2m4Hd
	XkiejNoLmfA6KPJY9KGuhdWoT+yLP5CGCTtleWQ7z31NJZNugTpOiEO6mOLOLYKuOFZhbowjW0q
	KQRPnbcb0YmygE0NND4z7IPAtI/TEDD3UmrWLWsIJ4L+74XedXp4/ogCHM7yIzlJvIqyaoOgbT2
	sdzNQFs0GJbV2soFCC1Wd4rEsq9MPp9I+eq7lzcU2PMzSqGbRB0ZFXdl/qx2vVuZmsDCZG4u2he
	XpNOoUp635xTpXao4S44hvI1sTt3ZYy6pShGYWqA5mpt7HWT2yGRKPbf2Cme4CMFQwrFCVJS8AR
	v8ZYWt7PQRpPLLbkMGgXQmmjZGtJJqsHgJUps9Bm9W7G25NLTqAb6TBa+i23Qe3G9lJbunxNtxf
	mMnSKNhb8WqYtOAzXcxM6eon7lli9CGQZsEFGdI4nKMHSeY/t5FRfS
X-Received: by 2002:a05:622a:108:b0:501:4c45:b206 with SMTP id d75a77b69052e-50639976a5emr149673341cf.64.1770624764068;
        Mon, 09 Feb 2026 00:12:44 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c0599b4sm73687606d6.41.2026.02.09.00.12.43
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:12:43 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c7199e7f79so381420985a.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 00:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDQfPc8eL4W7nWtjbrOGt1MorpD6vAbLeXChs2AVdHatkfWzw+nDuMap3QMFn7vjpcggxIz6zXXsB/@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f8:e2d3:c463 with SMTP id
 ada2fe7eead31-5fae8a3b31bmr2934943137.3.1770624379360; Mon, 09 Feb 2026
 00:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
In-Reply-To: <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:06:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
X-Gm-Features: AZwV_QiiqRuDaFts73-z5beOOIXm-WRqeTDAQV4zcAAegTI5YGKcuRUZfqXMUrE
Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
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

On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> On 03/02/2026 15:01, Josua Mayer wrote:
> > Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> > option thorugh the kernel configuration without explicit "select" drive=
r
> > dependencies.
> >
> > Select it by default when COMPILE_TEST is set for better coverage.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   drivers/mux/Kconfig | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> > index c68132e38138..e31c46820bdf 100644
> > --- a/drivers/mux/Kconfig
> > +++ b/drivers/mux/Kconfig
> > @@ -4,7 +4,13 @@
> >   #
> >
> >   config MULTIPLEXER
> > -     tristate
> > +     tristate "Generic Multiplexer Support" if COMPILE_TEST
>
> This didn't do what I thought it would.
> It was my intention to allow enabling this through menuconfig / .config.
>
> With the syntax above menuconfig shows:
>
> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> =E2=94=82 Type  : tristate
> =E2=94=82 Defined at drivers/mux/Kconfig:6
> =E2=94=82   Prompt: Generic Multiplexer Support
> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
>
> This means it cannot be selected.

Looks like you haven't enabled COMPILE_TEST first?

> Instead I (think I) should use
> default m if COMPILE_TEST

No, merely enabling COMPILE_TEST must not enable additional
functionality.

> Since my patch-set broke x86_64 allmodconfig and failed merge into
> linux-next,
> this presents an opportunity to change the above as well with v9.

Ulf has already applied this series to mmc/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
