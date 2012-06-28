From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: do not allow SmartReflex to be built as a module
Date: Thu, 28 Jun 2012 09:55:38 -0700
Message-ID: <1340902538-1318-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:57891 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754988Ab2F1Qzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 12:55:42 -0400
Received: by pbcwy7 with SMTP id wy7so3164258pbc.3
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 09:55:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Disable the module option for POWER_AVS since this is currently not
supported.

This patch fixes these error in the case POWER_AVS is set to 'm':

arch/arm/mach-omap2/built-in.o: In function `sr_class3_configure':
/home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:43: undefined reference to `sr_configure_errgen'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_disable':
/home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:33: undefined reference to `sr_disable_errgen'
/home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:35: undefined reference to `sr_disable'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_enable':
/home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:28: undefined reference to `sr_enable'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_init':
/home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:59: undefined reference to `sr_register_class'

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this one fixes the SR related build errors you saw with
randconfig.  It applies to my for_3.6/pm/sr-move branch which is now
included in your devel-driver.  Let me know if want me to fold this
into the original and re-spin the branch.

Also, special thanks to Jean for fixing this immediatly after it 
was reported!

 drivers/power/avs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 18493f7..2a1008b 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -1,5 +1,5 @@
 menuconfig POWER_AVS
-	tristate "Adaptive Voltage Scaling class support"
+	bool "Adaptive Voltage Scaling class support"
 	help
 	  AVS is a power management technique which finely controls the
 	  operating voltage of a device in order to optimize (i.e. reduce)
-- 
1.7.9.2

