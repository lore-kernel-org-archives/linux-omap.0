From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 1/2] omap: rx51: Set regulator V28_A always on
Date: Tue, 31 May 2011 11:27:00 +0300
Message-ID: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42430 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab1EaI06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 04:26:58 -0400
Received: by eyx24 with SMTP id 24so1571860eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 01:26:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The V28_A domain in Nokia N900 that supplies VDD voltages to TLV320AIC34 and
TPA6130A2 should not be shutdown. This is because otherwise there will be
leak from VIO to VDD in TLV320AIC34 and this leak consumes more battery
current that is saved from keeping V28_A off. With this patch the battery
current consumption is approximately 1.5 mA lower.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
No changes from v1. Just sent together with 2/2.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index f6247e7..02a6587 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -488,6 +488,7 @@ static struct regulator_init_data rx51_vmmc2 = {
 		.name			= "V28_A",
 		.min_uV			= 2800000,
 		.max_uV			= 3000000,
+		.always_on		= true, /* due VIO leak to AIC34 VDDs */
 		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
-- 
1.7.4.4

