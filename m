Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647A1DF98F;
	Wed,  9 Sep 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966606; cv=none; b=KPBPvwFvErOMOk/j/uogNixVwNtOb5UYdeZsAYtHk9W1cItk/YU4irhpHvVdcUhvmlBjX66hNpzlOs9sDQt+BQ1ZrGvT2AEMwd7ic18i+8dHjBWJ1PMttDJTn3CBbYKfVuqTnvhRL65VJBABctexuxmNJA4YnbHCcVP4+1hMOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966606; c=relaxed/simple;
	bh=B3JGyzLx8cCd/i3MCr5FaXYdGFjgIHugHdhYe3l65zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehKbIKI/QLrmc5d1gic1JCMDuVQ9yRC78y6deahZ/+icJS4PdFp1dULn/LLO7W6vzEdjEocf7l8iL1trq+BfjDli5nLxz9Ep/r8XS0zP6NcQh9adp7YuMbMzmAFsrmTAtvck4qz5Xr4lMG/GQ8On73s7IYgsrvkwoMmKSt+BV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netwinder.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fkQl6LBG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netwinder.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkQl6LBG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1CM/Ie7i+HqydojhG/4KklP2dQRzr4P2XxxuR9fLATg=; b=fkQl6LBG6LJrHcZTamZCq1ChtO
	JMh4Fm5pOxL5mwqSv5oXi20cu528tNwpvEqr4R49C/edMeJXImXCtAjtRerBWydxBCWyo/C2z5U/b
	gP2XR2Oo/inXe3bxpoD0+pjl0Fza+w0/xOCDn1V+rpiE47urZlHQtwx/7mxePkwwXvDuoxTaj7xER
	6LE/nepCtDYxq5S5wP3dD9k0G5k5KjVSybh0bhlNF7qEJWp/R05L4yvMr4ETJjCv0AhWvc0R4g9Xg
	8xF+Z6eMddN+PI0NjKVPPurEo0gdxEVIFlMUocUOry3anZCEE/fkgoDtE6uFdx6SPnAmnL0yBBMlE
	cyo2yEmQ==;
Received: from [66.129.139.8] (helo=rfs.netwinder.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Jvb-00000006qdh-48tP;
	Wed, 09 Sep 2026 15:09:36 +0000
Date: Wed, 9 Sep 2026 11:09:31 -0400
From: Ralph Siemsen <ralphs@netwinder.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
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
	linux-omap@vger.kernel.org, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/13] ARM: remove footbridge
Message-ID: <aqF2q32M8iQ6qhAr@rfs.lan>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-3-arnd@kernel.org>
 <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <ralphs@netwinder.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 08, 2026 at 07:27:48PM +0200, Linus Walleij wrote:
>On Tue, Sep 8, 2026 at 5:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Footbridge was deprecated in 7.3 to be removed along with the other
>> StrongARM platforms and most remaining board files.
>>
>> The main machine here is the NetWinder, which was a popular Arm based
>> desktop PC in the late 1990s and contributed to Arm's later success as
>> an embedded Linux platform, but was discontinued over 25 years ago and
>> is no longer all that useful.
>>
>> I previously tried to convert this to devicetree in a sensible way but
>> gave up due to the platform being too different from modern SoC based
>> targets.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Ralph Siemsen <ralphs@netwinder.org>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>Acked-by: Linus Walleij <linusw@kernel.org>
>
>I have one of those machines and it boot mainline but I
>certainly consider it a paperweight at this point, I can't use
>it for anything useful.

Likewise, I have a NetWinder machine which has occasionally booted a
mainline kernel, along with fairly current buildroot initramfs. It has 
been surprisingly smooth sailing, even the bx/bl compiler troubles seem 
to have been sorted out these days.

It's a bit sad to see it go, in particular since it all works. But the 
reality is that nobody seems to be running this hardware anymore, and 
there is no community of active users anymore.

Acked-by: Ralph Siemsen <ralphs@netwinder.org>

Regards,
-Ralph
