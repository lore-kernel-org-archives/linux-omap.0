From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/7] OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
Date: Thu,  1 Mar 2012 14:34:44 +0200
Message-ID: <1330605286-24166-6-git-send-email-tomi.valkeinen@ti.com>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45467 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759149Ab2CAMfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:35:10 -0500
Received: by lahc1 with SMTP id c1so737806lah.12
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:35:07 -0800 (PST)
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The HDMI GPIO pins LS_OE and CT_CP_HPD are not currently configured.
This patch configures them as output pins.

Backported from 78a1ad8f12db70b8b0a4548b90704de08ee216ce

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9bc418e..669e329 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -631,6 +631,9 @@ void omap_4430sdp_display_init(void)
 {
 	sdp4430_hdmi_mux_init();
 	omap_display_init(&sdp4430_dss_data);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 86a2d30..5d519fb 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -674,6 +674,9 @@ void omap4_panda_display_init(void)
 
 	omap4_panda_hdmi_mux_init();
 	omap_display_init(&omap4_panda_dss_data);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1

