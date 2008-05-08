From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 8 May 2008 18:35:06 +0200
Message-ID: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:58701 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbYEHQkt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2008 12:40:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Khasim Syed Mohammed <khasim@ti.com>, Beagle Board <beagleboard@googlegroups.com>

This patch adds RTC support to the omap3 based beagleboard

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
  arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
  1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
omap2/board-omap3beagle.c
index 626f004..e7b471b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -58,11 +58,22 @@ static struct omap_mmc_config  
omap3beagle_mmc_config __initdata = {
  	},
  };

+static struct platform_device omap3_beagle_twl4030rtc_device = {
+	.name           = "twl4030_rtc",
+	.id             = -1,
+};
+
  static struct omap_board_config_kernel omap3_beagle_config[]  
__initdata = {
  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
  	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
  };

+static struct platform_device *omap3_beagle_devices[] __initdata = {
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&omap3_beagle_twl4030rtc_device,
+#endif
+};
+
  static void __init omap3_beagle_init(void)
  {
  	omap_board_config = omap3_beagle_config;
-- 
1.5.4.3


