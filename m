From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/9] ARM: OMAP3: hwmod data: add DSS->L3 interconnect for
 3430ES1
Date: Tue, 28 Feb 2012 04:10:53 -0700
Message-ID: <20120228111052.808.13430.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35173 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965152Ab2B1LLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:34 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP3 hwmod data was missing a DSS->L3 interconnect link for the
OMAP3430 ES1 DSS hwmod.  Since the hwmod code and data is being modified
to register interfaces rather than hwmods, this would result in the DSS hwmod
not being registered correctly on OMAP3430ES1.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index a432618..48b6a88 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -133,6 +133,12 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
 };
 
 /* DSS -> l3 */
+static struct omap_hwmod_ocp_if omap3430es1_dss__l3 = {
+	.master		= &omap3430es1_dss_core_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
 	.master		= &omap3xxx_dss_core_hwmod,
 	.slave		= &omap3xxx_l3_main_hwmod,
@@ -1400,6 +1406,7 @@ static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
 /* dss master ports */
 static struct omap_hwmod_ocp_if *omap3xxx_dss_masters[] = {
 	&omap3xxx_dss__l3,
+	&omap3430es1_dss__l3,
 };
 
 /* l4_core -> dss */


