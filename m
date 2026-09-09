Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EA453A48;
	Wed,  9 Sep 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942291; cv=none; b=WOn8LQt4CeVIw+Rz/yXbZt5fi4Cy1hstbHDyEHIJuX/ak0wHteAn76luAUQUV2DVco2TuvmeORc5NKDUTmqiqQFe0eBMrXwYdy5TzHPoGB4dC5Tz7ZS0M+AsVWyyvcUkT7z5aWWSpFFyq05nbg8DaIYi3q/co2gzkSqCfUN2+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942291; c=relaxed/simple;
	bh=DALhJgrp1N9sdmCEOJnvPHzTPos7appyxxVQnOEMFCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEoSjjoEyP1FsyWWzkhZmdG0ypvoPqxXNq1/mKiNwlqBMMp29j+sEbecf2bJNOM6J5/KnXFr4X8ie3eg2WIX3g80gk2JzojkcvChNMtd+iCPGpqXUAx3FXMzbBSKq24WMJhyIJCsmcG4T3d5bw6HCI3PzsDWrYvuhJz35cQajEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=rvGrjhs4; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=rvGrjhs4; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="rvGrjhs4";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="rvGrjhs4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1788942281; bh=DALhJgrp1N9sdmCEOJnvPHzTPos7appyxxVQnOEMFCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvGrjhs4cfqezCJ6hO0AJ62He6bHVP8uw0YXLGtu5sbsG0wXu/5zCZ65jVSllKuSp
	 7uX14J/0ozSfzLe8xVzKZwO6PQ6/Ln9GzgF2KTyHiIlA5SFEoc5W3rZyj5SkP9MoPs
	 DHAK0SaFNzAOTv8W3fjNSdXOzu3wGRhsGufLqdsoPg9ddXAYi2MXt1sc8zzMWG6WeZ
	 lp5RudD6KD4M4zz6+wkYnAqvevlpPBgs+nerzAtxWsOAU/G8XnIa+0O7pvuFx6YosK
	 n47k0eDeoCzxXrxxAwyylucyqzTfV5s8EtBr904uzOHvikCcUv1qJm2UZv9FgToWTg
	 mfw1y+VAyVZLQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9133887006;
	Wed,  9 Sep 2026 08:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1788942281; bh=DALhJgrp1N9sdmCEOJnvPHzTPos7appyxxVQnOEMFCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvGrjhs4cfqezCJ6hO0AJ62He6bHVP8uw0YXLGtu5sbsG0wXu/5zCZ65jVSllKuSp
	 7uX14J/0ozSfzLe8xVzKZwO6PQ6/Ln9GzgF2KTyHiIlA5SFEoc5W3rZyj5SkP9MoPs
	 DHAK0SaFNzAOTv8W3fjNSdXOzu3wGRhsGufLqdsoPg9ddXAYi2MXt1sc8zzMWG6WeZ
	 lp5RudD6KD4M4zz6+wkYnAqvevlpPBgs+nerzAtxWsOAU/G8XnIa+0O7pvuFx6YosK
	 n47k0eDeoCzxXrxxAwyylucyqzTfV5s8EtBr904uzOHvikCcUv1qJm2UZv9FgToWTg
	 mfw1y+VAyVZLQ==
Message-ID: <e337bf5c-6ecf-4a65-b8e7-e11bb9aba8ff@mleia.com>
Date: Wed, 9 Sep 2026 11:24:34 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ARM: imx: remove i.MX31 SoC support
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
 <20260908152808.3928630-8-arnd@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260908152808.3928630-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260909_082441_623355_2FCF1B4C 
X-CRM114-Status: GOOD (  16.73  )

On 9/8/26 18:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Freescale i.MX31 was an early SoC based on the ARM1136r0 CPU core. It
> was used in the Bug Labs modular computer but ultimately much less
> popular than most other i.MX SoCs.
> 
> As the ARM1136r0 support is causing a lot of extra maintenance effort
> to keep alive and there are no known users, remove i.MX31 in order to
> allow removing support for that CPU core altogether.
> 
> The related i.MX35 is based on a slightly newer ARM1136r1 CPU core that
> does not have this problem, so there is no reason to remove that.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: imx@lists.linux.dev
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

I still do possess a LogicPD i.MX31 Lite board, which boots the upstream
kernel, but there is no plan to maintain it further.

-- 
Best wishes,
Vladimir
