From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap: Fix build break with omap3_defconfig
Date: Fri, 28 May 2010 21:23:42 +0530
Message-ID: <1275062022-15067-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab0E1Pxt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 11:53:49 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4SFriIx017778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 10:53:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

With latest linus's tip omap3_defconfig is broken.

>From the commit 8feb337475aaf, board-omap3stalker.c seems to
be missed out.

 LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined reference to `omap_set_gpio_debounce'
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined reference to `omap_set_gpio_debounce_time'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f848ba8..a04cffd 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -538,9 +538,7 @@ static void ads7846_dev_init(void)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
-
-	omap_set_gpio_debounce(OMAP3_STALKER_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_STALKER_TS_GPIO, 0xa);
+	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
 }
 
 static int ads7846_get_pendown_state(void)
-- 
1.6.0.4

