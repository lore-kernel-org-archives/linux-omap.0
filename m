From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 6/7] arm: omap: smartreflex: fix IRQ handling bug
Date: Mon, 10 Oct 2011 15:26:18 +0300
Message-ID: <1318249579-4089-6-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45753 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654Ab1JJM0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 08:26:39 -0400
Received: by mail-bw0-f49.google.com with SMTP id t2so10195546bka.36
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 05:26:37 -0700 (PDT)
In-Reply-To: <1318249579-4089-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

fix a bug which has been on this driver since
it was added by the original commit 984aa6db
which would never clear IRQSTATUS bits.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6e9eb46..7bdabfa 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -154,7 +154,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		break;
 	case SR_TYPE_V2:
 		/* Read the status bits */
-		sr_read_reg(sr_info, IRQSTATUS);
+		status = sr_read_reg(sr_info, IRQSTATUS);
 
 		/* Clear them by writing back */
 		sr_write_reg(sr_info, IRQSTATUS, status);
-- 
1.7.6.396.ge0613

