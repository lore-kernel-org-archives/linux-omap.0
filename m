From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 2/2] OMAP3 SDRC: Add rounded rates for devices using the
	Qimonda SDRAM
Date: Thu, 14 May 2009 13:50:31 -0600
Message-ID: <20090514195021.20623.63234.stgit@localhost.localdomain>
References: <20090514194728.20623.60039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43626 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZENTwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:52:34 -0400
In-Reply-To: <20090514194728.20623.60039.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

The 3430SDPs, many of which use Qimonda SDRAM, are finally using
bootloaders that program rounded rates for DPLL3.  Since no SDRAM
memory timings are defined for the rounded rates, the initial SDRC
reprogram during init fails.  Add in the correct timings here.

Problem reported by Kevin Hilman <khilman@deeprootsystems.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 8b6f929..3751d29 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -19,20 +19,34 @@
 /* Qimonda HYB18M512160AF-6 */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 	[0] = {
-		.rate	     = 165941176,
+		.rate	     = 166000000,
 		.actim_ctrla = 0x629db4c6,
 		.actim_ctrlb = 0x00012214,
 		.rfr_ctrl    = 0x0004dc01,
 		.mr	     = 0x00000032,
 	},
 	[1] = {
+		.rate	     = 165941176,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[2] = {
+		.rate	     = 83000000,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000022,
+	},
+	[3] = {
 		.rate	     = 82970588,
 		.actim_ctrla = 0x31512283,
 		.actim_ctrlb = 0x0001220a,
 		.rfr_ctrl    = 0x00025501,
 		.mr	     = 0x00000022,
 	},
-	[2] = {
+	[4] = {
 		.rate	     = 0
 	},
 };


