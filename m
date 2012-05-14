From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 2/8] TEMP: ARM: OMAP4: hwmod_data: Do not get DSP out of reset at boot time
Date: Mon, 14 May 2012 13:03:10 +0300
Message-ID: <1336989796-26594-3-git-send-email-t-kristo@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44002 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab2ENKDc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:03:32 -0400
In-Reply-To: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

With no driver handling DSP, if brought out of reset, it stays
active and does not assert standby. This leads to IVAHD powerdomain not
transitioning and hence preventing chip retention.

This patch is no longer needed once Paul's powerdomain fixes are merged:
   http://marc.info/?l=linux-omap&m=133040749621183&w=2

Just provided for testing purposes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6abc757..fd305bc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1160,6 +1160,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_dsp_irqs,
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
-- 
1.7.4.1

