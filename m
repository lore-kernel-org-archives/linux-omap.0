From: Anders Hedlund <anders.j.hedlund@gmail.com>
Subject: [PATCH v2] ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct mux mode
Date: Mon, 29 Oct 2012 20:25:42 +0100
Message-ID: <1351538742-27380-1-git-send-email-anders.j.hedlund@gmail.com>
References: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50872 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab2J2TZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 15:25:56 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3326841lbo.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Oct 2012 12:25:54 -0700 (PDT)
In-Reply-To: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Anders Hedlund <anders.j.hedlund@gmail.com>, Jonas Zetterberg <jozz@jozz.se>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Matthias Brugger <mbrugger@iseebcn.com>

Setup the WIFI/BT GPIO pin muxes to enable WIFI/BT functionality.

Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
Cc: Jonas Zetterberg <jozz@jozz.se>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Matthias Brugger <mbrugger@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 2821448..2a21947 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -583,6 +583,11 @@ static void __init igep_wlan_bt_init(void)
 	} else
 		return;
 
+	/* Make sure that the GPIO pins are muxed correctly */
+	omap_mux_init_gpio(igep_wlan_bt_gpios[0].gpio, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(igep_wlan_bt_gpios[1].gpio, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(igep_wlan_bt_gpios[2].gpio, OMAP_PIN_OUTPUT);
+
 	err = gpio_request_array(igep_wlan_bt_gpios,
 				 ARRAY_SIZE(igep_wlan_bt_gpios));
 	if (err) {
-- 
1.7.10.4

