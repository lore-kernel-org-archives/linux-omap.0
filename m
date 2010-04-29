From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] omap3: Fix 3630 mux errors
Date: Thu, 29 Apr 2010 12:57:45 +0530
Message-ID: <1272526065-29683-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58981 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289Ab0D3REY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:04:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Allen Pais <allen.pais@ti.com>, Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Allen Pais <allen.pais@ti.com>

The omap3630 has more mux signals than 34xx. The additional
pins exist in omap36xx_cbp_subset, but are not initialized
as the superset is missing these offsets. This causes the
following errors during the boot:

mux: Unknown ball offset 0x5e
mux: Unknown ball offset 0x60
mux: Unknown ball offset 0x62
mux: Unknown ball offset 0x64
mux: Unknown ball offset 0x66
mux: Unknown ball offset 0x68
mux: Unknown ball offset 0x6a
mux: Unknown ball offset 0x6c
mux: Unknown ball offset 0x90
mux: Unknown ball offset 0x7e
mux: Unknown ball offset 0x92
mux: Unknown ball offset 0x94
mux: Unknown ball offset 0x9c
mux: Unknown ball offset 0x18a
mux: Unknown ball offset 0x18c
mux: Unknown ball offset 0xa1e
mux: Unknown ball offset 0x9ee
mux: Unknown ball offset 0x9f2
mux: Unknown ball offset 0xa20
mux: Unknown ball offset 0x9f0
mux: Unknown ball offset 0x574
mux: Unknown ball offset 0x576
mux: Unknown ball offset 0x588
mux: Unknown ball offset 0x58a
mux: Unknown ball offset 0x58c
mux: Unknown ball offset 0x58e
mux: Unknown ball offset 0x590
mux: Unknown ball offset 0x578
mux: Unknown ball offset 0x57a
mux: Unknown ball offset 0x57c
mux: Unknown ball offset 0x57e
mux: Unknown ball offset 0x580
mux: Unknown ball offset 0x582
mux: Unknown ball offset 0x584
mux: Unknown ball offset 0x586
mux: Unknown ball offset 0x570
mux: Unknown ball offset 0x572
mux: Unknown ball offset 0x40
mux: Unknown ball offset 0x0
mux: Unknown ball offset 0x2
mux: Unknown ball offset 0x14
mux: Unknown ball offset 0x16
mux: Unknown ball offset 0x18
mux: Unknown ball offset 0x1a
mux: Unknown ball offset 0x1c
mux: Unknown ball offset 0x1e
mux: Unknown ball offset 0x20
mux: Unknown ball offset 0x22
mux: Unknown ball offset 0x24
mux: Unknown ball offset 0x26
mux: Unknown ball offset 0x4
mux: Unknown ball offset 0x28
mux: Unknown ball offset 0x2a
mux: Unknown ball offset 0x2c
mux: Unknown ball offset 0x2e
mux: Unknown ball offset 0x30
mux: Unknown ball offset 0x32
mux: Unknown ball offset 0x34
mux: Unknown ball offset 0x36
mux: Unknown ball offset 0x38
mux: Unknown ball offset 0x3a
mux: Unknown ball offset 0x6
mux: Unknown ball offset 0x3c
mux: Unknown ball offset 0x3e
mux: Unknown ball offset 0x8
mux: Unknown ball offset 0xa
mux: Unknown ball offset 0xc
mux: Unknown ball offset 0xe
mux: Unknown ball offset 0x10
mux: Unknown ball offset 0x12
mux: Unknown ball offset 0x59e
mux: Unknown ball offset 0x5a0
mux: Unknown ball offset 0x5a2
mux: Unknown ball offset 0x5a4
mux: Unknown ball offset 0x42
mux: Unknown ball offset 0x44
mux: Unknown ball offset 0x46
mux: Unknown ball offset 0x48
mux: Unknown ball offset 0x59a
mux: Unknown ball offset 0x596
mux: Unknown ball offset 0x592
mux: Unknown ball offset 0x594
mux: Unknown ball offset 0x598
mux: Unknown ball offset 0x59c
mux: Unknown ball offset 0x9d4

Fix this by adding the missing offsets to omap3 superset.
Note that additionally the uninitialized pins need to be
skipped on 34xx.

Reported-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Allen Pais <allen.pais@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mux34xx.c |  256 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 256 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 07aa7b3..4a28e6f 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -696,6 +696,262 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 	_OMAP3_MUXENTRY(SAD2D_MCAD36, 0,
 		NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL),
+
+	_OMAP3_MUXENTRY(GPMC_D0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_D7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_NADV_ALE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_NCS0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_NOE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_NWE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_WAIT0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(I2C1_SCL, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(I2C1_SDA, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_RTCK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TCK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TDI, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TDO, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(JTAG_TMS_TMSC, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A10, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A12, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A13, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A14, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A8, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_A9, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_BA0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_BA1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_CLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D10, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D12, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D13, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D14, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D15, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D16, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D17, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D18, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D19, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D20, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D21, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D22, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D23, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D24, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D25, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D26, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D27, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D28, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D29, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D30, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D31, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D8, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_D9, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DM3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_DQS3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCAS, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCS0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NCS1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NRAS, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDRC_NWE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SYS_32K, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-- 
1.6.0.4

