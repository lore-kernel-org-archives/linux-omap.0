From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] DSPBRIDGE: Ensure write posting when acking mailbox irq
Date: Fri, 31 Oct 2008 12:21:13 -0700
Message-ID: <1225480873-30835-5-git-send-email-tony@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <1225480873-30835-2-git-send-email-tony@atomide.com>
 <1225480873-30835-3-git-send-email-tony@atomide.com>
 <1225480873-30835-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59236 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYJaTV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:21:27 -0400
In-Reply-To: <1225480873-30835-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

The only way to ensure write posting to L4 bus is to do a read back
of the same register right after the write.

This seems to be mostly needed in interrupt handlers to avoid
causing spurious interrupts.

The earlier fix has been to mark the L4 bus as strongly ordered
memory, which solves the problem, but causes performance penalties.

Similar fixes may be needed in other interrupt handlers too.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 7055259..96b5680 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -251,5 +251,20 @@ HW_STATUS HW_MBOX_EventAck(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
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
+	 * Do a read back for the irq status to ensure the write above gets
+	 * posted to avoid spurious interrupts.
+	 */
+	MLBMAILBOX_IRQSTATUS___0_3ReadRegister32(baseAddress, (u32)userId);
+
 	return status;
 }
