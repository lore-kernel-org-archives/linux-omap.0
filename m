Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89F592214
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888930; cv=none; b=lPcyuz4ysZSwJTgB8AZHGs0YwWB7fKmAAmNiD3swG2sWSvfAsokVk5l5QyR77nk9m+HkizRXQh5POQhGbEAy3MC+PEZDE/xgM3vdl7tUJ5BYPHZJWDv8ksNA/cQrL4hUB9FbSF0mLdGdpdMApenvMVTiz9x+BOUYND+TJnY9PFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888930; c=relaxed/simple;
	bh=zvjd/OzBfuPYT7BKbdMoiUi8iXO0iBXgZckMkZOu3PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgarSIesd1OFQ3ihqTUSs1YNxhscxwHTAKuQ6f5t5gJ7RBEoXu6pYxNZYvcei3FFKCVBIoHB4rUO22cOnuH39ozjCr3DiawwbCuDs2Nlx1OBPAEYPGUzrOLNqlh94t2EbFsuLUZl0vGz0c165brExmwj50n1cbnfL4idaSGJ3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwshzapm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwshzapm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F371F0155B
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888928;
	bh=zvjd/OzBfuPYT7BKbdMoiUi8iXO0iBXgZckMkZOu3PU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qwshzapm39uXq2bVZZ9GfIJxkRheR3vOmylHbJtw3OxtcIqEw4JoMA7w+Tw/kgH4O
	 1rCS4JS58AFDBjVvowhwlytP979SDLVjwHHeX8h/SjjynwzRGtIxITSyRESG7cOEvl
	 3HtdMPZIJMUxw/VSwULMfZECLECqDa8XTzdlotHHLNl7Z18J9S91ysKJU/+rsSE3st
	 zRG2A5Weif3rhmhHI0XD5iRES+YAIJcQ2wJO4+SOoBi8ErXXYJ7STnxRAwRPBCYu0W
	 desQfa5d0YO4aFUsg16AnAqsoQKwbyDEOsvhbUJ1x0nYUQ/eNxL3zzmcUyeTMJuXyv
	 Si2cRn1tsxNWA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a20c95e412so41304631fa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwo+4T+yYXexTAiaPrOLud98l/i+Iag/Y2QAVZ4cNb+2d/vkBXnbFTEn8bntKJOl04KwbwzbK6Ao6lh@vger.kernel.org
X-Gm-Message-State: AFuF++m73cWEjNLZ4/VqDm3lZO+6EvSfJM075XOJvWvTJSXfboiJDJwA
	wLw2CjJF0XxKTuM6BDQiBQoo4WWgapXCs+iL/4vgNa1NPuDNCqxbfLi/z4kOQnu35GBN1Fipu4m
	MjExsP5TWl/uuKMMO9F2BsYueV6XNhB8=
X-Received: by 2002:a05:6512:3b2a:b0:5b6:1870:268a with SMTP id
 2adb3069b0e04-5b6187043cbmr4987140e87.59.1788888927352; Tue, 08 Sep 2026
 10:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-7-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:35:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLnPYmOre6_kZfftmOaWyNdDSTTNxsJn8PsnwA=KqoYXkg@mail.gmail.com>
X-Gm-Features: AcwNN1Vy2Xn3FP6S0HerShzZSl6E63lIl1BsiI7kBkdVTNwbpJho60d2kWzYdwE
Message-ID: <CAD++jLnPYmOre6_kZfftmOaWyNdDSTTNxsJn8PsnwA=KqoYXkg@mail.gmail.com>
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
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
	Paul Walmsley <paul@pwsan.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Helge Deller <deller@gmx.de>, 
	Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The omap24xx SoC platform was used in the Nokia N800 and N810 tablets
> released on 2007 and was among the first ARMv6 CPUs in products that
> made it into products.
>
> Unfortunately the early ARM1136r0 CPU cores had a number of quirks that
> caused a disproportionate amount of work to keep them compatible with
> later ARMv6K/v7/v8 implementations.
>
> Drop the support for this SoC in order to allow removing ARM1136r0.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since Aaro says it can go, it can go.

If the n800 had a PostmarketOS port things would be different,
but it does not.

Yours,
Linus Walleij
