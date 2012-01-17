From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/6] OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
Date: Tue, 17 Jan 2012 14:49:00 +0200
Message-ID: <1326804542-22285-5-git-send-email-tomi.valkeinen@ti.com>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48442 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688Ab2AQMt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:49:58 -0500
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The HDMI GPIO pins LS_OE and CT_CP_HPD are not currently configured.
This patch configures them as output pins.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ae0c09f..5dcc8df 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -833,6 +833,9 @@ static void omap_4430sdp_display_init(void)
 		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
 	else
 		omap_hdmi_init(0);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 133b5a7..06a7075 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -549,6 +549,9 @@ void omap4_panda_display_init(void)
 		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
 	else
 		omap_hdmi_init(0);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1

