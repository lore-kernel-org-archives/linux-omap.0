From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/13] OMAP: SDRC: Add several new register definitions
Date: Sat, 15 Aug 2009 14:19:38 +0300
Message-ID: <20090815111843.7384.7271.stgit@localhost.localdomain>
References: <20090815111704.7384.31564.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32949 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZHOL0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 07:26:13 -0400
In-Reply-To: <20090815111704.7384.31564.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Add missing SDRC register offset macros.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[paul@pwsan.com: added commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/mach/sdrc.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 0be18e4..8fff90a 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -21,19 +21,28 @@
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
 #define SDRC_MR_1		0x0B4
+#define SDRC_EMR2_1		0x0BC
 #define SDRC_ACTIM_CTRL_A_1	0x0C4
 #define SDRC_ACTIM_CTRL_B_1	0x0C8
 #define SDRC_RFR_CTRL_1		0x0D4
+#define SDRC_MANUAL_1		0x0D8
 
 /*
  * These values represent the number of memory clock cycles between


