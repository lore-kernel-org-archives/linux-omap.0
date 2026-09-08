Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C845964F0
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889037; cv=none; b=k9zejPqRRnhMHP9H5MFYll1PDCFh2EY4/R6nMKRtErKwtOLX82VujeG2uUmT/BzIMJOSUPtJadI0YC+MbP/2nexDZGP3PYXmmsGf+e1vS3kBkvXAXsmPSaRaGxNTnfKL+0hlt5YjzYp6i3IFr/yxH2lc72BvW1GUjZLddpGuYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889037; c=relaxed/simple;
	bh=x6jTWAIrLIpzgDpLBz42fd+VOfZnGCDvdcE7hWJmuGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7I7NLn4Z82ezagKMuYrsrgxPQVx7Z16VshwvGCjcNtIGtiZcd+CTT0XkV/C1ZV2iKGN3xLlIfts8HviJpsWYLkVEwfyQSn7/IJdJ72vVxkUHd89zxYC7sjzctBq99cjRx3/WX1Dj/N+RsJyi1T1P5twFJMqyNjrLrH+IRwe/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca/HQ8DH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca/HQ8DH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31CA1F0155E
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889034;
	bh=x6jTWAIrLIpzgDpLBz42fd+VOfZnGCDvdcE7hWJmuGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ca/HQ8DHSdLskAtbHdPp1qBfNvNKvwm9EcGFd2RKPS1P5sVk9XN1CvEw6ORs6x4ad
	 1K0X20YKxXTayWsoL1I1bQO6GCoM4b37t6AlTi5VjLGOLo+c+0OY6BXgUhLjrjJc8l
	 AF2yGBw64cEbT9crbm9TNHrYMTlgAMKSfesds/KqmpEEzx5DdgmCp3rglRT30iOBvx
	 spkd8YCMi1QgLSvab+b7QrTChQxHasU1XRVG6JTvxIAjHHk//scR936djuAPD1kpcq
	 8RtAVojOOnNKiFaBvVaq5mufN+HRmBnSbblzYkJO7znhI3PEuSUnsnh6luGsNF+dIO
	 H0MoHq8JZnUtg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a34473d51fso1877641fa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:37:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwrngiVM+4w36cBlZvcjMkTiTENynnveVOTvPjakgL453BHD9HPtE4/NFXgZtiE2TxbK20qFtOk+pNj@vger.kernel.org
X-Gm-Message-State: AFuF++nR/ACV890MRgMYFPo3jTQwEq4fzxZbhHHV+8Kql8tStVzbOzyi
	/wWyDo8SDtuM3jmUfug5CFHtE/I1qorC9yJrArqa8DDZ4d1R/BgBcr5oWWYoPPwp+hdQOgq2Lid
	t/e9rG9vyIdEgmu/FkJXP5/BPGIotsYM=
X-Received: by 2002:a05:6512:3b90:b0:5b6:425:4bef with SMTP id
 2adb3069b0e04-5b763cfb263mr320034e87.32.1788889033394; Tue, 08 Sep 2026
 10:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-11-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-11-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:36:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLnd5=uM56OyJ=J3Bt+o9pv2GmiPUeW8hn8FZXJe54c2=g@mail.gmail.com>
X-Gm-Features: AcwNN1W-3fWex_aQtlnPS_2IdFq7NxnkbpKmVsEJ4Y3Csr6iBcy20K2ukvxG9ug
Message-ID: <CAD++jLnd5=uM56OyJ=J3Bt+o9pv2GmiPUeW8hn8FZXJe54c2=g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ARM: stm32: remove stm32f4/f7/h7 MCU support
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Christophe Parant <c.parant@phytec.fr>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:30=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The stm32 platform started out as a Cortex-M based microcontoller
> platform in 2007, with a few of the older products gaining Linux kernel
> support in 2016. These days, the only relevant chips for Linux are the
> stm32mp1 (Cortex-A7) and stm32mp2 (Cortex-A35) product lines, with the
> microcontrollers running smaller RTOSs on new products.
>
> The microcontrollers were marked as deprecated in the linux-7.3LTS
> release, which will remain supported for a few more years and
> is expected to be sufficient for any of the remaining original users.
>
> Remove the MCU support now, leaving only the stm32mp SoCs in the platform=
.
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Christophe Parant <c.parant@phytec.fr>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
