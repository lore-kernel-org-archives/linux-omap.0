From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/5] OMAP3: PM: Disabled I2C4 repeated start operation mode
Date: Thu, 12 Nov 2009 12:07:21 +0200
Message-ID: <1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60110 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZKLKZC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:25:02 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOdOk019166
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 04:25:08 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOXWs012786
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 12:24:36 +0200
In-Reply-To: <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Repeated start forces I2C4 pads low during idle, which increases power
consumption through external pull-ups. On the other hand, this change
increases I2C4 command latencies somewhat due to additional master code
sent in the beginning of each I2C4 command (8 bits data + start + ack bits
in fast/standard mode => increases total command duration from 25us to 50us.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b97f7d8..796d726 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1221,7 +1221,7 @@ static void __init configure_vc(void)
 	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
 			  OMAP3_PRM_VC_CH_CONF_OFFSET);
 
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
+	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
 			  OMAP3430_GR_MOD,
 			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
-- 
1.5.4.3

