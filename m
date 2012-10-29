From: Anders Hedlund <anders.j.hedlund@gmail.com>
Subject: [PATCH] ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct mux mode
Date: Mon, 29 Oct 2012 18:51:13 +0100
Message-ID: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38335 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2J2Rvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 13:51:32 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3255885lbo.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Oct 2012 10:51:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Anders Hedlund <anders.j.hedlund@gmail.com>, Jonas Zetterberg <jozz@jozz.se>, Enric Balletbo i Serra <eballetbo@gmail.com>

Configure the WIFI/BT GPIO pin muxes unless the bootloader hasn't already
done so.

Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
Cc: Jonas Zetterberg <jozz@jozz.se>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index dbc705a..17e45bc 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -579,6 +579,13 @@ static void __init igep_wlan_bt_init(void)
 	} else
 		return;
 
+#ifdef CONFIG_OMAP_MUX
+	/* Make sure that the GPIO pins are muxed correctly */
+	omap_mux_init_gpio(igep_wlan_bt_gpios[0].gpio, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(igep_wlan_bt_gpios[1].gpio, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(igep_wlan_bt_gpios[2].gpio, OMAP_PIN_OUTPUT);
+#endif
+
 	err = gpio_request_array(igep_wlan_bt_gpios,
 				 ARRAY_SIZE(igep_wlan_bt_gpios));
 	if (err) {
-- 
1.7.10.4

