Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50759574A
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888643; cv=none; b=MUSiLe3aWYGEu7+SX+PztxgTgeLSe6rPln3k5htbYr+E7bn8SUD2GcFa4Mrxv8JhqxYSEonhuXhjZY52gUDiyGde8p81/7nfjqSYZlGT+VsAZGvZEXdZgbZ0IGYqDyu2/spJTb+4NTs5WGWbuGOfQ98RNWXNpWAvQ8kbhhIazj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888643; c=relaxed/simple;
	bh=68dTFTlGjK0XaJEAddlzUlXXUgt+rSGSQ0njU5H9lxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIXsUQe09dVOZG+0cjcKMTbWC8BOLQRh96XVdJuort2MZLmzfqE9WeLXxXE4HGsa5yp6ozagy4omHiBbhLnPjFIyG+6vKtpbnYJYSUa2OPL4yZC/otkVcpTebV02o5U6tBq3xOMv0pbPNZKUAna7Zo8UO7sqzmPpUGxFlV5LVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxrv/Clx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxrv/Clx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBDF1F00ADB
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888640;
	bh=68dTFTlGjK0XaJEAddlzUlXXUgt+rSGSQ0njU5H9lxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oxrv/ClxN2t78XeQbMP1BOQ2CF7BRSdBlylr6GW7o5+/v5GYQVd60IwisZn6HiGsJ
	 9RNqbkS68Pppw2cn+v5FA+PAWCNn2YMVBbWALX2+hALj/iBCSNzWIx3MqOR5Mo5tgV
	 70O9as9qVLJ6hHVbxRTZC3jcjJfupxQQH2Pl2p0Hwd+hFuhAHt0AaJ25PHkfkCoFXI
	 xXOtNRg2wCFas1yuSrwrvKDhy+o8lMgX5v4BGSyo166IzndsjZGIVmsTezw4ewkgYI
	 X40EsPBLjrq0tDb2gMLQ3cQU0n2dV5bZlEWe6WpAj3cEufphl2aaG9ekhrHoOREV8Y
	 aeQg2R1NDfojA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so3603378e87.0
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:30:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw5moa0f34lO/twngYu8h+wJfa9Ny/kRcZ7hGQWaLbWAVE4cAN5ecOTGEiGaocKwqxmnGezbQkYKXDB@vger.kernel.org
X-Gm-Message-State: AFuF++lbW0+8gk8T9zDWO0FJQBfuB690PnwGoL0ZG7ooOwwiv1wOm1jc
	aF0TjT+9szhatSkkPTXWm7HXwusbQjRmO4EHze1BfXEQpaHbiwq4kCNo78ABhJSMogVLsJCUDNv
	MyvgexRgj4vkkx4EbThcZopJLz0o75Fg=
X-Received: by 2002:a05:6512:1252:b0:5b6:4ae:19e7 with SMTP id
 2adb3069b0e04-5b61706d22fmr5531696e87.26.1788888639310; Tue, 08 Sep 2026
 10:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-5-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-5-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:30:26 +0200
X-Gmail-Original-Message-ID: <CAD++jLm=XWMMjJvLrLH-g3wfUEOFdzU_8K1oMHGuf2ZzfjFtxQ@mail.gmail.com>
X-Gm-Features: AcwNN1VtwTPYEunvryYhcDqpN6EJYSgh3lXDGedkufyoJM4Ll9RbC4SzO6PXMr4
Message-ID: <CAD++jLm=XWMMjJvLrLH-g3wfUEOFdzU_8K1oMHGuf2ZzfjFtxQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] ARM: remove legacy pxa board files
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
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The PXA platform supports devicetree based booting, but still has a
> few traditional board files, which were left as a starting point for a
> possible conversion to devicetree during the last mass purge of board
> files in 2022.
>
> None of these boards were actually converted, so drop support for these
> now, along with the 'scoop' support chip that was used on some PDAs that
> are no longer usable now.
>
> The only remaining board support is for the "Raumfeld" speaker system
> based on PXA300 SoC, though basic support for PXA250 and PXA270 is still
> there and may work with external dts files.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

I ACK this based on the number of refactorings I did on this
to remove the static GPIO assignments, I'm really tired of
doing them if no-one benefits.

Yours,
Linus Walleij
