Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE934D934;
	Tue,  8 Sep 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897509; cv=none; b=ND7X11UQjOO6QwJoGnweqN5UcQ/0wgLaZNpkx5rAppcX0YmOb+/ie/nq6wfy4TGMQk3HuXjYAL6w+TPavXd9M9M8Up0M4lIYzMFZ+f6/XQpOFjHx55TR8hFDSy+P/cvD4dg5ggrIfXuVak7LLiuLcDaoIB6hSmDnDtHJvTRxXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897509; c=relaxed/simple;
	bh=7mwPu+Fo6R0ONVABaaMu8TZPA+3xiqnaRkwK1GDP0dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrV1k7EwhEF0MTBEhQIommSG069LGS8vESKTn1EdHGO6l/UxFh7cNjPmlLo7IVeJomcom6WFqlgT6uvgUJWsjwCB4/91Dh/Don/ORgl3E1aQ3ba9jj9rhgDjKXinDt3BHdSU6wGKYO3BTozjgg+N707McjNPKel58caunTqTMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3sWU/Zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3sWU/Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D225A1F00A3A;
	Tue,  8 Sep 2026 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897508;
	bh=7NZ4qj4y6ghNql1BBq5OgAjPl+eevtru+FCwcPmuWtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3sWU/ZmJzHn+2N6ETJ6oNqcqqmbVuWJyd8w69y2FiLoyKFPpwOd8xhXQmWtepC2m
	 3v8BXdvB5BHlJRf3W+ok1DEqhufqOgwc4FHTzrUJUWEUzQrReCDYOVeyaE4E3NWt/J
	 ckmMlL70nIBY37lOFcGkzb8ln0UQujCvvsm71z65kEWXTP4d6QZdsFZa0bHMptXSxK
	 22WGC47I115WfmGf89Q3jP4BLDVvdklP9Dh0wbXkPYOHs32iGy/n9gA1jgl4FLfWL1
	 RmAeWVOOuG4iSCavArip1qfjLmYW4fs11N0eoVIxucim1vppcrnbYlIdj4xh1BLRJa
	 DU7Ozjcdi1ouw==
Date: Tue, 8 Sep 2026 20:58:18 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
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
	"A. Sverdlin" <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 11/13] ARM: versatile: remove mps2 support
Message-ID: <20260908-rare-dragonfly-of-variation-1d59ae@sudeepholla>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-12-arnd@kernel.org>
 <20260908-nuthatch-of-utter-peace-68ead7@sudeepholla>
 <85c2f9d0-0e9f-4228-9275-65e731def3b1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c2f9d0-0e9f-4228-9275-65e731def3b1@app.fastmail.com>

On Tue, Sep 08, 2026 at 09:51:22PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 8, 2026, at 21:49, Sudeep Holla wrote:
> > On Tue, Sep 08, 2026 at 05:28:01PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The Arm mps2 platform is the reference implementation for Arm
> >> microcontrollers and is useful for testing but not expected to be used
> >> as a production device.
> >> 
> >> With all the Cortex-M based products gone, there is no longer a need
> >> for a reference platform either, so remove it as well.
> >> 
> >> Cc: Liviu Dudau <liviu.dudau@arm.com>
> >> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> >
> > Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> Thanks!
> 
> > While at it, should we also remove
> >
> > drivers/tty/serial/mps2-uart.c and related Makefile/Kconfig entries ?
> 
> Yes, I have a patch for that in
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3 and will post that once this series has progressed enough.
> 

Ah ok, then discard my followup message. I assume you would have the timer
driver as well. Thanks for the deprecation.

-- 
Regards,
Sudeep
