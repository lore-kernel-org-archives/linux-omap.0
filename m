Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EF57F73D;
	Tue,  8 Sep 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886462; cv=none; b=I7EH4q47MVxYwJSAqLhu4Jgb7LKjszF8ZYRWSX3ov7ew1icVnJ0N6wSudJ8elxEIDS0jxIOVIMordU6EUjhOZGjN0jpsJbMgSVY7uLHCWeIpt4at1MrB9jr5o4Wkx9B5KzAYqYxuApAKCZ6H44g7u9GcdwHuLJmp/9ledkJ0Ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886462; c=relaxed/simple;
	bh=67dfvoVDkYR8Zd9d8dGEQV8aYWgXblUjXYlm0fotljg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WesdK8qkY6c2MfP16Jnno6SsJLbX24rbsx7S6QDzFIOEjudZx1A7hwd8FunycLBpYMb2h/yHFMao4aQ/sPC+Hb3G1KDRLfU/WcAcVoosAv63mn61NdLfYzhjS5KRf+D/mPHBJY1gI5juoXlU98CkbRhf9y30HBXeP3VmeL4EWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=twmW+hOv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="twmW+hOv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=y4hi2ivsLfr2ufMlsG0ARQMmUxC4cRTpVCxzIc4mQOk=; b=twmW+hOvQXNAxGM0/ZuSyJQMeS
	Ct0OE5kY5oLVOaCoRr0dqX9krn78Y5xBXUZPvT3+pnaXbPshun+O1UjToTkbS4OPfx4Rj+mmd9LMh
	j1PrCNYSmV5j4i6U13g2dDDXQMhZSTKbes2kep5xUO5+nc/dk0sx6sVw4EH8N6aeXdE+rv5Q4O0h8
	fRZRJdXNWCK3SV6nvGIUGqi/VMC/8VO8hEsaHI+q4SqlKAlLLzAQHjWCfTTaBEuXs76tSGO9faHgO
	3c0pJhaTnlD1WV26qHa9b1KEg5Cw4/yamZN4YjH1Bf5HWeRNF4/rcybPo1jGMr1h2IwSFXEAuHXsx
	byFzaGWA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3z4x-00000009jyE-0Hpm;
	Tue, 08 Sep 2026 16:53:51 +0000
Message-ID: <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
Date: Tue, 8 Sep 2026 09:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ARM: deprecated platform removal
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260908152808.3928630-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/26 8:27 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In the 7.3 kernel, I marked a number of platforms and features as
> deprecated, with the plan to keep these around for the LTS kernel, but
> remove them in 7.4, see [1].
> 
> Cleaning out the deprecated platform code has turned into a larger effort
> than I expected, currently standing at 300 patches, with a lot of them
> still in need of being split up into smaller ones, see [2] for a current
> snapshot.
> 
> The first series here removes just the bits in arch/arm/mach-*/, plus
> the portions that directly depend on the removed Kconfig symbols where
> these are trivial to remove.
> 
> The parts that are not included are those that remove architectural
> features and device drivers that become unused after this part. Some of
> those may also make their way into 7.4, but at this point I would target
> 7.5 for most of them, to keep the dependencies simple.
> 
> This also gives everyone a chance to voice their objections in case
> that some of the removed platform code does have active users after all,
> before all the corresponding drivers are gone.
> 
>      Arnd
> 
> Links:
> [1] https://lore.kernel.org/all/20260701212353.2196041-1-arnd@kernel.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
> 
> Arnd Bergmann (13):
>   ARM: remove sa1100 platform
>   ARM: remove footbridge
>   ARM: remove riscpc
>   ARM: remove legacy pxa board files
>   ARM: orion/dove/mv78xx0: remove all board files
>   ARM: omap2: remove omap24xx support
>   ARM: imx: remove i.MX31 SoC support
>   ARM: imx: remove nommu support
>   ARM: lpc18xx: remove entire platform
>   ARM: stm32: remove stm32f4/f7/h7 MCU support
>   ARM: versatile: remove mps2 support
>   ARM: at91: remove samv7 support
>   ARM: axxia: remove entire platform
> 
>  Documentation/arch/arm/index.rst              |    1 -
>  Documentation/arch/arm/netwinder.rst          |   85 -

I don't see netwinder.rst in any of the single patches.
Should it be in one of them?


[snip]

>  arch/arm/configs/netwinder_defconfig          |   88 -

Same for netwinder_defconfig.

If netwinder is going away, can all of
Documentation/arch/arm/nwfpe/ also go away?

Or do all of these come later (in phase 2 or 3)?

thanks.
-- 
~Randy

