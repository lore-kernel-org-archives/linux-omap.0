From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 06/13] OMAP4: hwmod: Naming of address space
Date: Thu, 24 Feb 2011 15:16:50 +0530
Message-ID: <1298540817-15874-7-git-send-email-kishon@ti.com>
References: <1298540817-15874-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34299 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100Ab1BXJwe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 04:52:34 -0500
In-Reply-To: <1298540817-15874-1-git-send-email-kishon@ti.com>
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
index 79a8601..673b011 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
+#include <plat/mcbsp.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2737,6 +2738,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
 static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 	.name	= "mcbsp",
 	.sysc	= &omap44xx_mcbsp_sysc,
+	.rev	= MCBSP_CONFIG_TYPE4,
 };
 
 /* mcbsp1 */
@@ -2752,6 +2754,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40122000,
 		.pa_end		= 0x401220ff,
 		.flags		= ADDR_TYPE_RT
@@ -2770,6 +2773,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49022000,
 		.pa_end		= 0x490220ff,
 		.flags		= ADDR_TYPE_RT
@@ -2823,6 +2827,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40124000,
 		.pa_end		= 0x401240ff,
 		.flags		= ADDR_TYPE_RT
@@ -2841,6 +2846,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49024000,
 		.pa_end		= 0x490240ff,
 		.flags		= ADDR_TYPE_RT
@@ -2894,6 +2900,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40126000,
 		.pa_end		= 0x401260ff,
 		.flags		= ADDR_TYPE_RT
@@ -2912,6 +2919,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
 
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
index 5f25ae5..62bd073 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1812,6 +1812,10 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
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

