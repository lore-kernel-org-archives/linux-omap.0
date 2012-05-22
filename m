From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: OMAP4: Fix request_irq for HPD
Date: Mon, 21 May 2012 21:47:20 -0500
Message-ID: <1337654841-28378-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36654 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab2EVCro (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 22:47:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4M2lh2n025354
	for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 21:47:43 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4M2lh3N022065
	for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 21:47:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hi Tomi,

While validating HDMI audio on the linux-next tree I found that requesting
the threaded irq for HDMI HDP will fail due to an upcoming change in genirq[1].
This change requires to use the IRQF_ONESHOT flag even for edge type interrupts
if no handler is provided, otherwise the request will fail.

Also, while there, I removed the IRQF_DISABLED flag as it is now deprecated.

If you are OK with the change, I hope it could be merged for K3.5 otherwise
HDMI will fail.

[1].http://www.spinics.net/lists/linux-tip-commits/msg14974.html

Ricardo Neri (1):
  OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request

 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.5.4

