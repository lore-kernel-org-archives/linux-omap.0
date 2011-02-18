From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 06/13] OMAP4: hwmod: Naming of address space
Date: Fri, 18 Feb 2011 19:52:21 +0530
Message-ID: <1298038948-19871-7-git-send-email-kishon@ti.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758237Ab1BRO2Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 09:28:16 -0500
In-Reply-To: <1298038948-19871-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Added a name to address space belonging to SDMA and MPU facilitating
the driver to get the address space info by name. Added a revision
member inorder to facilitate the driver to differentiate between
mcbsp in different omap.
Also added a platform_get_irq in probe to get irq number by index since
from OMAP4, there will be a single irq line.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h    |    1 +
 arch/arm/plat-omap/mcbsp.c                 |    4 ++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 84e795c..4ae8df3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,7 @@
 #include <plat/cpu.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
+#include <plat/mcbsp.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2736,6 +2737,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
 static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 	.name	= "mcbsp",
 	.sysc	= &omap44xx_mcbsp_sysc,
+	.rev	= MCBSP_CONFIG_TYPE4,
 };
 
 /* mcbsp1 */
@@ -2751,6 +2753,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40122000,
 		.pa_end		= 0x401220ff,
 		.flags		= ADDR_TYPE_RT
@@ -2769,6 +2772,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49022000,
 		.pa_end		= 0x490220ff,
 		.flags		= ADDR_TYPE_RT
@@ -2822,6 +2826,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40124000,
 		.pa_end		= 0x401240ff,
 		.flags		= ADDR_TYPE_RT
@@ -2840,6 +2845,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49024000,
 		.pa_end		= 0x490240ff,
 		.flags		= ADDR_TYPE_RT
@@ -2893,6 +2899,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40126000,
 		.pa_end		= 0x401260ff,
 		.flags		= ADDR_TYPE_RT
@@ -2911,6 +2918,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp3_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49026000,
 		.pa_end		= 0x490260ff,
 		.flags		= ADDR_TYPE_RT
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index f084b6a..afcbb7b 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -39,6 +39,7 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 
 #define MCBSP_CONFIG_TYPE2	0x2
 #define MCBSP_CONFIG_TYPE3	0x3
+#define MCBSP_CONFIG_TYPE4	0x4
 
 #define OMAP7XX_MCBSP1_BASE	0xfffb1000
 #define OMAP7XX_MCBSP2_BASE	0xfffb1800
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 1b45446..57257e8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1839,6 +1839,10 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->tx_irq = platform_get_irq_byname(pdev, "tx");
 	mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
 
+	/* From OMAP4 there will be a single irq line */
+	if (mcbsp->tx_irq == -ENXIO)
+		mcbsp->tx_irq = platform_get_irq(pdev, 0);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
 		dev_err(&pdev->dev, "%s:mcbsp%d has invalid rx DMA channel\n",
-- 
1.7.0.4

