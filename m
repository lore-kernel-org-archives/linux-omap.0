Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916A38E8C6
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712769; cv=none; b=tJAIdwfc7v+QTheCDmnqeEo9RqFAMWkmYY2PLLeudXuFoLR+RQvldgq/cmz5ZPxdct0lDJ4ERhhqkgJIa4u+ORfFrIQdFLjJ4Wkv1sgZYtrYJCcdFLojZShvbw9yCCB18Z+YsrT5tq+KinPDT5QQ0paMGUu0XI8NWGqLeP+I0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712769; c=relaxed/simple;
	bh=sZDwGaUkGBLrMyNSIpb3kLYEJV1iPNS+5Pn9t9xv6aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tp78ka8lwOytf7e7aYDlcjjRFPt3Oza3SHwhdcbFQyn0qGYsrn6lOY0foO9mZnTHc7OA9ZYB6kUiPzjQMT1f5k37CWu7llzUZuBcRz+89WT5PX2VfLjWB63AgKzeEeWfI/sT1iuoHPQEiS7JuBVvgYNsoHaaMD8XTCTY8jE7WVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkSsEg0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkSsEg0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A5B1F00AC4
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712766;
	bh=sZDwGaUkGBLrMyNSIpb3kLYEJV1iPNS+5Pn9t9xv6aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HkSsEg0fbPswpwBbq7msyQoTQ/fzpUpBAWCJeyoo47JBrl1F4fLCAocKnijbpM/p6
	 GDbOtWqNLNjYAx3W000zcCbmXpLxeTYg1+fMSzkuksy7ydBzM8bj7gC6WXw6wQdRD6
	 vVdMHXz0K1GVFdtb/usTM0mXhAL+ZZsfcP7DWwsuADXRD4a5scfpg85ktfSdSrmGEW
	 RX91BEivy4ThHjiAFPD10y6OZy6KCaoROgurcEirnNXtZytmK4+Y7XIXkAVzwQgQnS
	 tWsz1C57JTWtsEG565sIfsiTVX1EO3rFjDmmROr8HMl9MVJMK0AKwMlgTnovI0C4jj
	 cqjPm+xX37wIg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso1544552e87.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 12:46:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpkt0lqyH4ILaD4VEUFeLzenwme9UxHAWUoMvyerd7hRO9Ber/VMXp0HX8/0Nnbe12TMuML7BdcKlfs@vger.kernel.org
X-Gm-Message-State: AOJu0YySjGIDHsH9uDJg3svaZmaZ3x7X8ecO9TK6awtBZz5KCJ5xEhRo
	n2BJuJgW7i2ughycJ4tze6W9pLuEw73c1709ACnUSA5zoHW3DoM6QuYS8lOJPxHcxtP7sbFuxX4
	35WLssIyasmWa0cAx9VA7a26hxO12Vmg=
X-Received: by 2002:a05:6512:32cf:b0:5ae:b792:7f1e with SMTP id
 2adb3069b0e04-5b0236a3891mr89821e87.30.1783712764308; Fri, 10 Jul 2026
 12:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:45:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLkJthrzmVCDE=BopUDMECBpMtPOpCJ9S0CKWRg--Zfz3A@mail.gmail.com>
X-Gm-Features: AUfX_mx_vh7ziiGHTkkaiMBQb1TjjZ8vahBxzqeJira0tID9YqDdR27A_6wUme0
Message-ID: <CAD++jLkJthrzmVCDE=BopUDMECBpMtPOpCJ9S0CKWRg--Zfz3A@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] mfd: Use named initializers for arrays of *_device_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, mfd@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Qunqin Zhao <zhaoqunqin@loongson.cn>, 
	linux-crypto@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
	Colin Foster <colin.foster@in-advantage.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zha Qipeng <qipeng.zha@intel.com>, 
	Thomas Richard <thomas.richard@bootlin.com>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, Xu Yilun <yilun.xu@intel.com>, 
	Tom Rix <trix@redhat.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	James Ogletree <jogletre@opensource.cirrus.com>, Fred Treven <fred.treven@cirrus.com>, 
	Ben Bright <ben.bright@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, 
	Andy Shevchenko <andy@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Samuel Kayode <samkay014@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux@ew.tq-group.com, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tim Harvey <tharvey@gateworks.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravanan Sekar <sravanhome@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-samsung-soc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
<u.kleine-koenig@baylibre.com> wrote:

> The objective for this series is to prepare mfd for changing
> of_device_id and the others to make driver_data a union, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for the idea behind it.

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
