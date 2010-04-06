From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH 2/5] OMAP: Convert the sdram-*.h timings to use the SDRAM timing macros
Date: Tue,  6 Apr 2010 09:51:05 -0700
Message-ID: <1270572668-2336-3-git-send-email-lwalkera@ieee.org>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og110.obsmtp.com ([64.18.2.173]:46253 "HELO
	exprod7og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757215Ab0DFRBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:01:55 -0400
In-Reply-To: <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>


Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
---
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   44 +++++++++++------
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   44 +++++++++++------
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |   52 ++++++++++++--------
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   50 ++++++++++++-------
 4 files changed, 119 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
index 8bfaf34..2e6a606 100644
--- a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
+++ b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
@@ -17,31 +17,43 @@
 static struct omap_sdrc_params h8mbx00u0mer0em_sdrc_params[] = {
 	[0] = {
 		.rate        = 200000000,
-		.actim_ctrla = 0xa2e1b4c6,
-		.actim_ctrlb = 0x0002131c,
-		.rfr_ctrl    = 0x0005e601,
-		.mr          = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(20) | ACTIM_TRC(11) | ACTIM_TRAS(8) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(1) | ACTIM_TXP(3) |
+			ACTIM_TXSR(28),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1510) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[1] = {
 		.rate        = 166000000,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr          = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(12) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(20),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[2] = {
 		.rate        = 100000000,
-		.actim_ctrla = 0x51912284,
-		.actim_ctrlb = 0x0002120e,
-		.rfr_ctrl    = 0x0002d101,
-		.mr          = 0x00000022,
+		.actim_ctrla = ACTIM_TRFC(10) | ACTIM_TRC(6) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(4),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(14),
+		.rfr_ctrl    = RFR_CTRL_ARCV(721) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(2) | MR_BL(2),
 	},
 	[3] = {
 		.rate        = 83000000,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr          = 0x00000022,
+		.actim_ctrla = ACTIM_TRFC(6) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(10),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(2) | MR_BL(2),
 	},
 	[4] = {
 		.rate        = 0
diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
index a391b49..00accf2 100644
--- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -21,31 +21,43 @@
 static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] = {
 	[0] = {
 		.rate	     = 166000000,
-		.actim_ctrla = 0x9a9db4c6,
-		.actim_ctrlb = 0x00011217,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(19) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(23),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[1] = {
 		.rate	     = 165941176,
-		.actim_ctrla = 0x9a9db4c6,
-		.actim_ctrlb = 0x00011217,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(19) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3)   | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(1)  | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(23),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[2] = {
 		.rate	     = 83000000,
-		.actim_ctrla = 0x51512283,
-		.actim_ctrlb = 0x0001120c,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(10) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(12),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[3] = {
 		.rate	     = 82970588,
-		.actim_ctrla = 0x51512283,
-		.actim_ctrlb = 0x0001120c,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000032,
+		.actim_ctrla = ACTIM_TRFC(10) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(12),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[4] = {
 		.rate	     = 0
diff --git a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
index cd43529..394bfe7 100644
--- a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
+++ b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
@@ -16,32 +16,44 @@
 /* Numonyx  M65KXXXXAM */
 static struct omap_sdrc_params m65kxxxxam_sdrc_params[] = {
 	[0] = {
-		.rate		= 200000000,
-		.actim_ctrla	= 0xe321d4c6,
-		.actim_ctrlb	= 0x00022328,
-		.rfr_ctrl	= 0x0005e601,
-		.mr		= 0x00000032,
+		.rate        = 200000000,
+		.actim_ctrla = ACTIM_TRFC(28) | ACTIM_TRC(12) | ACTIM_TRAS(8) |
+			ACTIM_TRP(3) | ACTIM_TRCD(1) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(2) | ACTIM_TXP(3) |
+			ACTIM_TXSR(40),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1510) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[1] = {
-		.rate		= 166000000,
-		.actim_ctrla	= 0xba9dc485,
-		.actim_ctrlb	= 0x00022321,
-		.rfr_ctrl	= 0x0004dc01,
-		.mr		= 0x00000032,
+		.rate        = 166000000,
+		.actim_ctrla = ACTIM_TRFC(23) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(0) | ACTIM_TRRD(2) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(5),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(2) | ACTIM_TXP(3) |
+			ACTIM_TXSR(33),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[2] = {
-		.rate		= 133000000,
-		.actim_ctrla	= 0x9a19b485,
-		.actim_ctrlb	= 0x0002231b,
-		.rfr_ctrl	= 0x0003de01,
-		.mr		= 0x00000032,
+		.rate        = 133000000,
+		.actim_ctrla = ACTIM_TRFC(19) | ACTIM_TRC(8) | ACTIM_TRAS(6) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(5),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(2) | ACTIM_TXP(3) |
+			ACTIM_TXSR(27),
+		.rfr_ctrl    = RFR_CTRL_ARCV(990) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[3] = {
-		.rate		= 83000000,
-		.actim_ctrla	= 0x594ca242,
-		.actim_ctrlb	= 0x00022310,
-		.rfr_ctrl	= 0x00025501,
-		.mr		= 0x00000032,
+		.rate        = 83000000,
+		.actim_ctrla = ACTIM_TRFC(11) | ACTIM_TRC(5) | ACTIM_TRAS(3) |
+			ACTIM_TRP(1) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(1) |
+			ACTIM_TDAL(2),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(2) | ACTIM_TXP(3) |
+			ACTIM_TXSR(16),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[4] = {
 		.rate			= 0
diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 0e518a7..6cef229 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -19,32 +19,44 @@
 /* Qimonda HYB18M512160AF-6 */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 	[0] = {
-		.rate	     = 166000000,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
+		.rate        = 166000000,
+		.actim_ctrla = ACTIM_TRFC(12) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(20),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[1] = {
-		.rate	     = 165941176,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
+		.rate        = 165941176,
+		.actim_ctrla = ACTIM_TRFC(12) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(20),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
 	},
 	[2] = {
 		.rate	     = 83000000,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000022,
+		.actim_ctrla = ACTIM_TRFC(6) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(10),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(2) | MR_BL(2),
 	},
 	[3] = {
-		.rate	     = 82970588,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000022,
+		.rate        = 82970588,
+		.actim_ctrla = ACTIM_TRFC(6) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(2) | ACTIM_TXP(2) |
+			ACTIM_TXSR(10),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr          = MR_WBST(0) | MR_CASL(2) | MR_BL(2),
 	},
 	[4] = {
 		.rate	     = 0
-- 
1.6.3.3

