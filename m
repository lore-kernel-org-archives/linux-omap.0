Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B437D110
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712193; cv=none; b=EqjzfjSJ8FIE08vX3lVAK0dsBV82hiTXqMdNteKFB+/BU8w37VxjcbwVvSQKAJnzuGGJrUjzPF5YUWkJUUYT8dp+rieRufhBTWWbey4QaqnJ2VUniFjW4N1DslXfyx/V7bqyddu5onm3e8OlrhNUyBODed99VcPzSZzsSAz5oIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712193; c=relaxed/simple;
	bh=wO1MPId3Vtrx5eVsLf+EKmRRPNbeNbSYmTHEZLEDlDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlxcTArXgZIwcZ8eSI5LVYDPPLwJqx0kwQ0JehA3teML2IQEdXTuBrXAyJVkBOpmYY/yYrm1aaYGAdIKYi64ZotTaEY/0QM3Iqa54Hhga/+j8WpG0xfX4SiTkj+wDhnVOfHszHNir0qpdV12uxbAtYcYpub+zjnfqM2I4gOQ9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRDk3Ul5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRDk3Ul5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBE1F0155F
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712191;
	bh=WfoUlWEeuKtg5ji7K2r6ODJIVODJRvoxIKC//T1cf3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZRDk3Ul5X9eC9ZHcfx5aHpGPMZRj8v9feok6MHcQBdkvh3+onnXs24BVt/Ozpkyqa
	 k7uROJWTLOMduKI1fXPmZSqARmE+YeFZL7qmM+ZCAe7RydX3Vl688CacNjGxU9xYkC
	 9aQcBXDT72NgTkQS/gqdnGh2i6e3UetKU/Aq+EYf+4AdY1aXZTK+aXJnenlLce36vv
	 /JH3DZ58BW+yD4iaSawqTvlJdn8Q6Viahzvtrq7inKWQLrGxwSNFxrLIOukSXMMLmP
	 Uo169aPZYaZ10O5Wi1iwXuWjR2rAXh4YJHoVM+Igo+6E+ioJC/TcKmfh+J5XR+8258
	 Dp9vgcYmBqkLQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb5e85378so1311787e87.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 12:36:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1W6f89/+1oHJTM+mzXDh9NSJ0qNJnSzuUdxjLc0S0onMaEB/6mLUgjgO1x1BM6zDTM2mqecmdBrPX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxol7pInh2G9d81IEwEsnWeqev2CzFQl5AIXUMZw2B7JpPfZPR5
	S5pTrMBUXdP57YvS0kNEWce1clrQPUUZj/diGvCCqwaBGT+xemVE/7A+HsDJAtGP4CBp8DLsSjq
	l8vLb5HpI8JjGDuBLJrAPlmE49STjeIA=
X-Received: by 2002:a05:6512:40c4:20b0:5ae:c454:3740 with SMTP id
 2adb3069b0e04-5b0236ec2f0mr64636e87.60.1783712190489; Fri, 10 Jul 2026
 12:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783507945.git.u.kleine-koenig@baylibre.com> <ce43f6ec640a7835d64d3d696ff09229c3d31075.1783507945.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <ce43f6ec640a7835d64d3d696ff09229c3d31075.1783507945.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:36:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLkhkEVsLyoYobV9ZfD0o7YWXh74cNsy2rcFrajna4mRjg@mail.gmail.com>
X-Gm-Features: AUfX_mxF7aXm1NUaeKv9tRmJ75XIeUyINM_M0uEJT4kZsHp0a8M3V6ZUZMQlacY
Message-ID: <CAD++jLkhkEVsLyoYobV9ZfD0o7YWXh74cNsy2rcFrajna4mRjg@mail.gmail.com>
Subject: Re: [PATCH v2 21/23] mfd: Unify style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
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
	Magnus Damm <magnus.damm@gmail.com>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
	linux-rpi-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
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
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
