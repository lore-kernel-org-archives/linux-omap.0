From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
Date: Sat, 16 Nov 2013 14:23:43 +0100
Message-ID: <1384608224-9452-11-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60389 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab3KPNZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:25:06 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

IGEP's DVI connector's DDC pins are connected to OMAP's third i2c bus.

When booting with Device Trees the requested bus number is set to -1
which means that the bus number should be dynamically assigned. So the
third i2c bus has 2 has a bus number.

Since now only DT booting is supported for IGEP boards after commit
06ff74fd ("ARM: OMAP2+: remove legacy support for IGEP boards"), the
i2c bus number has to be changed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/dss-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 365bfd3..dadccc9 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -223,7 +223,7 @@ void __init omap_4430sdp_display_init_of(void)
 static struct connector_dvi_platform_data omap3_igep2_dvi_connector_pdata = {
 	.name                   = "dvi",
 	.source                 = "tfp410.0",
-	.i2c_bus_num            = 3,
+	.i2c_bus_num            = 2,
 };
 
 static struct platform_device omap3_igep2_dvi_connector_device = {
-- 
1.8.4.2

