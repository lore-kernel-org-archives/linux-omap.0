From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 3/4] TEMP: ARM: OMAP4: hwmod_data: Do not get DSP out of reset at boot time
Date: Wed, 29 Feb 2012 17:25:05 +0200
Message-ID: <1330529106-10423-4-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34363 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031111Ab2B2PZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 10:25:36 -0500
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
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
index ef0524c..81d90da 100644
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

