From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency
Date: Wed, 25 Feb 2015 16:42:12 +0100
Message-ID: <2707228.SKhEXovzW4@wuerfel>
References: <22890811.0MuvZ4MxOU@wuerfel> <54EDEAE3.6080605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59084 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbBYPm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 10:42:27 -0500
In-Reply-To: <54EDEAE3.6080605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com

The change to enable OMAP5 support on this platform was a little too
eager in adding a 'select' for a particular clock driver that might
not be enabled in all configurations, which in turn leads to a build
error:

warning: (SND_OMAP_SOC_OMAP_ABE_TWL6040) selects COMMON_CLK_PALMAS which has unmet direct dependencies (COMMON_CLK && MFD_PALMAS)
drivers/built-in.o: In function `palmas_clks_probe':
drivers/clk/clk-palmas.c:228: undefined reference to `palmas_ext_control_req_config'

I do not see a strong dependency here, so it's probably better to
drop this select and to avoid adding more complexity here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5163c1eede8e9 ("ASoC: omap: Kconfig: Support for omap5-uevm analog audio")
---
v2: change the dependency as suggested by Peter

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index e7c78b0406b5..6768e4f7d7d0 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -105,7 +105,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
 	select SND_SOC_DMIC
-	select COMMON_CLK_PALMAS if SOC_OMAP5
+	select COMMON_CLK_PALMAS if MFD_PALMAS
 	help
 	  Say Y if you want to add support for SoC audio on OMAP boards using
 	  ABE and twl6040 codec. This driver currently supports:

