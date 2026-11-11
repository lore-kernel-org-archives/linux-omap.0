Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363355;
	b=spX2wjS5hZKC5Ge8SqoXhDBlEAEkqyfCk81GYMwPlYFLnUAZcBqrV5OBTND0cKyV8QSS
	 K3WxCPgig+sfNbas5kJy1WCBD13Lc6zmQRCvz6EO+/1PQApyLCdG5U0y7ez1pMr/hg6te
	 h6vVB6AyDrsDq/N6iKHH1EagSO2BeKvxjw6lfeaWqd1pbDHohW/3ouoI0l79dThocXmEv
	 CEG4J2KHjqYxmsMJnIyqfSmT29PUqjfXEQ/NC0FZG9xNKFP7kLKfBNUf4kpaTU74MTVhJ
	 bdPNpQQ0sVITeINEVUvv98t5MAvJHe/mmN63LANsmjV89zFU3URTFTr2eRGjUwnVrPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363355;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lAhgMwbCGkquv8DnXUEthq+pkw17wZ1l1EuClqj5Zd0=;
	b=MDwOAqtAfjHD9/DzfSIYq0xLTNv/bxhiER3znBvFr21DSeqwk64xu+IhmnBGbHDY80z4
	 5X5RDRWtwA7ZMFfTRcl1WhwBa+VbcmA9ICpsX2J9DqRDEt56jp4VnA7TkGyxM6tuEgH7R
	 oMoxhm5D1ZvLnKexupLULkAfbvPm6fx4L+eFvQNH9a9oCH5tpmerB1K3zN8QSiiX/zg9X
	 BAJk+HVGPE2hK2Q5/8BgniomxJnig+qDRehUox5ZSwEY/atmXiNr9HVSmVGdHpiw0GskQ
	 uBfXHx7nh4kwAUpXZlZtcPXaG3wNND5Hypx7IEcfpYa+av3E7tkD6N4fGYbv3mZbF8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7PE9ddr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B766606A33B
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7PE9ddr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9421F0089F
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 02:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363355;
	bh=lAhgMwbCGkquv8DnXUEthq+pkw17wZ1l1EuClqj5Zd0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=b7PE9ddreY5QAE5xFMXPxiZPWVOW0gaFY784M6N8z9sRNS021aUOVGJDctYwi6uEB
	 TEgM/rJ/THOPcMnMjIP+sLQmsfDMjV7CLXIWrfpna+plyzhn86guZsKpJVKNuElTBx
	 E3J4RZeg04lCUSZWLsAmOhLkpLqn8vbK0k5ziIL8d7WGkgS/peH4mcsCmgQ5B6L/Nq
	 qMnxFl9U20v/mPZQPAgSqB27hp7YCunRO7M9//uaB5s51sa70JzaAzKKCmXH7rW1+f
	 QL0m+QNcj9bf9eMmAKysdjeKqEijH66AIz1Z2sR+xSlKRCKhXNaSa4G6jhxYRJqoX4
	 ploLlR/Wa3yyA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adfed9a887so12991891fa.3
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 18:15:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErElFEthotszaIh/wN0uT/kTQ9KY0uzX6yGEVwOXhyZja5E22HN7cI3QP1QuP6AV9q8z4jl4vUJm07Ms@vger.kernel.org
X-Gm-Message-State: APuU4Z9N3elzLVnD3/wvUdFNm743rkzZwbRPGyHdgt5s6vv5N2JyuOQJ
	0JUz45M2m50M60xAZD5y+ElO6IgbozAgMZjAZ0RfTRPpvFlPNa/8mWYvYVg6vQCkmXQ6HQYJdCF
	vVIaOJg9UWHUSr0a1vc776gHBi8DDGZ4=
X-Received: by 2002:a2e:be8d:0:b0:3ac:429f:6d93 with SMTP id
 38308e7fff4ca-3ae126c230bmr1415561fa.29.1794363351836; Tue, 10 Nov 2026
 18:15:51 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794347059.git.u.kleine-koenig@baylibre.com> <2cd7c4695edff6b711f8c77ae468d295bb910cdb.1794347059.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <2cd7c4695edff6b711f8c77ae468d295bb910cdb.1794347059.git.u.kleine-koenig@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 11 Nov 2026 11:15:39 +0900
X-Gmail-Original-Message-ID: <CAGb2v67xpAbsmez2qt7pypW5T8czE93PtU2QjcSPuQ4a7c7qoA@mail.gmail.com>
X-Gm-Features: AclHuK-PEU8_Ju7uMZ7QoR2Wn0i8AsTrMLtFibJe7hATAjuodc-7gCHep5Ph93s
Message-ID: <CAGb2v67xpAbsmez2qt7pypW5T8czE93PtU2QjcSPuQ4a7c7qoA@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] mfd: Unify style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
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
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	patches@opensource.cirrus.com, linux-rpi-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 6:56=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> # =
max7360
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
>  drivers/mfd/88pm860x-core.c    |  4 ++--
>  drivers/mfd/ab8500-sysctrl.c   |  4 ++--
>  drivers/mfd/ac100.c            |  2 +-
>  drivers/mfd/act8945a.c         |  4 ++--
>  drivers/mfd/altera-a10sr.c     |  2 +-
>  drivers/mfd/altera-sysmgr.c    |  2 +-
>  drivers/mfd/arizona-i2c.c      |  2 +-
>  drivers/mfd/arizona-spi.c      |  2 +-
>  drivers/mfd/as3711.c           |  4 ++--
>  drivers/mfd/as3722.c           |  4 ++--
>  drivers/mfd/atmel-hlcdc.c      |  2 +-
>  drivers/mfd/atmel-smc.c        |  2 +-


>  drivers/mfd/axp20x-i2c.c       |  2 +-
>  drivers/mfd/axp20x-rsb.c       |  2 +-

Acked-by: Chen-Yu Tsai <wens@kernel.org> # axp20x
