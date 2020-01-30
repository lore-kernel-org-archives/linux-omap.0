From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] ARM: npcm: Bring back GPIOLIB support
Date: Thu, 30 Jan 2020 20:55:24 +0100
Message-ID: <20200130195525.4525-1-krzk__47953.8883011386$1580414149$gmane$org@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgA3Tzm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 30 Jan 2020 14:55:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org

The CONFIG_ARCH_REQUIRE_GPIOLIB is gone since commit 65053e1a7743
("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB") and all platforms
should explicitly select GPIOLIB to have it.

Cc: <stable@vger.kernel.org>
Fixes: 65053e1a7743 ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-npcm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index 880bc2a5cada..7f7002dc2b21 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -11,7 +11,7 @@ config ARCH_NPCM7XX
 	depends on ARCH_MULTI_V7
 	select PINCTRL_NPCM7XX
 	select NPCM7XX_TIMER
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select CACHE_L2X0
 	select ARM_GIC
 	select HAVE_ARM_TWD if SMP
-- 
2.17.1
