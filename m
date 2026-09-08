Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF38397694;
	Tue,  8 Sep 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901791; cv=none; b=CV1EF/KJ11OuMAyUfPcuazq+IpBWH2Hpt8APILD2BPOxmQkd6c83eVQ+IcXp24RME110bC8CwPiRXkGHDTSsjKc260wMAsDZxX2DBHxM2QXNYSjB3rgsQxAp31XTYOxQm6VzBsm3of6u+GaYPszEQv6+B76dNMuhvGnCaagjK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901791; c=relaxed/simple;
	bh=j0aSaWTokWiAFAr/9jAUR5FNZHWASAHnfrS6ADQjb/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9+BQsdLCHRT89PjrJSTucatmv+jsyDNFPZ/jrqfcA7ozsSCA1slcCO2ijmuBxQEyvZdcrIFPz7mqKIMYxGBseR1bmo3VRobBvqQfBp6RtL80v+gW6UYR3u+qgAj6jUxMhaZS1moszQ0Ndk0mGU4+FgUnRpf5ImaghNBFGfuKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6aq7Lh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6aq7Lh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC61F00A3A;
	Tue,  8 Sep 2026 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901789;
	bh=IHz8ORFSvJaE+UR+1UHvUxKukNbdZNA++8TVO2BPQIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k6aq7Lh3Q+v4QuxYAJUOgrnezdCmOrjX6AbZRXTvV6JfbmzSp2mW5yLFnOmvpzn1L
	 gdSZ6rAkIqAZRkBKBEZFtQf/XCG237Vyt3Xeyd0mRJCnXAnKW28WdHJMxQwZAVrE7y
	 4Hwo6Uwo4llrJJAjflUh+NzyI6mY4NVqHCKF29f5+IVw3XSivdVt28IpyoWQlQz5R5
	 zhhqBMeGs32IwOe/hMkpSfjXIhSEmgl5DbmXeRHpDxFZBU2Fz7Z/mBmf6P8jZ6wD2V
	 20WTIvkcNhPiq4WfRqxKNDB30AeeL7Q88JryLDhhrmeBWAjDmQ+zYe0sMQkASYC9e/
	 xzMibxXhsfOdw==
Date: Tue, 8 Sep 2026 16:09:47 -0500
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 12/13] ARM: at91: remove samv7 support
Message-ID: <20260908210947.GA519272-robh@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-13-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-13-arnd@kernel.org>

On Tue, Sep 08, 2026 at 05:28:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Atmel at91 line, now known as Microchip SAM contains both
> SoCs using ARM926 and Cortex-A CPUs as well as a number of
> microcontrollers. Only a single one of those MCUs currently
> has Linux support, and has no known users.
> 
> The samv7 platform was deprecated in Linux-7.3LTS, which will
> remain supported a while longer after it is gone from mainline.
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug      | 10 ----------
>  arch/arm/mach-at91/Kconfig  | 11 +----------
>  arch/arm/mach-at91/Makefile |  1 -
>  arch/arm/mach-at91/samv7.c  | 17 -----------------
>  drivers/soc/atmel/soc.c     | 36 ------------------------------------
>  5 files changed, 1 insertion(+), 74 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/samv7.c

Do you want to drop all the samv7 platform compatibles from at91.yaml? 
Are there non-Linux users using DT?

Rob
