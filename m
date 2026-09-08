Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90607563FB8;
	Tue,  8 Sep 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882071; cv=none; b=csk3UHkS8MrovMsn80tM/AdNCGFmm14XSpWbikKe8eyHp7S72gNcVg7FI44PrfnSMdimxSyVNacnR6CNaoUquLa7srzbGsScYXchpHipntZESKP7Rl/YckuCrKxDEGZewR+gT1WKNCsFRrD/R9x9GVAn4WsUOR3/5PUFtjrKhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882071; c=relaxed/simple;
	bh=GzYrXlZnDB1XKGfiPNBinLUJL2v814WR7dfGcc/FiBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiV01LgyYgXC2jMEWTZHCVzyHHs2R1zak3KG3SkXQUpb37N2fShaZRyp5NlHCi2YD2sA2ta2Zl9N+oHwjSO/0m3she4ReHVMnZScFsaTHjIjlP1taWf6MyEz4eYkxIVN4WwAWSND1OJcXtzdz7NokFnD/72E32lBE2jyiTqrG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pHtb0IRA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pHtb0IRA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D5A1476;
	Tue,  8 Sep 2026 08:41:05 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A8123F7B4;
	Tue,  8 Sep 2026 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788882068; bh=GzYrXlZnDB1XKGfiPNBinLUJL2v814WR7dfGcc/FiBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pHtb0IRAsW9wOvzoGibNXykydW6eCILCKGrOEu/Cep+YCKNzNG2lTH/1wfxB6GmXU
	 cHbWOW8J08oJ3H7b5SEaQKXaSVLD7iAL3oCvN7oSRO9NDX5ROzp1Mcpr9JSj/4Bquq
	 NbOWYxtdlzil98rLN4cciq3EoT4jY0mdiyk89BJk=
Message-ID: <cdb4d02c-242f-4b82-9ddc-f9ea5eb91b53@arm.com>
Date: Tue, 8 Sep 2026 16:41:00 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] ARM: versatile: remove mps2 support
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
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-12-arnd@kernel.org>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908152808.3928630-12-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:28, Arnd Bergmann wrote:
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
> ---
>  arch/arm/Kconfig                     |  14 --
>  arch/arm/boot/dts/arm/Makefile       |   3 -
>  arch/arm/boot/dts/arm/mps2-an385.dts |  92 -----------
>  arch/arm/boot/dts/arm/mps2-an399.dts |  92 -----------
>  arch/arm/boot/dts/arm/mps2.dtsi      | 220 ---------------------------
>  arch/arm/configs/mps2_defconfig      | 102 -------------
>  arch/arm/mach-versatile/Makefile     |   3 -
>  arch/arm/mach-versatile/v2m-mps2.c   |  17 ---
>  drivers/i2c/busses/Kconfig           |   2 +-
>  9 files changed, 1 insertion(+), 544 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/arm/mps2-an385.dts
>  delete mode 100644 arch/arm/boot/dts/arm/mps2-an399.dts
>  delete mode 100644 arch/arm/boot/dts/arm/mps2.dtsi
>  delete mode 100644 arch/arm/configs/mps2_defconfig
>  delete mode 100644 arch/arm/mach-versatile/v2m-mps2.c

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

