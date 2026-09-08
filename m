Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC053CA99;
	Tue,  8 Sep 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897276; cv=none; b=ktilVVFhjSRcbK3NXYLqICXRTpUhbz4ezannZi7BoveZP+agbwCQ63KSVE/EfNQtbbLHDQjYas5LADmA7w1nY3wflXPsOc0UXzjdpV4mklXm2ugCJg0F2ybSZ/NUx0ucspk2oFW1YXWp+fpDaztrjsHSycAE+I6M48zt2XZZoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897276; c=relaxed/simple;
	bh=Flbhl/Ms581u8W+uqWmb2VOIObc8q/cyF2hSiCvhFEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzLMP8+yKKOcxX23QbOPJ8VRisSC8yEBFUWyfTGKPUnB1OuZ67qDBAmTnTPXAGusx1IUmAqfJ/r6DaRFewZaPORRQ4SV6EpQ3yNS4CgQdV24NsxsgAE/HWMRjdyu8cvIQcTbErgIrWTizwQqRbaDYQ/Q8NW5+Ey9kolSsnAl/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZtpQZ2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZtpQZ2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183A81F00A3A;
	Tue,  8 Sep 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897275;
	bh=eJaaRz4MsyrOVh6YnV0YRCgCp5Qj4xEbBmQuv65GUYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eZtpQZ2mYf15Akpd8onnJM5irfg/WdW38TXlJO3HzDjUpr/VCKE87stPMjojlHXNz
	 5nX7vFy7TQ1STo1GzJseSMJK4hqN8jQPcFjeyANjSZYbqc7sL7nMsWMydPMJr6khr4
	 JM3LfmCtwSfIfwU3rYcYK/8jcYNcU89JGIQzyeIZb0enxzLdXaC+lEAv3RvoF1ozvT
	 aafXPZOLk35Bn43nA7bO5OFMrTSpnv3YaPnSzYRKEaLTuP0NtnPdCBEs1YQEHmdulZ
	 ASx1nmLY/NmTzNrGS2m1KLD2VZS1wmeboa4qHOv4rv3L37Me8iqaa7NqOI6tKB+FSC
	 fx56cq6O7A+ew==
Date: Tue, 8 Sep 2026 20:54:26 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
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
Message-ID: <20260908-interesting-primitive-squirrel-afcd7e@sudeepholla>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-12-arnd@kernel.org>
 <20260908-nuthatch-of-utter-peace-68ead7@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-nuthatch-of-utter-peace-68ead7@sudeepholla>

On Tue, Sep 08, 2026 at 08:49:09PM +0100, Sudeep Holla wrote:
> On Tue, Sep 08, 2026 at 05:28:01PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The Arm mps2 platform is the reference implementation for Arm
> > microcontrollers and is useful for testing but not expected to be used
> > as a production device.
> > 
> > With all the Cortex-M based products gone, there is no longer a need
> > for a reference platform either, so remove it as well.
> > 
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@kernel.org>
> 
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> While at it, should we also remove
> 
> drivers/tty/serial/mps2-uart.c and related Makefile/Kconfig entries ?
> 

My initial search was incomplete(used _MPS2_ instead of _MPS2).
We also have timer/clocksource driver:

drivers/clocksource/mps2-timer.c

-- 
Regards,
Sudeep
