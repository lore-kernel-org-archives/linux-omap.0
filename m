Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E95964F1
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888990; cv=none; b=GIBJgis1BS38u3c9YA6jMEKqAoC6MXKjgH1Vj/b9K8eb/yQ4S38elvgbdkCaNSXTVKsEro/bAqP+0SqmslBj5fBnZr3lYKuam11MDDZ70Sf0JBy9Rwqd8Or94VQbQSUs3JSdvrKafPSsDEkk76moBCQihmmcuNomXwS6miZpOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888990; c=relaxed/simple;
	bh=xXzfiY6SzoJBncXcdLH+tsYFvMZl0xri22KcLVBkMFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDYgeP0lVEasyXukqLZNuekLD88CQUY81+zpihiAeyQtSj9zAyRecjEUCPi3BGIeg7meRDV2cJApsphbkmas+qLnXiQ5fNvigZHIFOUpE5KDLmPJ1bmgG/PXJNJoElxkrt+MjNPIg3YdL8A+M2flhcFYUyX8P0DcJmDbfkLNus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN6cQtn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN6cQtn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713D31F01562
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888988;
	bh=xXzfiY6SzoJBncXcdLH+tsYFvMZl0xri22KcLVBkMFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DN6cQtn0qqlONJ5apqe2nrBkN4G+dqWgJOugaBlDHNOVy5m4kPoWqFy0DEu47pTgy
	 T15dVGzKaDuiH8QZPT3LIXOfbAgZqibeIwmhgs+VZOD0sChaVSCGTT8IuThuToEFp+
	 jPFgtd/TpkOwLMpqFIym37NLVavDndl8Bwl0v7PkHlw4OwaZskbS036yKlcumLeNd1
	 ZaPMzLhfPSxnXmAYB/cHVRPczacrZ6jMFQmUrMaZafbp4xjeHvajU66mcEA6WUt31S
	 mVQVhlsEcGCUjl2tJzlFPKpnj3dS3LzWrTtmZwE4uKLvrvXK9nFCWuo7kG/CdBdVkZ
	 lGX7q7lodMBPQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4ab40d839so4651853e87.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:36:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXOCV8uW0ODGjR0xxEKh1JLskjOrpmCGGzrzYgOykZo1JmxM24ZcjFhN2Ub9XScLciXcDrmZVao/AD@vger.kernel.org
X-Gm-Message-State: AFuF++kFMfJu+ule0XnUVODtXRiztmIw1b3SbFpr9/sBqDVl72KrpNda
	cmHFe89JHG4qC1VS7AmSZkDGHZiHO0rib8iy4c5IHXq8zQZFC3AE+AVNIsyGo1aQe8OvNZmn174
	JXuDxp52awbV/w79+nOx+Er/De07p5lE=
X-Received: by 2002:a05:6512:31cb:b0:5b4:5838:30ee with SMTP id
 2adb3069b0e04-5b616edf505mr4589701e87.7.1788888987143; Tue, 08 Sep 2026
 10:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-10-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-10-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:36:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLkVPQyDKj2kRMgjo6zJFJy2WNpOiNmzDGo8_Tdzf9-voA@mail.gmail.com>
X-Gm-Features: AcwNN1V-wZ8mrD2va0ETCcbA6PJ4QIvheq_0f10i2NyJnopy7bfJnS_t3Fwsds0
Message-ID: <CAD++jLkVPQyDKj2kRMgjo6zJFJy2WNpOiNmzDGo8_Tdzf9-voA@mail.gmail.com>
Subject: Re: [PATCH 09/13] ARM: lpc18xx: remove entire platform
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:30=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The NXP LPC18xx and LPC43xx microcontrollers are the more modern
> version of the classic LPC32xx line, but they lack memory management
> units.
>
> These microcontrollers all remain in production as of 2026, but
> there are no known users running Linux on them.
>
> The platform was marked deprecated in the 7.3-LTS release, which
> will remain supported for a few more years.
>
> Remove support for both LPC18xx and LPC43xx.

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
