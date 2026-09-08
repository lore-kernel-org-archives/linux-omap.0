Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BD58B6B6;
	Tue,  8 Sep 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886595; cv=none; b=icPkkgfyGBkn2emEtTovbKCBP1hLU9y7ch52QROntSjAFqu1dLkn9snLtkFbwmbqhYkTBV9SwebbJRyCETmMNWlJgQzwG9ieHDj++rk1NJlXkMXtQ9+9l2aHLOBGQeesV7yvqoiYsL5kWkrUw5eEZf3VGj//KNnG/ZfKSqSnwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886595; c=relaxed/simple;
	bh=/XPuUaAUd29stiGou2x9DdmvMqe81AmQ7on+3rtpzOU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PD9jcluICZCaS17VTaEfhwHf8YbLRsBjMFBBziqb8G4eXxDCHJK2jsFojAxmZjZPYq64ycYvfrGEkpE78QOJuTvdu59aU+8kAG+IqFMaPHyMyz3ltLEsOBuykIMnNg+H6XGDntLv2Y+KT8O2VdaevAOza8pWYXQBnC58/mpOWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ODicPeFe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODicPeFe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zxfHukaWNxcBEp0pmc++HuJ+JqVKCOkG3+1+3ES2XS0=; b=ODicPeFePwbXN1VGfvRTuTw3HQ
	MDFglIpSFqbftx4Rgk0l6f8Db4SxPyiBWlMvvakDym59AosfMfjJDUSZ3NGqHwPZEXREWOvNG0/ll
	MIP2cZobGqmgKWCvcv2SGmgmaAsxHBhN1UlgYxKXfQZu29u9VYNBL1Nk6fhcjmyggU1Z+0nj46eRa
	RwQAtn6yIf67IGcLW/cVLbwlIiKcKLAgIy2xa3jO3pv05gk4bPegrrd0j3RXnCm6ohosilFB5ntJT
	eHdW7uYopifPUoU05XgMAUGKeJNIySrlXa8FevPxlwg4ezN3IPLWiUGmfOMeYtJu6bVn+y5YqLP+G
	v7NNaKxg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3z7A-00000009kEt-0dmC;
	Tue, 08 Sep 2026 16:56:08 +0000
Message-ID: <3b9c6799-0b74-41d0-8421-acfb3487b910@infradead.org>
Date: Tue, 8 Sep 2026 09:56:05 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ARM: deprecated platform removal
From: Randy Dunlap <rdunlap@infradead.org>
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
 <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
Content-Language: en-US
In-Reply-To: <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/26 9:53 AM, Randy Dunlap wrote:
> 
> 
> On 9/8/26 8:27 AM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> In the 7.3 kernel, I marked a number of platforms and features as
>> deprecated, with the plan to keep these around for the LTS kernel, but
>> remove them in 7.4, see [1].
>>
>> Cleaning out the deprecated platform code has turned into a larger effort
>> than I expected, currently standing at 300 patches, with a lot of them
>> still in need of being split up into smaller ones, see [2] for a current
>> snapshot.
>>
>> The first series here removes just the bits in arch/arm/mach-*/, plus
>> the portions that directly depend on the removed Kconfig symbols where
>> these are trivial to remove.
>>
>> The parts that are not included are those that remove architectural
>> features and device drivers that become unused after this part. Some of
>> those may also make their way into 7.4, but at this point I would target
>> 7.5 for most of them, to keep the dependencies simple.
>>
>> This also gives everyone a chance to voice their objections in case
>> that some of the removed platform code does have active users after all,
>> before all the corresponding drivers are gone.
>>
>>      Arnd
>>
>> Links:
>> [1] https://lore.kernel.org/all/20260701212353.2196041-1-arnd@kernel.org/
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
>>
>> Arnd Bergmann (13):
>>   ARM: remove sa1100 platform
>>   ARM: remove footbridge
>>   ARM: remove riscpc
>>   ARM: remove legacy pxa board files
>>   ARM: orion/dove/mv78xx0: remove all board files
>>   ARM: omap2: remove omap24xx support
>>   ARM: imx: remove i.MX31 SoC support
>>   ARM: imx: remove nommu support
>>   ARM: lpc18xx: remove entire platform
>>   ARM: stm32: remove stm32f4/f7/h7 MCU support
>>   ARM: versatile: remove mps2 support
>>   ARM: at91: remove samv7 support
>>   ARM: axxia: remove entire platform
>>
>>  Documentation/arch/arm/index.rst              |    1 -
>>  Documentation/arch/arm/netwinder.rst          |   85 -
> 
> I don't see netwinder.rst in any of the single patches.
> Should it be in one of them?
> 
> 
> [snip]
> 
>>  arch/arm/configs/netwinder_defconfig          |   88 -
> 
> Same for netwinder_defconfig.
> 
> If netwinder is going away, can all of
> Documentation/arch/arm/nwfpe/ also go away?
> 
> Or do all of these come later (in phase 2 or 3)?

gag. I hadn't received patch 02/13 yet. Didn't realize that. :(

Only the nwfpe/ question remains.

-- 
~Randy

