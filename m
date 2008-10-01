From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix compile error in board-n800-mmc.c
Date: Wed,  1 Oct 2008 15:19:28 +0300
Message-ID: <1222863568-19022-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64887 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbYJAMUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 08:20:13 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m91CK686010730
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 07:20:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800-mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index 2cf8213..2c5c97c 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -336,7 +336,7 @@ void __init n800_mmc_init(void)
 
 {
 	if (machine_is_nokia_n810()) {
-		n800_mmc1_data.slots[0].name = "external";
+		mmc1_data.slots[0].name = "external";
 
 		/*
 		 * Some Samsung Movinand chips do not like open-ended
@@ -344,8 +344,8 @@ void __init n800_mmc_init(void)
 		 * while doing so. Reducing the number of blocks in
 		 * the transfer or delays in clock disable do not help
 		 */
-		n800_mmc1_data.slots[1].name = "internal";
-		n800_mmc1_data.slots[1].ban_openended = 1;
+		mmc1_data.slots[1].name = "internal";
+		mmc1_data.slots[1].ban_openended = 1;
 	}
 
 	if (omap_request_gpio(slot_switch_gpio) < 0)
-- 
1.5.6.5

