Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC070592209
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888485; cv=none; b=OFtZ1kpECKBhW1qeH9oz8SNOhVjP+P0ezzA3jp51FCqQACRP7lYrubttghzWyQq8rbrZJ/W59JGnlcVAeEBWMAsW/GkBaYKoq7RMUwgQ3QSAwnI4cAkjqSoMMf3aq/SL+baYliqZPx5Y3oYqwFwQaGfPL3OzQgtWxVreagUKmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888485; c=relaxed/simple;
	bh=XjM+NfW0WLuiq2c1NmH2zxMXe3faot5pYKc+rUVJPpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUYB474vM1sFLewwb2QzROUVmFVb+YH5dn7hMK/3UPLSikH5NMrq4itIm5gPtghFgsNz2y/bnwkDtEUA9hiEo3yOfzH5pnB/AvKwf/P9fyHXQRiswr64Pi3p23BDH3h6UniWkzi62fuqPzMC1SPdVT12lSzW82/7MfBQr9D6BwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI9+h4ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI9+h4ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DB51F00ACA
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888483;
	bh=XjM+NfW0WLuiq2c1NmH2zxMXe3faot5pYKc+rUVJPpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gI9+h4nezNM4jezi/gSGd5v0FLkt/ViVbNzZjvmD3znGXhaCACEMxp772uTPuMKQM
	 zic6KxCNmB1qGktDhB7Q297JxzmoM8+GnkdHIo6O7GM1RtjOrd3fZzRYHyhJZERfAL
	 69YkYNVsnbzvuSM4by/7K8DV//vvvS6EZzyPHUmCVJVsLvVEmvcDqj4PUkSn25Oajf
	 10cbl2TTkZfXsQfX5hnB5ZNJmlkw0FLAF4v960FUXFrX2QuGaGyIrJgQaLePxMk25x
	 x+kVTIVGbOCV2GzFUF+D83VAJVNfudH9m5iPgdODO/y6lagRK9Jy6ORRoDJMgiu/Kr
	 jXIyW+APwKbZA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so3767603e87.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByIGeE9ojKNPze2SjNFA/CdaqVPe5p+5J/pSsDdmWGhMotYDjVcCgdtKNLl1vTibIWReKHK+0jiqO2A@vger.kernel.org
X-Gm-Message-State: AFuF++mZxo+AL0YMP3S55/yofIguUplep7CcBweD30zn3mF3nRJO0UZE
	2/WXy5ir8frPYVLOj7R7YS+II3y+GXLuHp+J2aoKap9qoipo7dvqZ/7ry9dTdzMwwKe0vluanwG
	wHlcIQfueLllst7wwQ76cQ3ZXTVV2OSM=
X-Received: by 2002:a05:6512:6884:20b0:5b6:1a7c:3f with SMTP id
 2adb3069b0e04-5b61a7c0196mr2554286e87.66.1788888482136; Tue, 08 Sep 2026
 10:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-3-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:27:48 +0200
X-Gmail-Original-Message-ID: <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
X-Gm-Features: AcwNN1UJNXIoMX0oKBuT_VyMabX-dcNfrhwjoX9gJLRVYT9sdHBezlMdahVsqlw
Message-ID: <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
Subject: Re: [PATCH 02/13] ARM: remove footbridge
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
	Ralph Siemsen <ralphs@netwinder.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:28=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Footbridge was deprecated in 7.3 to be removed along with the other
> StrongARM platforms and most remaining board files.
>
> The main machine here is the NetWinder, which was a popular Arm based
> desktop PC in the late 1990s and contributed to Arm's later success as
> an embedded Linux platform, but was discontinued over 25 years ago and
> is no longer all that useful.
>
> I previously tried to convert this to devicetree in a sensible way but
> gave up due to the platform being too different from modern SoC based
> targets.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ralph Siemsen <ralphs@netwinder.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

I have one of those machines and it boot mainline but I
certainly consider it a paperweight at this point, I can't use
it for anything useful.

Yours,
Linus Walleij
