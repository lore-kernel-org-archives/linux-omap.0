From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] OMAP4: hwmod: Add names for DMIC memory address space
Date: Tue, 22 Nov 2011 16:01:56 +0200
Message-ID: <1321970520-8909-2-git-send-email-peter.ujfalusi@ti.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36752 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755647Ab1KVOCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 09:02:21 -0500
Received: by mail-ey0-f182.google.com with SMTP id 10so219396eyd.41
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 06:02:19 -0800 (PST)
In-Reply-To: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
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

