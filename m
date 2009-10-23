From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 08/11] OMAP3: PM: Disabled I2C4 repeated start operation mode
Date: Fri, 23 Oct 2009 19:03:52 +0300
Message-ID: <1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21493 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZJWQSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:37 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIZL0001682
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:40 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPiC022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:34 +0300
In-Reply-To: <1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Repeated start forces I2C4 pads low during idle, which increases power
consumption through external pull-ups. On the other hand, this change
increases I2C4 command latencies a bit.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fec9c38..154cd31 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1219,7 +1219,7 @@ static void __init configure_vc(void)
 	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
 			  OMAP3_PRM_VC_CH_CONF_OFFSET);
 
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
+	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
 			  OMAP3430_GR_MOD,
 			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
-- 
1.5.4.3

