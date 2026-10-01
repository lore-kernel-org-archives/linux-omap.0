Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B5492E29;
	Thu,  1 Oct 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858425; cv=none; b=nPuM5ZLiRnsPdw/TCi5T9iTM3V4EBKDo38Di2zZ2Y6x0NFNEC4LQaiJklTcuTfWGXIZO3Kz+OSl21VW9yTHh557stqGTgruDLz5Z5MI4k4jsQhFmgk2V53UN3nT6GlRHkwa3/RWP5pEohOHt/6svYlGMaSwoPv9D9ZhAelntsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858425; c=relaxed/simple;
	bh=aUlHMEAl5tANrzBjM4nHfN4L9GztS/KYB/IOKuuRItk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lv9v02d/8BqW1/tfey36CSWLYgZcgwHYtRTkMVEuY6RXHIvKHw6fB6rj+3xnh3+LzxWyfD+59DkeqHRkNcC+EEn0vbEY+V1uwGv6WyVp68+MuO6+LT0M7sFXCZFRcmXSqNmaWxYGSVI8kyh2tvih8wL0T28AZX/Kcgc/W7yBh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCRnnyX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCRnnyX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14C1F000FF;
	Thu,  1 Oct 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858423;
	bh=2yqV/Awvfmtsj6q/00BzdhQQlByccag34Ejy1niliro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZCRnnyX8s+71IPbGhb8/YT80JuAIidJq2MhvpK0OmnrhU8tM+2O/S/Bl9VgbeSrPX
	 3yUSMWSDbh1RXwypspIpwjZ/Z1PM3duR4aqQ5YFaM18wqtZpQby0D1EYtE8k0QSZ8e
	 DoX3iA65giwjlB+w0u+rUBIopt0ZKF8dcOZLwjiJykmgjKICYBg4gER6dAUCEQaqZ5
	 PZoZQFXgI1hXXsF9qPOv4feQbT7MXXMdRjvhizrHrFEkp+CUlPa5hfyyQyv7ZuAGWk
	 2kP8fPcf8yDi1q6BuPrC+UIeF2Cb1AbHsbQvgbgAFl2g7EjyyKHiScRLdrGa3q4/RR
	 N5Mf3T94WTuVg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: soc@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org
In-Reply-To: <20260914140821.1805449-1-arnd@kernel.org>
References: <20260914140821.1805449-1-arnd@kernel.org>
Subject: Re: [PATCH v2 00/14] ARM: deprecated platform removal
Message-Id: <179085840863.602414.17097032215174834953.b4-ty@b4>
Date: Thu, 01 Oct 2026 14:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 14 Sep 2026 16:08:02 +0200, Arnd Bergmann wrote:
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
> [...]

Applied, thanks!

[01/14] ARM: remove sa1100 platform
        https://git.kernel.org/soc/soc/c/95664df86fdf6e70e411ad9e3910b402489a22c3
[02/14] ARM: remove footbridge
        https://git.kernel.org/soc/soc/c/21b5f207cb8b1d0a819dd1799ef8c56178d5b1d7
[03/14] ARM: remove legacy pxa board files
        https://git.kernel.org/soc/soc/c/538532cd1532f44e7c2519ecd3dfbcbed08061e2
[04/14] ARM: orion/dove/mv78xx0: remove all board files
        https://git.kernel.org/soc/soc/c/f98cb2a43e0efa32ed8723df8d687acdb69dab06
[05/14] ARM: orion5x: fold plat-orion/pcie.c and hw_pci into pci.c
        https://git.kernel.org/soc/soc/c/4fa61946d7c3e6da57a6db11551fa2ac17078370
[06/14] ARM: omap2: remove omap24xx support
        https://git.kernel.org/soc/soc/c/cbd33c61480b8fa64046d956f4f68bca5cf68fbe
[07/14] ARM: imx: remove i.MX31 SoC support
        https://git.kernel.org/soc/soc/c/104a7a07163962fe259a2e5272fb70446f19793b
[08/14] ARM: versatile: remove Integrator/CM1136JF-S option
        https://git.kernel.org/soc/soc/c/1fbbfb51f20f3d0a1da6b542d7f29acc29815403
[09/14] ARM: imx: remove nommu support
        https://git.kernel.org/soc/soc/c/2e1031df3c5f64f96660074f695e3b24e4bd3018
[10/14] ARM: lpc18xx: remove entire platform
        https://git.kernel.org/soc/soc/c/31431dc97977003efbd4fb25e77aec8744338280
[11/14] ARM: stm32: remove stm32f4/f7/h7 MCU support
        https://git.kernel.org/soc/soc/c/6fa463cad26fed984b62a764345e65a98fd0a30a
[12/14] ARM: versatile: remove mps2 support
        https://git.kernel.org/soc/soc/c/1b983b0549163d4016574b0043664cdb47eea8cd
[13/14] ARM: at91: remove samv7 support
        https://git.kernel.org/soc/soc/c/1b9867b95e1e4a88c80b2e5612b7092b90ae3f88
[14/14] ARM: axxia: remove entire platform
        https://git.kernel.org/soc/soc/c/af4f7acd7b73780c7fece5d156e7d9a7791a60af

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

