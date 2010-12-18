From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2] omap: rx51: Switch rx51_tpa6130a2_data __initdata to __initdata_or_module
Date: Sat, 18 Dec 2010 20:17:10 +0200
Message-ID: <1292696230-31901-1-git-send-email-jhnikula@gmail.com>
References: <20101218002439.GA5941@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:45426 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab0LRSRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 13:17:20 -0500
Received: by eyg5 with SMTP id 5so860584eyg.2
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 10:17:19 -0800 (PST)
In-Reply-To: <20101218002439.GA5941@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>

If the TPA6130 is compiled as module the id and power_gpio values are
arbitrary at module probing time since the rx51_tpa6130a2_data was marked as
__initdata. Fix this by using __initdata_or_module. Then __initdata is
defined only if the kernel is built without CONFIG_MODULES and omitted
otherwise.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
For 2.6.38 as the TPA6130 is not used in 2.6.37.
v2
- __initdata not removed but replaced with __initdata_or_module. Thanks to
  Tony Lindgren <tony@atomide.com> for hint.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 7ea2081..fd95ccf 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -722,7 +722,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
-static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
+static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata_or_module = {
 	.id			= TPA6130A2,
 	.power_gpio		= 98,
 };
-- 
1.7.0.4

