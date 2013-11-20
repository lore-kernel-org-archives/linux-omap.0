From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 11/11] ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_dsi
Date: Wed, 20 Nov 2013 02:06:15 +0100
Message-ID: <1384909575-19108-12-git-send-email-javier.martinez@collabora.co.uk>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34769 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab3KTBHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 20:07:49 -0500
In-Reply-To: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Device Tree boot the VDDS_DSI regulator is not linked to
the DPI device so omapfb driver probing fails with:

[    3.186035] OMAPFB: omapfb_probe
[    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
[    3.196594] omapfb omapfb: failed to connect default display
[    3.202667] omapfb omapfb: failed to init overlay connections
[    3.208892] OMAPFB: free_resources
[    3.212493] OMAPFB: free all fbmem
[    3.216735] omapfb omapfb: failed to setup omapfb

As a workaround name the VPLL2 regulator from twl4030 as vdds_dsi
so getting the VDDS_DSI regulator will succeed on dpi_init_regulator().

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index b9a9e17..1c7e74d 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -215,3 +215,8 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&vpll2 {
+        /* Needed for DSS */
+        regulator-name = "vdds_dsi";
+};
-- 
1.8.4.2

