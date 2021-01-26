Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FEC433E0
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 12:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB732255F
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbhAZMXI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:23:08 -0500
Received: from muru.com ([72.249.23.125]:53300 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404643AbhAZMWp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 26 Jan 2021 07:22:45 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BD22C8057;
        Tue, 26 Jan 2021 12:22:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: omap2plus_defconfig: Update for moved options
Date:   Tue, 26 Jan 2021 14:21:57 +0200
Message-Id: <20210126122158.33761-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Update for the following moved options to make applying defconfig
related patches easier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -158,9 +158,9 @@ CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=y
 CONFIG_ZRAM=m
@@ -202,11 +202,11 @@ CONFIG_TI_CPSW_SWITCHDEV=y
 CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_DP83848_PHY=y
-CONFIG_DP83867_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_DP83848_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
@@ -517,14 +517,14 @@ CONFIG_IIO=m
 CONFIG_IIO_SW_DEVICE=m
 CONFIG_IIO_SW_TRIGGER=m
 CONFIG_IIO_ST_ACCEL_3AXIS=m
+CONFIG_KXCJK1013=m
 CONFIG_CPCAP_ADC=m
 CONFIG_INA2XX_ADC=m
 CONFIG_TI_AM335X_ADC=m
 CONFIG_TWL4030_MADC=m
 CONFIG_SENSORS_ISL29028=m
-CONFIG_BMP280=m
-CONFIG_KXCJK1013=m
 CONFIG_AK8975=m
+CONFIG_BMP280=m
 CONFIG_PWM=y
 CONFIG_PWM_OMAP_DMTIMER=m
 CONFIG_PWM_TIECAP=m
-- 
2.30.0
