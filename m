From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 03/12] omap: mcbsp: Remove port number enums
Date: Fri,  1 Jul 2011 11:52:27 +0300
Message-ID: <1309510356-27147-4-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab1GAIxA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:52:59 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

These McBSP port number enums are used only in two places in the McBSP code
so we may remove then and just use numeric values like rest of the code does.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap1/mcbsp.c             |    4 ++--
 arch/arm/plat-omap/include/plat/mcbsp.h |   10 +---------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index d9af981..ab7395d 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -38,7 +38,7 @@ static void omap1_mcbsp_request(unsigned int id)
 	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
 	 * are DSP public peripherals.
 	 */
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
+	if (id == 0 || id == 2) {
 		if (dsp_use++ == 0) {
 			api_clk = clk_get(NULL, "api_ck");
 			dsp_clk = clk_get(NULL, "dsp_ck");
@@ -59,7 +59,7 @@ static void omap1_mcbsp_request(unsigned int id)
 
 static void omap1_mcbsp_free(unsigned int id)
 {
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
+	if (id == 0 || id == 2) {
 		if (--dsp_use == 0) {
 			if (!IS_ERR(api_clk)) {
 				clk_disable(api_clk);
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 63464ad..9882c65 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -33,7 +33,7 @@
 #define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
 static struct platform_device omap_mcbsp##port_nr = {	\
 	.name	= "omap-mcbsp-dai",			\
-	.id	= OMAP_MCBSP##port_nr,			\
+	.id	= port_nr - 1,			\
 }
 
 #define MCBSP_CONFIG_TYPE2	0x2
@@ -332,14 +332,6 @@ struct omap_mcbsp_reg_cfg {
 };
 
 typedef enum {
-	OMAP_MCBSP1 = 0,
-	OMAP_MCBSP2,
-	OMAP_MCBSP3,
-	OMAP_MCBSP4,
-	OMAP_MCBSP5
-} omap_mcbsp_id;
-
-typedef enum {
 	OMAP_MCBSP_WORD_8 = 0,
 	OMAP_MCBSP_WORD_12,
 	OMAP_MCBSP_WORD_16,
-- 
1.7.0.4

