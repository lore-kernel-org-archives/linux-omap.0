Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85579484254;
	Thu, 10 Sep 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043037; cv=none; b=AyLYcw+XDTK7g3hbCebm1CErrYAVOwWL9Pu+0ZaEjjI35cmtdCLIxy1oP57pnUIjyzaUG1tf7m9JK/7AHyr9urt8I3WZI9k/k6CdwuyWOHyBjojmNSCZ4uMzgOYYAcO5qcIV5zJBmmJOx6Ykcxgzo0cqGs/sjlGcxKg290EysgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043037; c=relaxed/simple;
	bh=jgzMo+jc3q+A/v2xMacCodsLl/Wrx/OHS3haDtdDJtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kS0iqAcc+bNs4lZSBBE+lHtnnKGmbLh5h2wrYU0Zuy81DDmaubbyZOzJdf3Pq1amPFBoMMkCHYyEt2ETtZ5yLi9XW40kqPoXQPZ4NKCvMB/ihHQ+MUwnaHWe0Z1VZ9U8Ai6sgnYm0D7eKNo4C8b6O/2vVrTW5YUS2OL277IheAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HMxWYxGz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HMxWYxGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789043040; x=1820579040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jgzMo+jc3q+A/v2xMacCodsLl/Wrx/OHS3haDtdDJtE=;
  b=HMxWYxGzEb6h/CFuAtPpjl7I1EtvN0xkoXpgSa6GGxGjPN4dRcYa+mqR
   YOMkeJkzLm0MAbwItnrS4tbEP3tyjvTGxJ+Taiqmpph11u8vmltCOM//c
   xpYeJsitjy40cO6+hcnu40atvw620gv9mkVm3eGCr0VAZOVzVtbWDz1GF
   pfVmGIVvlQx26T02a4agtBY3eOw2CEloUZsl9/GZPv7GB5wCmSxUfv+tL
   jRrvYy/ia3fOu1G2B9e25pVsPvaNEExmz3CbMDYGrGiJRuT55AFJUC13z
   rY7F0/WefnUP6OqPkhXm6xNiV0GCrPjRSgULBBBdatVbWMYLn2HirxhOS
   g==;
X-CSE-ConnectionGUID: xFhwPbRkQRugnQXNKtFw3A==
X-CSE-MsgGUID: NYit3wuCSTaiBpQ/FT2mrg==
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="294821368"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 05:23:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 10 Sep 2026 05:23:47 -0700
Received: from [10.171.248.45] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 10 Sep 2026 05:23:38 -0700
Message-ID: <86617617-0c89-485d-994e-7c98b42e526a@microchip.com>
Date: Thu, 10 Sep 2026 14:23:36 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ARM: at91: remove samv7 support
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij
	<linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liviu Dudau
	<liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan
 Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik
	<robert.jarzmik@free.fr>, Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre
	<npitre@baylibre.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-omap@vger.kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-13-arnd@kernel.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260908152808.3928630-13-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2026 at 17:28, Arnd Bergmann wrote:
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

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/Kconfig.debug      | 10 ----------
>   arch/arm/mach-at91/Kconfig  | 11 +----------
>   arch/arm/mach-at91/Makefile |  1 -
>   arch/arm/mach-at91/samv7.c  | 17 -----------------
>   drivers/soc/atmel/soc.c     | 36 ------------------------------------
>   5 files changed, 1 insertion(+), 74 deletions(-)
>   delete mode 100644 arch/arm/mach-at91/samv7.c

[..]
