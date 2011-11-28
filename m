From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address space
Date: Mon, 28 Nov 2011 15:45:39 +0200
Message-ID: <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36093 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab1K1NqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 08:46:10 -0500
Received: by faao26 with SMTP id o26so202849faa.23
        for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 05:46:04 -0800 (PST)
In-Reply-To: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

To be able to get the memory resources by name from
the DMIC driver (for MPU and for DMA).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7695e5d..8b75c60 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1028,6 +1028,7 @@ static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x4012e000,
 		.pa_end		= 0x4012e07f,
 		.flags		= ADDR_TYPE_RT
@@ -1046,6 +1047,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
 
 static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x4902e000,
 		.pa_end		= 0x4902e07f,
 		.flags		= ADDR_TYPE_RT
-- 
1.7.8.rc3

