From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [RESEND][PATCH 1/5][omapzoom] BRIDGE: Fix bug in HW Mailbox
 messaging
Date: Thu, 13 Nov 2008 20:09:45 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E11EBF3C@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYKNCJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 21:09:52 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAE29kFK032602
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:09:51 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAE29kZ0029869
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:09:46 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Suman Anna <s-anna@ti.com>
Date: Fri, 10 Oct 2008 21:06:52 -0500
Subject: [PATCH] BRIDGE: Fix bug in HW Mailbox messaging

Complement should apply to the whole expression for
irqDisableReg

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 7055259..cc7ea0b 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -215,8 +215,8 @@ HW_STATUS HW_MBOX_EventDisable(const u32 baseAddress,
 		    (u32)userId);
 
 	/* update enable value */
-	irqDisableReg &= ~((u32)(events)) << (((u32)(mailBoxId)) *
-		     HW_MBOX_ID_WIDTH);
+	irqDisableReg &= ~(((u32)(events)) << (((u32)(mailBoxId)) *
+		     HW_MBOX_ID_WIDTH));
 
 	/* write new enable status */
 	MLBMAILBOX_IRQENABLE___0_3WriteRegister32(baseAddress, (u32)userId,
-- 
1.6.0
