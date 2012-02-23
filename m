From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of reset
Date: Thu, 23 Feb 2012 15:21:59 +0200
Message-ID: <1330003320-17400-6-git-send-email-t-kristo@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2BWNWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 08:22:25 -0500
In-Reply-To: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

With no driver handling DSP/TESLA, if brought out of reset, it stays
active and does not assert standby.

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

