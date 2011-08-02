From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] OMAP4: hwmod: enable mcpdm hwmod device.
Date: Tue, 2 Aug 2011 14:34:15 +0300
Message-ID: <1312284857-1774-3-git-send-email-peter.ujfalusi@ti.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1HBLeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 07:34:31 -0400
In-Reply-To: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jorge Eduardo Candelaria
Signed-off-by: Margarita Olaya Cabrera
Signed-off-by: Liam Girdwood <lrg@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e1c69ff..63e7c41 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5121,7 +5121,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_mcbsp4_hwmod,
 
 	/* mcpdm class */
-/*	&omap44xx_mcpdm_hwmod, */
+	&omap44xx_mcpdm_hwmod,
 
 	/* mcspi class */
 	&omap44xx_mcspi1_hwmod,
-- 
1.7.6

