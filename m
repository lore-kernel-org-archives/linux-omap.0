Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2D592204
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888224; cv=none; b=aKVH59mXsbzVoxl04fmjg1QDZ7DwxmxU4rAfTShjBnC3eoPSI/dv5maPg6Wxbl9VXg16qluY9R5v0MFQ0v4RxTZPi60wxhoPPQNCwRkR2Q7qZtY83xRULu40jIvcFc/DT6NAheIqCQ/63ksIREMcsxMp4LcBWY276DiHi0GjQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888224; c=relaxed/simple;
	bh=Sj8K0bKr+QZ/S9dYM6RKCNRt49IKM+zHKFTuOaeQz0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8bBfv8EUCtG94ZnOuYGeEHzz0ihKZEbHYGHXQJrqAv/2fOyf3baSclMQqVX708+1NmAyJ6J4puKUitgyy5EbbUT8ZTCD1gB4OuhNxEXVsVloeeinwgb7Fo0qt6mc9kaD3mMkdfZ/GNBzw1GIM09k4XfzmnYAdW+z7UZ7WEckT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddQrHN30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddQrHN30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC91F01558
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888221;
	bh=Sj8K0bKr+QZ/S9dYM6RKCNRt49IKM+zHKFTuOaeQz0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ddQrHN30nhOEvSokqtHBmBF2IZEjMngfe66I7z/xF+nIpLfQMFzhrkZstpyTC3SCV
	 YVCXh4rNCyfy9alx3+pQF0UabMq1QP9Geu/5dOJsxjAU9iFSO6rPpTGGiy41e48re+
	 vmBhARYlPQ25cfGK5oj7P7w1JEYaJNt2ko7ZoJnM0EuQY++WA+raK9Cen8G/MNPAMA
	 6rE1in8zhab5s2tXfBzaWc3zIaZD+qYvlZ3pNYFsQiPDK2xEg3eTX9njnMCtFhgHKi
	 pWs3oOdNQJM7qOTCwOxNN5ytMf9umeDqGI3grPh6+BxUhER9YiG82Aj0h0C3LkFGKv
	 uM3fkgpb3KvEQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b4a0e5aefeso5304067e87.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:23:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJWKFeywFW7mp2uXYKNI+cno7UK7RZA04/sv4NUz1ucAD8GdxFljR4zryKV3nI98Lp4vfoqMhU9pC/@vger.kernel.org
X-Gm-Message-State: AFuF++k//rRrXZNEcZvUUdcrVIZzIPZSThTLVopNgjKpgn0+z8QZICpQ
	p8VYF6lavqK9iPXM2A8oLLSLLIdWMpQkxRNbb6nPgukzy1mrxdO53AAS0k0mkPXff2hkxixvzTN
	7ZJPh/ncQ+raFtDJBMhDKW/5nACxNRZ0=
X-Received: by 2002:a05:6512:6c3:b0:5b6:1a7c:39 with SMTP id
 2adb3069b0e04-5b61a7c02f1mr4244449e87.60.1788888219653; Tue, 08 Sep 2026
 10:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-2-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-2-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:23:26 +0200
X-Gmail-Original-Message-ID: <CAD++jL=7NjsvV6_2Ea9qyi9fDvDiSASPsLH3uTrPz30_ug7BQQ@mail.gmail.com>
X-Gm-Features: AcwNN1VilFNAiGqYj4DGWJSxsv2DtJDi9vb9QstH70LkavpX1Bq02jgwVJfqHBE
Message-ID: <CAD++jL=7NjsvV6_2Ea9qyi9fDvDiSASPsLH3uTrPz30_ug7BQQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] ARM: remove sa1100 platform
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
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:28=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Most sa1100 platforms were removed a few years, with the remaining
> ones left as a starting point for a conversion to devicetree.
>
> Nothing ever happened on that front, so remove the rest now,
> including the sa1111 and locomo drivers that were once shared
> with pxa but are already sa1100-exclusive now.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

If some user really want to keep this platform around and it
willing to invest time in testing, I do not think it is hard to
convert it to device tree using an LLM.

But if there are no users, away it goes.

Yours,
Linus Walleij
