From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] omap: rx51: Remove __initdata from rx51_tpa6130a2_data
Date: Fri, 17 Dec 2010 21:18:23 +0200
Message-ID: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:53601 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0LQTQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 14:16:48 -0500
Received: by ewy10 with SMTP id 10so521061ewy.4
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 11:16:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

If the TPA6130 is compiled as module the id and power_gpio values are
arbitrary at module probing time since the rx51_tpa6130a2_data was marked as
__initdata.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
For 2.6.38 as the TPA6130 is not used in 2.6.37.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 126b724..cde6847 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -719,7 +719,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
-static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
+static struct tpa6130a2_platform_data rx51_tpa6130a2_data = {
 	.id			= TPA6130A2,
 	.power_gpio		= 98,
 };
-- 
1.7.2.3

