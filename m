Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540A39D6E8;
	Tue,  8 Sep 2026 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896960; cv=none; b=h/SKcywFjtCZfsBvknmxyXbJN/mzkQddLv+HqMqEaqpbzM6q/FX1kEuTwElTnGjwVYve4ZbAi7l2gQgDpHbbwHwdjR3RveN5a8BQreZ0hWUk/8L8vR6B9KmGHZewAYh0ixacW+JTYfcLf4smqsrFMvOgCUtaSxFtQBn1iHzXXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896960; c=relaxed/simple;
	bh=oiYGsMaCLnwCmDy1yg36vtdu2oqucVkkNwHPUBlpkj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErrnlGeTWXaXuPczygtXP8RvwBwXfUmj1yCuGgeKtgZOysFxGo2FrnJzAz4oZG7Ll0MGgNwqf3ZVowA+45Lyk7gUKzGa2c8cWIFumAQsEv1mg2nNCFcGOmYxw8SxxqYhvBNkvZhzhWjfQc5c8d5ZCtECp8mhmV1/mlSJf83lU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh9i0uXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh9i0uXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07451F00A3E;
	Tue,  8 Sep 2026 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896959;
	bh=/P9NMmb1bKlJESKNUVT1eu3XFgU1HlOoe7JBU7vKCC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fh9i0uXDyWEFR2uOr95NplkfG96J6thbYHCbX9Yw++FdCOUctWj04uVNF6GkWQbY0
	 pwTZ02VYjDsovAfcxdhJxsXVUcTDJKbTKooDfAWFEu82TcprN8TjFQhQx2XiP4S6eO
	 dMcKAmtaqHuVBAJEf/lfpYuw/qAi3Kt2HFynbKUcgUqCGLIHFhcGX7Po2h/Ywyuk/L
	 mvtOJq9Fj1CwdG9DUf+iAXDE9T91PTCaq9Gl/220rr3StOTCpvykpBxKvD064dphUc
	 sbBf4kWcrwzYLV9zlUS8pKbfewzeicNGRtdl1NwQSFaHkNb2wX9PLROfA9ogDlAXg0
	 B9f3Lx2+nVRBA==
Date: Tue, 8 Sep 2026 20:49:09 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
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
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 11/13] ARM: versatile: remove mps2 support
Message-ID: <20260908-nuthatch-of-utter-peace-68ead7@sudeepholla>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-12-arnd@kernel.org>

On Tue, Sep 08, 2026 at 05:28:01PM +0200, Arnd Bergmann wrote:
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

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

While at it, should we also remove

drivers/tty/serial/mps2-uart.c and related Makefile/Kconfig entries ?

-- 
Regards,
Sudeep
