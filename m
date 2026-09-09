Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FEB46E000;
	Wed,  9 Sep 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942526; cv=none; b=HDtVtT5KxgAtuknLY7s7MqgWc9Z+MvsTXtEPG6fjd2cxWSC9KljaJrQs9qIJ6Q5+3ak+5m06mHc5uvyHyVdPZC6JWnriSRqDBbxVpwMNbctlEdWGRbN8pV7NEWbul+Tnjdebs3d9Fo28kIDr0CNMGFjKpwv1X93rONxIy0fVQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942526; c=relaxed/simple;
	bh=vfmBXnNeJ1NpJUYwZFwgJkc9eQg51DMt/p2K4/oDTL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlRNz9Giitv8YDFwV4OCKs79Uhlu2Wnz2EeWpj+K/NUEf+cvwUpyJj7qov6xckeOzwQVCB0XAsv9uETCXwo4jkM979J2gnlXah9T5Nc/gYnxB8VZ6G06pNcBg53i6tKhuOdJLkeymV5sjRuJaRnW5h504DDbP9gkbubk+34vxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=qqEpXggU; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=lQbPuJHC; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="qqEpXggU";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="lQbPuJHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1788942522; bh=vfmBXnNeJ1NpJUYwZFwgJkc9eQg51DMt/p2K4/oDTL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqEpXggU4ubFz3BdyK7idq/XNCa9aAcHQqo7lhT76xOJNC7ccNJhvHdErYC6cfABu
	 Jdb1nrLOCxV3O4Cz1gxNl7W1wzgGhZksuon3cL2G0AhvEKS+OIB1HQFKW/XZSDs5Lh
	 hHq+bQ2PC7Bm2dhOcnzz2PpL8W9VCnQKBioGu+dVhXmDC9AddP8NhmyLrmwjXldIQp
	 GH6i2ZzRIonII5i5Bmc/xNm9XGVIoeqgHT5iDc1QaklfxXtQVv0kkzLrvU7YTQvnSQ
	 +zArK/yKsOUzbQNUl/oudEqwUl9lvsL5NhDs7DtF+TH0tCa3gU0qYKbxv6aClPKfzw
	 OzKhYbo0+5vMA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id ED4BF8702D;
	Wed,  9 Sep 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1788942521; bh=vfmBXnNeJ1NpJUYwZFwgJkc9eQg51DMt/p2K4/oDTL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQbPuJHCUF/s9EUzhJLEsR+4+s06seWE3oYsgcMgjs7C7Cg4K89e/aTL512M8/9JL
	 Ld2oHt8S6ReEbbZdT9EVFhCrYvZloID0MBZWZZMAp5JCKuF2X2YkJIrzYb5B3GYJyg
	 cjm0WpR+pOaRQtL6arz9uUdgVnRNlxdp1lM2L/233opCRL4UxR2lA/HJfAnGGQ4ytv
	 uQjfhU57uJyGaNcKikBKBtP0+I3/4antgAEVE1rRSB9s2PWYMAagDPnit2c7H0Cm/e
	 KgVxSAum7CmJwrBQ8JU8KM05k/gnNxZNUyvTWXrS6l2EGD+UD8Iy+v61GRa0/ReVaV
	 HkNxXw1xvOxeg==
Message-ID: <96ef0d36-51b2-4efe-9f6f-5e4ce6d6046d@mleia.com>
Date: Wed, 9 Sep 2026 11:28:39 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ARM: lpc18xx: remove entire platform
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-10-arnd@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260908152808.3928630-10-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260909_082842_007818_F2240E9C 
X-CRM114-Status: GOOD (  15.50  )

On 9/8/26 18:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The NXP LPC18xx and LPC43xx microcontrollers are the more modern
> version of the classic LPC32xx line, but they lack memory management
> units.
> 
> These microcontrollers all remain in production as of 2026, but
> there are no known users running Linux on them.
> 
> The platform was marked deprecated in the 7.3-LTS release, which
> will remain supported for a few more years.
> 
> Remove support for both LPC18xx and LPC43xx.
> 
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: imx@lists.linux.dev
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Since there is no known users of these pretty old NOMMU platforms in
the Linux kernel, it should be safe to drop them from maintenance.

-- 
Best wishes,
Vladimir
