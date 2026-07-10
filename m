Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26842B738
	for <linux-omap@vger.kernel.org>; Fri, 10 Jul 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688469; cv=none; b=LEyiNQPNsarZQeTqLZIUOLNzqst9CLkawzaXaFk0H2cgYi/9jeCTyRhW4T/B0txTcAC0IuVEfmARGNfyhrmofghaGTfTcO5SpL0IMcCbApPIDz6nyWA7wBVOz6WJFYzHsrjuGMzIdvHf/y1ywT3aYPeE/udAGI2cuPREJ6YT/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688469; c=relaxed/simple;
	bh=M94SjjYhfG0qMo3AdWDmx7QCzOOMR1z6U/G7HOPFbC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=I0DHFmz/gYymeb7cNllJ00DbcJMWmKy6VsIMfGb8LIYqUYE1EG+9mos5hOAhByhAHgPqZ/5vfkXoPtdM6pvb4p5TTDMMx4yIRhAklxLXHYEsO34OU0fpmxPbaRr8DBqOO/hhh+0MKlCq4GpLxXOrCEVFYmHbf2Ur23W3Ug6jZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wZEo0zVu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wZEo0zVu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2972C2C645;
	Fri, 10 Jul 2026 13:01:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC97760345;
	Fri, 10 Jul 2026 13:01:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B95911BD0DEB;
	Fri, 10 Jul 2026 15:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783688461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OpR8EpUWoLVWD1U7hF0BGvXpeDpChn5vhtnYxeMgZ/M=;
	b=wZEo0zVumBZvota9lj9ysImh10+E4+BbYYrgpWI8VBXNocIci+MYRA9CPFt7nqEwahCYw+
	WGH/gbKanRQqklTcRaZlOdZcR2vWKZucFD13TXdAx/Gpc3+UIBLDDcSpYjyXTiFDp62YdU
	/9/G1w78+Iq5ZxLNsh8doY94LRg4F6sBcLJh6gazI/BPBSS8plkEkDP90Iw3Jipm5LWHpd
	t5JPw5/FOpeSvJgrAYi5ApGSR02OuWhrI719bSjbOdQQNoma1YvCMPW0BShr4FskJBpZKn
	RT65XADHkqNtWjPe5eSMFoaw249fIMLHxmMPTQGGDMENM6BCXdXRMwQnlO+2yA==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 15:00:43 +0200
Message-Id: <DJUWS6ZZUDS0.2ILHWRFQ1XD1S@bootlin.com>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Lee Jones" <lee@kernel.org>
Subject: Re: [PATCH v3 21/23] mfd: Unify style of of_device_id arrays
Cc: "Linus Walleij" <linusw@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Chen-Yu Tsai" <wens@kernel.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Ray Jui"
 <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>, "Marek Vasut"
 <marek.vasut+renesas@gmail.com>, "James Ogletree"
 <jogletre@opensource.cirrus.com>, "Fred Treven" <fred.treven@cirrus.com>,
 "Ben Bright" <ben.bright@cirrus.com>, "David Rhodes"
 <david.rhodes@cirrus.com>, "Richard Fitzgerald" <rf@opensource.cirrus.com>,
 "Support Opensource" <support.opensource@diasemi.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, "Tim Harvey"
 <tharvey@gateworks.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Charles Keepax" <ckeepax@opensource.cirrus.com>, "Sven Peter"
 <sven@kernel.org>, "Janne Grunau" <j@jannau.net>, "Neal Gompa"
 <neal@gompa.dev>, "Chanwoo Choi" <cw00.choi@samsung.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Saravanan Sekar" <sravanhome@gmail.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "Aaro
 Koskinen" <aaro.koskinen@iki.fi>, "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>,
 "Tony Lindgren" <tony@atomide.com>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, "Orson Zhai" <orsonzhai@gmail.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Chunyan Zhang"
 <zhang.lyra@gmail.com>, "Fabrice Gasnier" <fabrice.gasnier@foss.st.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Liviu
 Dudau" <liviu.dudau@arm.com>, "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Heiko
 Stuebner" <heiko@sntech.de>, <mfd@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <patches@opensource.cirrus.com>, <linux-rpi-kernel@lists.infradead.org>,
 <linux-renesas-soc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <asahi@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
 <imx@lists.linux.dev>, <linux-omap@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>,
 <linux-rockchip@lists.infradead.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
 <e5cc82aa51da5f545f745b126923fdd6085a68a0.1783615311.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <e5cc82aa51da5f545f745b126923fdd6085a68a0.1783615311.git.u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 9, 2026 at 6:58 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hub)=
 wrote:
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
> ---

...

> =20
> diff --git a/drivers/mfd/max7360.c b/drivers/mfd/max7360.c
> index 52fffed0c0dd..dc744b40bb38 100644
> --- a/drivers/mfd/max7360.c
> +++ b/drivers/mfd/max7360.c
> @@ -152,7 +152,7 @@ static int max7360_probe(struct i2c_client *client)
> =20
>  static const struct of_device_id max7360_dt_match[] =3D {
>  	{ .compatible =3D "maxim,max7360" },
> -	{}
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, max7360_dt_match);
> =20

Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> # ma=
x7360

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

