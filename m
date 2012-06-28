From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: FYI: Merge issue with linux-omap/master (due to merge 'omap-cleanup-for-v3.5')
Date: Thu, 28 Jun 2012 19:58:35 +0530
Message-ID: <4FEC6A13.3020903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36165 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2F1O2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:28:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Tony,

Looks like we have an issue with the merge from branch
"omap-cleanup-for-v3.5",

Patch (ARM: OMAP2+: am33xx: Make am33xx as a separate class) changes
AM335X_CLASS to value 0x33500033 and then later merge commit (Merge tag
'omap-cleanup-for-v3.5' into tmp-merge) reverts it back to 0x33500034.

Due to this Kernel doesn't boot on BeagleBone platform, below change is
required to boot it.


--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -396,7 +394,7 @@ IS_OMAP_TYPE(3430, 0x3430)
#define AM35XX_REV_ES1_0       AM35XX_CLASS
#define AM35XX_REV_ES1_1       (AM35XX_CLASS | (0x1 << 8))

-#define AM335X_CLASS           0x33500034
+#define AM335X_CLASS           0x33500033


Thanks,
Vaibhav
