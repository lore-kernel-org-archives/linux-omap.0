Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82182F28E3
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635351; cv=none; b=GLzUoaHIbxR1/05vvw126lrCAzi0Cl4YU45mFLbZt8J/+2/k4LHJbfL7TL6xNSpNuHm7Zen9zrgDCWS5B5L/Fs836AkBsmk7bLtH2cl7qs0sbsrgMaVtg1VhMw58XDHXlctIXV+7pSdSBSjoPeCLAqcvkiaxNdL+5g4tJZsjY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635351; c=relaxed/simple;
	bh=sC1KLy2SPQ43D9OQaLHsL9GAH/uPG9wpQURfezxkw+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjBEILIqvcRH2qNVN7kKdGr0/1Nxgplvck8VVwEIIM1sinJCY98fUaGxxh4tbk4Y3yO4PNHoBgnae+IKY0x4l0+D00/QdE/7P6k+UKF+q08C87sSFNIAsgxC/xT8FS8S26n00LxKN3a5KMLvlu34UAUhCVqg0TRw3mktAu3uNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fae34a2163so2254763137.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 03:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635350; x=1771240150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFhQGFBF0i+66a0TJna2Rm6FRsUIJ3sMEDyWqu3+t6g=;
        b=d4kzvVceDt4Pc8t+TYJs0r4viunDIHxyEWvZTgpckRx0UJ2NwCDzuDiA0vNSiJi4gZ
         aTGFjj0rByNinMVWgxzwE3BRU0UKllUWSYEM4cg3H+EjMVAUrOgibHGboxcAizX1bgjq
         Iq7uOAN/y41BNIobAwwZDzaJ4D9EPkU9wokqO9KDXqgqTQmpe27c78Hmq5f11iviMpX8
         UHu2VCQcWqNp3iRzJ/oH/Vwo71gXXeZhsvLXDRXr2kcfaWy4sh8OsbaQahzpaY3uUkvA
         O8v0Xl64u6mfMtDoHTtQ1pdVh4f7VtmBrey+CzpnIWft5szb8YaQDRGua7xHHzdepoB8
         e4wA==
X-Forwarded-Encrypted: i=1; AJvYcCVaYwbExcN7rWR1rIpuTiTWNQ3lPBlai/ULVzMrEOOMCYkAjKTl+OFFzptv9pcwHQaP1iDBhjXuClOM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkymv3KT+KbO8NWr7VMlFx1WeKAL4LGTSEYQGPn6bwh8nKbr7t
	XF5542UD4PVaDRihssd/gH1/04ehwlsSalUjRonNjge7ZGOX6uN+xLj3RkLXrnuK
X-Gm-Gg: AZuq6aL3paKoy3eze9GJrckatj/GUIY3k6/ljyPrFs/uANFGWV5PCwHSPLqJlfunP6k
	sWPe4EHicX3R2/hHSIwYdZXzRsjWznl9IgevFQcnZSXuokSPter5BbCz+pKo8Y7YqXLe6DY+KP0
	lHfpszI6W/CACbKn6lonq6XhOSVuJnTPkR8vNLloFPPVGn3a3AfWFLdiFFhnkQKfkgTolWpOrxK
	W0zjYcjA07+IUmQhYLTTaZq7FRvNrQblH35dhq+BGh4dd4OLW54UXoU2jAV9CgPlQLx5YadIbby
	TbLvV6GvlYDD+9v9g33quVIMSY7EYfmFZA0BaG+ntNcE7PMlOi+UJYN3rPm5yQOIMcHZYwWzv6h
	tAxne75WEi3Ar1g67bDrCa5V37G9rkyPtJACOB92a6/qtHeTWZzFbn6ZC0tykLS+Z/uTjfwxhDc
	UHMxGdUFm+5g/zH8WmCFLuhd9SD70/b+AhdyektIPCMypjJzqIb/sc
X-Received: by 2002:a05:6102:f10:b0:5ef:ac78:3c77 with SMTP id ada2fe7eead31-5fae8aafb2dmr2702543137.18.1770635349830;
        Mon, 09 Feb 2026 03:09:09 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8df94a5sm3283101137.6.2026.02.09.03.09.09
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 03:09:09 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56637565faaso3895138e0c.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 03:09:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxGHSu+bPB2TLM3hF+XJIJ4wdwMPHKsarO36EKt+8hGXbnIXslqEkF4Bk5VWbkLhpJRV4d28Q5hc+Q@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:5ef:ac78:3c77 with SMTP id
 ada2fe7eead31-5fae8aafb2dmr2699695137.18.1770635026255; Mon, 09 Feb 2026
 03:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
 <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com> <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
 <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
In-Reply-To: <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 12:03:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
X-Gm-Features: AZwV_QiXoAPXWcsFJ5cXmi5LxanLCRJoL8Hmi_xM0cWtiaFZbVoUaSfpkEx2uEE
Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
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

On Mon, 9 Feb 2026 at 11:47, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 12:17, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> >> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> >>> On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >>>> On 03/02/2026 15:01, Josua Mayer wrote:
> >>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling t=
his
> >>>>> option thorugh the kernel configuration without explicit "select" d=
river
> >>>>> dependencies.
> >>>>>
> >>>>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>>> ---
> >>>>>     drivers/mux/Kconfig | 8 +++++++-
> >>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>>>> index c68132e38138..e31c46820bdf 100644
> >>>>> --- a/drivers/mux/Kconfig
> >>>>> +++ b/drivers/mux/Kconfig
> >>>>> @@ -4,7 +4,13 @@
> >>>>>     #
> >>>>>
> >>>>>     config MULTIPLEXER
> >>>>> -     tristate
> >>>>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >>>> This didn't do what I thought it would.
> >>>> It was my intention to allow enabling this through menuconfig / .con=
fig.
> >>>>
> >>>> With the syntax above menuconfig shows:
> >>>>
> >>>> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >>>> =E2=94=82 Type  : tristate
> >>>> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >>>> =E2=94=82   Prompt: Generic Multiplexer Support
> >>>> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>>>
> >>>> This means it cannot be selected.
> >>> Looks like you haven't enabled COMPILE_TEST first?
> >> Correct.
> >> But CONFIG_MULTIPLEXER should be visible always,
> >> not just when COMPILE_TEST is set.
> > Why should it always be visible? All users select it?
>
> This is not relevant for v7 now and can be handled later.
>
> It was discussed previously that drivers supporting optional muxes
> do not need to "select" MULTIPLEXER through Kconfig,
> E.g. the renesas sdhi driver.
>
> However other drivers are already selecting it even though the mux
> is optional, see e.g. phy-can-transceiver.
>
> In order to support muxes in renesas sdhi driver e.g., users must choose =
to
> enable both the renesas driver, and multiplexer subsystem via the
> configuration.
>
> The mux core standalone also supports a limited use-case without other
> driver
> interactions, setting idle-state e.g.:
>
> mux-controller {
>      compatible =3D "gpio-mux";
>      #mux-control-cells =3D <0>;
>      mux-gpios =3D <&tca6416_u20 0 GPIO_ACTIVE_HIGH>;
>      idle-state =3D <0>;
> };
>
> So it can be generally useful for a user to enable CONFIG_MULTIPLEXER.

Then please say so in the patch description.

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
