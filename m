From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Wed, 5 Nov 2008 12:39:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40560 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbYKETj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 14:39:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>


The SGX device on OMAP3 does not support retention, so remove RET from the 
list of possible SGX power states.  Problem debugged by Richard Woodruff 
<r-woodruff2@ti.com>.
    
Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 446a1ed..edfad42 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -255,6 +255,11 @@ static struct powerdomain dss_pwrdm = {
 	},
 };
 
+/*
+ * Although the 34XX TRM Rev K Table 4-371 notes that retention is a
+ * possible SGX powerstate, the SGX device itself does not support
+ * retention.
+ */
 static struct powerdomain sgx_pwrdm = {
 	.name		  = "sgx_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
@@ -262,7 +267,7 @@ static struct powerdomain sgx_pwrdm = {
 	.wkdep_srcs	  = gfx_sgx_wkdeps,
 	.sleepdep_srcs	  = cam_gfx_sleepdeps,
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
