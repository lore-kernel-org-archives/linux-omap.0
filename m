From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 2/3] dmaengine: cppi41: Add support of DA8xx to CPPI 4.1
Date: Tue, 24 Jan 2017 10:58:47 +0100
Message-ID: <20170124095848.14593-3-abailon@baylibre.com>
References: <20170124095848.14593-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124095848.14593-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DA8xx has a CPPI 4.1 DMA controller.
This is add the glue layer required to make it work on DA8xx.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/Kconfig  |  6 +++---
 drivers/dma/cppi41.c | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0d6a96e..2a31e1a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -514,12 +514,12 @@ config TIMB_DMA
 	  Enable support for the Timberdale FPGA DMA engine.
 
 config TI_CPPI41
-	tristate "AM33xx CPPI41 DMA support"
-	depends on ARCH_OMAP
+	tristate "CPPI 4.1 DMA support"
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
 	select DMA_ENGINE
 	help
 	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
-	  is currently used by the USB driver on AM335x platforms.
+	  is currently used by the USB driver on AM335x and DA8xx platforms.
 
 config TI_DMA_CROSSBAR
 	bool
diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 21a4f79..5c501da 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -221,6 +221,20 @@ static const struct chan_queues am335x_usb_queues_rx[] = {
 	[29] = { .submit = 30, .complete = 155},
 };
 
+static const struct chan_queues da8xx_usb_queues_tx[] = {
+	[0] = { .submit =  16, .complete = 24},
+	[1] = { .submit =  18, .complete = 24},
+	[2] = { .submit =  20, .complete = 24},
+	[3] = { .submit =  22, .complete = 24},
+};
+
+static const struct chan_queues da8xx_usb_queues_rx[] = {
+	[0] = { .submit =  1, .complete = 26},
+	[1] = { .submit =  3, .complete = 26},
+	[2] = { .submit =  5, .complete = 26},
+	[3] = { .submit =  7, .complete = 26},
+};
+
 struct cppi_glue_infos {
 	const struct chan_queues *queues_rx;
 	const struct chan_queues *queues_tx;
@@ -949,8 +963,17 @@ static const struct cppi_glue_infos am335x_usb_infos = {
 	.qmgr_num_pend = 5,
 };
 
+static const struct cppi_glue_infos da8xx_usb_infos = {
+	.queues_rx = da8xx_usb_queues_rx,
+	.queues_tx = da8xx_usb_queues_tx,
+	.td_queue = { .submit = 31, .complete = 0 },
+	.first_completion_queue = 24,
+	.qmgr_num_pend = 2,
+};
+
 static const struct of_device_id cppi41_dma_ids[] = {
 	{ .compatible = "ti,am3359-cppi41", .data = &am335x_usb_infos},
+	{ .compatible = "ti,da830-cppi41", .data = &da8xx_usb_infos},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cppi41_dma_ids);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
