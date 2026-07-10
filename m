Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F24408013
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679356; cv=none; b=E0P1UmaTD1jTb+1qgf5/B8EeIJBQf7yT3gPLTQLJcSjJIiCYp/x9JZCGZpQIdhyTo3LRt3t/KvkzwwTsgUjVYPEJ+SpStsGYLrEY08YMS25tA9nZBHcRPx61tAkpc6wE52o++JU3TrcZCa0qpGuGJM9kywOX/5L2EHLZgN3pgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679356; c=relaxed/simple;
	bh=8Lu8OMpVPc16MxdZvSkmOEt9Lvt01fn1EVEQixIYHBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clBVp6LV9JfOAep4+rPuPUFPISmoBLrIs4eCRznKot+KID8IUjYHN/xE/tpzRwu2OtvOUFwr0GfeNnhY+JWoDxNG9Zk3h0NJU4p49D+GQH/Eh8fPEfGfFXHnK8QULXdGWdtqLe8bC8gJYdJN5wdpTFe8tnddUP91bxdh9ep5HRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80cebd41372so10701727b3.3
        for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 03:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679354; x=1784284154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsVN2cPDw+/JUxMMLcOD68aRVLlq59TmevfTz9ChQ+g=;
        b=fgkWpmpF7IqZPnNM8xoksvi2Sk7M2DMQl61tHwAyAiRv8iQc+TvMI9n//N+eIII0ji
         37QH5srjhUREmYZVX9h4G0SrpVnIolNO8F88wDSuXMDmcyUdcDaHgDcW/p+ofx2/AnQC
         f3CMq0m/FkBKBpgJgU1/qwmNDUEdNB5spy7kJRTR3W9+7/vLUyAPBI9krkKuz9c/oKUN
         ZfycYmrEtP7SO+RsU3cQUGSi+OjAOli0A9Wdlvi8MT4o3019sCN8g8jI2AtSw+bXwTAG
         EEUSGP7WafiGqI/+G2Xq1gWTu88uYfmzOW93v8701xpUik3g+rOAjyJZtu9jR/fLuPXW
         GhJw==
X-Forwarded-Encrypted: i=1; AHgh+RqKZWh2xCMosIz9g6IS9863rif69eO+Rym1uUDT+aLCiwzw3KhQy8yoAmsQKZ0NEugk3NJOzP0bEqd8@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPJtwxAe8eSB7XGC+yc+ZyGCYcdyEUnAa46SrvWtV6Tcp+Mmn
	DpuRkXTONHWqR0pdvoR8GNkw6x19aeBJFqOYVqKIANyYcuy/2LtIcKxwoKiAbG9P8Ks=
X-Gm-Gg: AfdE7cm9N5MAJwZydeM0b0CX7+2tOawbdpQHXr4d2LJbnjqzeGNwSRvhXnpLX9n686G
	Y4TGlm2iZvW/y9yq9FypO6sps5R8Ub2XyILQT6mSnpUxkvTZwSDMmwds/9P6TwH6aUaO8TsqhVq
	Bk6tHC8EMNJIihffbq4HrD34yKgGhsMSRS0gSM1KMmFqvNKQPSSjerbMuVgte6xptZu5b8gXWol
	TFfDLukVH2oyVhjbaiHbRK2SbPJcLZ1TYxwrYeLfDRtk/KUpjGyz5+uAUhTymZ5hI36ZkauH3JH
	oas9MbhsqzG2KN0xrpqR2vThTkxT7NPT5xE0eZxpB/91ggz2Q7eCddTgiBE6IJFJXCDjTx0oMOK
	BZtVNw76M4k2z9GWjnCtUwkXYxHFg7L9NT7EDQJcTQ+ppEP5WSEsYZYjdNi+zokFnoT/RT3gf0a
	nEI0QVPE6P7hlgkWGwDEpmXjZjf3J6SbxDbRjvfyNNeveajNyXYNrT/g==
X-Received: by 2002:a05:690c:6990:b0:80d:fc34:a79e with SMTP id 00721157ae682-81dbe33df80mr85608317b3.35.1783679354163;
        Fri, 10 Jul 2026 03:29:14 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22ed8esm41033017b3.44.2026.07.10.03.29.13
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:29:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80d33d13a23so9670627b3.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 03:29:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrY86/Yc5lx5gZyuSqngOMC3/nf+1CDwFTMY78rRC1RtAR813RyKuX0Ko06rW5BIuPRfjIPEwoKc7hN@vger.kernel.org
X-Received: by 2002:a05:6102:3911:b0:726:e608:6658 with SMTP id
 ada2fe7eead31-744dff43a82mr6415934137.11.1783678885257; Fri, 10 Jul 2026
 03:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783615311.git.u.kleine-koenig@baylibre.com> <e5cc82aa51da5f545f745b126923fdd6085a68a0.1783615311.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <e5cc82aa51da5f545f745b126923fdd6085a68a0.1783615311.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 12:21:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4Thb0en6jeD23KhDp4pTe2F8o5GcBx4fnB+JAxPG-bQ@mail.gmail.com>
X-Gm-Features: AUfX_mxlLApCIjqxIsg4l7Qhe6Rgf_3Xy6YCZC9GZlPPApUQFkmqIVPuBIh_jUI
Message-ID: <CAMuHMdW4Thb0en6jeD23KhDp4pTe2F8o5GcBx4fnB+JAxPG-bQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/23] mfd: Unify style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Chen-Yu Tsai <wens@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	James Ogletree <jogletre@opensource.cirrus.com>, Fred Treven <fred.treven@cirrus.com>, 
	Ben Bright <ben.bright@cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tim Harvey <tharvey@gateworks.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Sven Peter <sven@kernel.org>, 
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Saravanan Sekar <sravanhome@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
	linux-rpi-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 at 19:00, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> These arrays already mostly match the most used and generally
> recommended coding style. That is:
>
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
>
> Adapt the offenders accordingly.
>
> Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org> # for Maxim MA=
X77759
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

>  drivers/mfd/rz-mtu3.c          |  2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

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
