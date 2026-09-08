Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1E59650B
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889090; cv=none; b=ga8W7OyrUw5UNrmTEBwu5QBwxYz28zZgII7nQNM18oT1EpzkYuZI0IbyPzashTrrAGmy+6cOLLQYMoHzSN5OTFfB7HwXYjw9/3TZc/YU1H7BxMC4JC97nV2ChFdyx5zy+Nft+LVa1yjyrwtwGN+Qpf/WYhwpE/ExLDutJuuPZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889090; c=relaxed/simple;
	bh=xV9WGVUhDaM7feSHAMHRU17JK/43xAFNQC9C+0SKuzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg+C720YB/Csosy2sD52FGZiiy66qp501Qa9SLVIOw1h021jvM3vUKRfUFiomEayguRr5J6OH3MafGNDoBqfo0jwGTMA6N7YBOqJRkJ1IGg+LO/XuqttyfuWrWYIeR0CVX8KUXDxsfZ0N8cafsZ4a462CHKJlVtRPIlC9mg8UZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/y5ZWFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/y5ZWFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927621F01564
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889088;
	bh=xV9WGVUhDaM7feSHAMHRU17JK/43xAFNQC9C+0SKuzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E/y5ZWFZ2hwHxch3L34izLg0s7LbkYAR0qYto+nyFgTySlUXkSWDGvDNVbzmJ7FJW
	 a6wv5BA1EO1HbPuYdniyeIW/3E4n9ji2bcHyIp2qKXzdhMWwElQ8EIoDQGjoHAGsiG
	 PAiKJGGkknYUxMCVuJkINzJ1qRO7YXy8XKlU9Hj30vkBoSWN/PZAiU4SBUx1DulzNK
	 wWMBUbNAvivKUmhBbP42Zaar5j4cAK5jz+mIdBEr9NmTFOBw4cPpu72BFEI9s6WJrB
	 a8/2n1Pn/echlAt0iJycONAQvMVMmP/ax9fe3zwyW9cAFCTxFEe0CcponmtfFkRvAA
	 vp+WX0Y/4Cirw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b5e5ab03afso4102110e87.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 10:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxgoSFaT4mpiensJz7Ibd37aJlh5GA4isaWeP5mZweE9L6zDZ6dUlubL0AclM0WAzI+TP2C0ySH3sNo@vger.kernel.org
X-Gm-Message-State: AFuF++ng1rKgoOts7d02HTZyoWbiAZRPJnxvcOCubxNSC6RxetawVeKo
	cuVH0cCj1O/rmoR04AnT5pRKfLLJ2FgLf9Y8cP7oP8Ht0QGeZ65Fnpc4WB0Yss2XXJp3IziR1O2
	iHLolclXl8+LfjR3W3KPsryGUS8PMQh8=
X-Received: by 2002:a05:6512:2c04:b0:5b6:1a81:b960 with SMTP id
 2adb3069b0e04-5b61a81bbd7mr4978552e87.67.1788889087269; Tue, 08 Sep 2026
 10:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-12-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-12-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:37:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLmoSUE9582xd9zNCEq3rN0UEyG6sivNz8SDoYy9RxXuQw@mail.gmail.com>
X-Gm-Features: AcwNN1WWmio2Em4aKVDNeDjQ4YqA6DMZXwfzcFUzVwF968HsT49NyvahOJQzbQM
Message-ID: <CAD++jLmoSUE9582xd9zNCEq3rN0UEyG6sivNz8SDoYy9RxXuQw@mail.gmail.com>
Subject: Re: [PATCH 11/13] ARM: versatile: remove mps2 support
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:30=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The Arm mps2 platform is the reference implementation for Arm
> microcontrollers and is useful for testing but not expected to be used
> as a production device.
>
> With all the Cortex-M based products gone, there is no longer a need
> for a reference platform either, so remove it as well.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
