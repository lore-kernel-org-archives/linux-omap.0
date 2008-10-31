From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] DSPBRIDGE: Ensure write posting when acking
	mailbox irq
Date: Fri, 31 Oct 2008 14:06:55 -0700
Message-ID: <20081031210654.GF28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <1225480873-30835-2-git-send-email-tony@atomide.com> <1225480873-30835-3-git-send-email-tony@atomide.com> <1225480873-30835-4-git-send-email-tony@atomide.com> <1225480873-30835-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62833 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYJaVG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 17:06:57 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Kw1Cq-0008U3-9O
	for linux-omap@vger.kernel.org; Fri, 31 Oct 2008 21:06:56 +0000
Content-Disposition: inline
In-Reply-To: <1225480873-30835-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081031 12:21]:
> The only way to ensure write posting to L4 bus is to do a read back
> of the same register right after the write.
> 
> This seems to be mostly needed in interrupt handlers to avoid
> causing spurious interrupts.
> 
> The earlier fix has been to mark the L4 bus as strongly ordered
> memory, which solves the problem, but causes performance penalties.
> 
> Similar fixes may be needed in other interrupt handlers too.

Here's this one updated to say "flush posted write" for easy grepping.

Tony

--eRtJSFbw+EEWtPj3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="flush-dspbridge-v2.patch"

>From 0124b6a0f24e3d8a305e61d897a9866903b12485 Mon Sep 17 00:00:00 2001
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

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 7055259..e07e5a7 100644
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

--eRtJSFbw+EEWtPj3--
