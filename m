From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH][omapzoom]DSPBRIDGE: Flush posted write when acking mailbox
 irq
Date: Tue, 11 Nov 2008 11:03:48 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E1172B22@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYKKRD4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 12:03:56 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mABH3oqR018083
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 11:03:55 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mABH3ofZ000838
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 11:03:50 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks to Tony for this patch.

- omar 

---
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 31 Oct 2008 12:02:57 -0700
Subject: [PATCH] DSPBRIDGE: Flush posted write when acking mailbox irq

The only way to flush posted write to L4 bus is to do a read back
of the same register right after the write.

This seems to be mostly needed in interrupt handlers to avoid
causing spurious interrupts.

The earlier fix has been to mark the L4 bus as strongly ordered
memory, which solves the problem, but causes performance penalties.

Similar fixes may be needed in other interrupt handlers too.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index cc7ea0b..2c14ade 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -251,5 +251,19 @@ HW_STATUS HW_MBOX_EventAck(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 	MLBMAILBOX_IRQSTATUS___0_3WriteRegister32(baseAddress, (u32)userId,
 					     (u32)irqStatusReg);
 
+	/*
+	 * FIXME: Replace all this custom register access with standard
+	 * __raw_read/write().
+	 *
+	 * FIXME: Replace all interrupt handlers with standard linux style
+	 * interrupt handlers.
+	 *
+	 * FIXME: Replace direct access to PRCM registers with omap standard
+	 * PRCM register access.
+	 *
+	 * Flush posted write for the irq status to avoid spurious interrupts.
+	 */
+	MLBMAILBOX_IRQSTATUS___0_3ReadRegister32(baseAddress, (u32)userId);
+
 	return status;
 }
-- 
1.5.6.3
