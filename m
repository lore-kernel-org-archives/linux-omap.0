From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/11] OMAP: SDRC: Add several new register definitions
Date: Thu, 25 Jun 2009 09:41:54 -0700
Message-ID: <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:35146 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZFYQmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:42:22 -0400
Received: by pzk27 with SMTP id 27so1461235pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:42:24 -0700 (PDT)
In-Reply-To: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/mach/sdrc.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index adc7352..7cc6568 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -21,15 +21,28 @@
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
 
 #define SDRC_SYSCONFIG		0x010
+#define SDRC_CS_CFG		0x040
+#define SDRC_SHARING		0x044
+#define SDRC_ERR_TYPE		0x04C
 #define SDRC_DLLA_CTRL		0x060
 #define SDRC_DLLA_STATUS	0x064
 #define SDRC_DLLB_CTRL		0x068
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
+#define SDRC_MCFG_0		0x080
 #define SDRC_MR_0		0x084
+#define SDRC_EMR2_0		0x08c
 #define SDRC_ACTIM_CTRL_A_0	0x09c
 #define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
+#define SDRC_MANUAL_0		0x0a8
+#define SDRC_MCFG_1		0x0B0
+#define SDRC_MR_1		0x0B4
+#define SDRC_EMR2_1		0x0BC
+#define SDRC_ACTIM_CTRL_A_1	0x0C4
+#define SDRC_ACTIM_CTRL_B_1	0x0C8
+#define SDRC_RFR_CTRL_1		0x0D4
+#define SDRC_MANUAL_1		0x0D8
 
 /*
  * These values represent the number of memory clock cycles between
-- 
1.6.3.2

