From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 3/4] staging:ti dspbridge: make sure IVA2 is OFF when dev is created
Date: Wed, 28 Jul 2010 09:54:54 -0500
Message-ID: <1280328895-31375-4-git-send-email-ernesto@ti.com>
References: <1280328895-31375-1-git-send-email-ernesto@ti.com>
 <1280328895-31375-2-git-send-email-ernesto@ti.com>
 <1280328895-31375-3-git-send-email-ernesto@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280328895-31375-3-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>
List-Id: linux-omap@vger.kernel.org

Regardless the IVA2 power state before bridgedriver is
installed, the driver must ensure that IVA2 power
state is OFF when the device driver is created.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 77527bd..e7584de 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -919,8 +919,10 @@ static int bridge_dev_create(struct bridge_dev_context
 	if (!status) {
 		dev_context->hdev_obj = hdev_obj;
 		/* Store current board state. */
-		dev_context->dw_brd_state = BRD_STOPPED;
+		dev_context->dw_brd_state = BRD_UNKNOWN;
 		dev_context->resources = resources;
+		dsp_clk_enable(DSP_CLK_IVA2);
+		bridge_brd_stop(dev_context);
 		/* Return ptr to our device state to the DSP API for storage */
 		*dev_cntxt = dev_context;
 	} else {
-- 
1.5.4.5
