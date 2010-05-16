From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] dspbridge: fix build when OMAP_MCBSP=n
Date: Sun, 16 May 2010 18:44:59 +0300
Message-ID: <1274024702-20961-2-git-send-email-felipe.contreras@gmail.com>
References: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:23494 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0EPPpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:45:11 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359664fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:45:09 -0700 (PDT)
In-Reply-To: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/dsp-clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/core/dsp-clock.c b/drivers/dsp/bridge/core/dsp-clock.c
index 3683dc3..7df100a 100644
--- a/drivers/dsp/bridge/core/dsp-clock.c
+++ b/drivers/dsp/bridge/core/dsp-clock.c
@@ -147,6 +147,7 @@ void dsp_clk_init(void)
 					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
 }
 
+#ifdef CONFIG_OMAP_MCBSP
 static void mcbsp_clk_prepare(bool flag, u8 id)
 {
 	struct cfg_hostres *resources;
@@ -192,6 +193,7 @@ static void mcbsp_clk_prepare(bool flag, u8 id)
 		}
 	}
 }
+#endif
 
 /*
  *  ======== dsp_clk_enable ========
@@ -215,11 +217,13 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 	case GPT_CLK:
 		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
 		break;
+#ifdef CONFIG_OMAP_MCBSP
 	case MCBSP_CLK:
 		mcbsp_clk_prepare(true, clk_id);
 		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
 		omap_mcbsp_request(MCBSP_ID(clk_id));
 		break;
+#endif
 	case WDT_CLK:
 		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
 		break;
@@ -290,10 +294,12 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 	case GPT_CLK:
 		omap_dm_timer_free(timer[clk_id]);
 		break;
+#ifdef CONFIG_OMAP_MCBSP
 	case MCBSP_CLK:
 		mcbsp_clk_prepare(false, clk_id);
 		omap_mcbsp_free(MCBSP_ID(clk_id));
 		break;
+#endif
 	case WDT_CLK:
 		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
 		break;
-- 
1.7.1

