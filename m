From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updates: 3430sdp and omap3evm results
Date: Tue, 27 Jan 2009 10:16:06 -0800
Message-ID: <87fxj4ty1l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:9613 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZA0SQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 13:16:12 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2827424yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 10:16:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've updated the PM branch with a couple of fixes that get it working
on the 3430SDP.

For it to work on the SDP, you need the latest u-boot from the
omapzoom u-boot tree[1].  This fixes the problems I was having with
the D2D clockdomain remaining active or hanging upon clock disable.

For omap3evm, it is not hitting retention because it uses the GPIO
debounce feature for the touchscreen and the GPIO debounce clocks are
not disabled in idle or suspend.  As a temporary hack, you can test
the patch below[2] which simply doesn't call the gpio debounce
functions for the touchscreen.  In the meantime, I'm working on a
patch to disable the debounce clocks on idle.

Kevin

[1] git://git.omapzoom.org/repo/u-boot.git

[2]
da7df18bc7f5648ac7fe6e674065ca5899ff8d3d
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6fbbe95..18a07b5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -176,8 +176,8 @@ static void ads7846_dev_init(void)
 
 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
 
-	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
+/* 	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1); */
+/* 	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa); */
 }
 
