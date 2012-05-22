From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request
Date: Mon, 21 May 2012 21:47:21 -0500
Message-ID: <1337654841-28378-2-git-send-email-ricardo.neri@ti.com>
References: <1337654841-28378-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2EVCro (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 22:47:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4M2lhU3029152
	for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 21:47:43 -0500
Received: from DFLE71.ent.ti.com (dfle71.ent.ti.com [128.247.5.62])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4M2lhrJ022062
	for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 21:47:43 -0500
In-Reply-To: <1337654841-28378-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

genirq requires that the IRQ requests that do not provided a handler to
use the IRQF_ONESHOT flag. This is to prevent situations in which the irq line
is reenabled while the interrupt is still asserted. While this situation may
not happen in edge type interrupts, genirq still requires to use IRQF_ONESHOT.

Also, remove the IRQF_DISABLED as the flag is now a NOOP and has been
deprecated.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 4dcdbbb..d52823d 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -303,9 +303,9 @@ int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
 	REG_FLD_MOD(phy_base, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
 
 	r = request_threaded_irq(gpio_to_irq(ip_data->hpd_gpio),
-			NULL, hpd_irq_handler,
-			IRQF_DISABLED | IRQF_TRIGGER_RISING |
-			IRQF_TRIGGER_FALLING, "hpd", ip_data);
+				 NULL, hpd_irq_handler,
+				 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				 IRQF_ONESHOT, "hpd", ip_data);
 	if (r) {
 		DSSERR("HPD IRQ request failed\n");
 		hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
-- 
1.7.5.4

