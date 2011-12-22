From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] OMAP2/3: mcbsp: Check McBSP port number in CLKR/FSR mux callback
Date: Thu, 22 Dec 2011 19:31:42 +0200
Message-ID: <1324575106-17172-2-git-send-email-peter.ujfalusi@ti.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:51007 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755411Ab1LVRb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:31:56 -0500
Received: by lagu2 with SMTP id u2so3441904lag.9
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:31:53 -0800 (PST)
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

CLKR/FSR mux is only possible on port 1.
Make sure that we only change the mux if the call is made with the
correct mcbsp device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 829f4c7..269765c 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -38,8 +38,13 @@
 static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
 				   const char *src)
 {
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
 	u32 v;
 
+	/* Only McBSP1 have 6 pin configuration (CLKR/FSR source selectable) */
+	if (mcbsp->id != 0)
+		return -EINVAL;
+
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 
 	if (!strcmp(signal, "clkr")) {
-- 
1.7.8.1

