From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/8] ARM: OMAP: 3430sdp: Enable extmute functionality for audio
Date: Fri, 18 Jan 2013 15:31:49 +0100
Message-ID: <1358519516-13165-2-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58042 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756106Ab3AROcD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:32:03 -0500
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Enable the use of extmute on the HS path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bb73afc..40c22a7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -382,6 +382,9 @@ static int __init omap3430_i2c_init(void)
 	sdp3430_twldata.vpll2->constraints.apply_uV = true;
 	sdp3430_twldata.vpll2->constraints.name = "VDVI";
 
+	sdp3430_twldata.audio->codec->hs_extmute = 1;
+	sdp3430_twldata.audio->codec->hs_extmute_gpio = -EINVAL;
+
 	omap3_pmic_init("twl4030", &sdp3430_twldata);
 
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
-- 
1.8.1

