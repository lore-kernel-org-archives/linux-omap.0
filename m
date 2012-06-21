From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP4: hwmod data: add HWMOD_SWSUP_SIDLE
 to dss_hdmi to data
Date: Thu, 21 Jun 2012 10:28:57 +0200
Message-ID: <4FE2DB49.6040508@ti.com>
References: <1340233810-1087-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38893 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758727Ab2FUI3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 04:29:03 -0400
In-Reply-To: <1340233810-1087-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, s-guiriec@ti.com, mythripk@ti.com, linux-omap@vger.kernel.org

Hi Ricardo,

In fact the flags attribute was not located correctly with regard to the template used by the scripts.
I updated the script, the patch, the subject and fix a typo in the changelog.

Please find below the updated version.

Regards,
Benoit


---
>From 9a89d06f9de9a4efbfc49d0c5adf0fa0d0031bdf Mon Sep 17 00:00:00 2001
From: Ricardo Neri <ricardo.neri@ti.com>
Date: Thu, 21 Jun 2012 10:08:53 +0200
Subject: [PATCH] ARM: OMAP4: hwmod data: Force HDMI in no-idle while enabled

As per the OMAP4 documentation, audio over HDMI must be transmitted in
no-idle mode. This patch adds the HWMOD_SWSUP_SIDLE so that omap_hwmod uses
no-idle/force-idle settings instead of smart-idle mode.

This is required as the DSS interface clock is used as functional clock
for the HDMI wrapper audio FIFO. If no-idle mode is not used, audio could
be choppy, have bad quality or not be audible at all.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
[b-cousson@ti.com: Update the subject and align the .flags
location with the script template]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index aae6e5e..f51b35f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -858,6 +858,11 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap44xx_hdmi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	/*
+	 * HDMI audio requires to use no-idle mode. Hence,
+	 * set idle mode by software.
+	 */
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
-- 
1.7.0.4


