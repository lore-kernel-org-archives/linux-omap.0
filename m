From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 3/3] OMAP4: hwmod data: Enable AESS hwmod device
Date: Fri, 4 Jan 2013 14:02:06 +0100
Message-ID: <1357304526-21557-4-git-send-email-s-guiriec@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53627 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692Ab3ADNCT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 08:02:19 -0500
In-Reply-To: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Enable AESS data in hwmod in order to be able to probe
audio driver.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 26d6cde..dd60e52 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -6286,7 +6286,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_1__l3_main_3,
 	&omap44xx_l3_main_2__l3_main_3,
 	&omap44xx_l4_cfg__l3_main_3,
-	/* &omap44xx_aess__l4_abe, */
+	&omap44xx_aess__l4_abe,
 	&omap44xx_dsp__l4_abe,
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
@@ -6295,8 +6295,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__l4_wkup,
 	&omap44xx_mpu__mpu_private,
 	&omap44xx_l4_cfg__ocp_wp_noc,
-	/* &omap44xx_l4_abe__aess, */
-	/* &omap44xx_l4_abe__aess_dma, */
+	&omap44xx_l4_abe__aess,
+	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
 	&omap44xx_l4_cfg__ctrl_module_core,
-- 
1.7.10.4

