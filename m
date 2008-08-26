From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: [PATCH 2/2]OMAP3 NAND: Enable support for nand driver on OMAP3430
Date: Tue, 26 Aug 2008 15:48:45 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD517C24@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59741 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbYHZKSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 06:18:55 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QAIkuP025218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 05:18:54 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7QAIkLv018699
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 15:48:46 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

This patch enables the support for nand driver on 3430sdp

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig  |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletion(-)

Index : linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
=====================================================================================
--- a/arch/arm/configs/omap_3430sdp_defconfig 2008-08-06 13:03:38.859241000 +0530
+++ b/arch/arm/configs/omap_3430sdp_defconfig 2008-08-05 16:02:20.037348000 +0530
@@ -493,7 +493,17 @@ CONFIG_MTD_OMAP_NOR=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_HWECC=y
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 # CONFIG_MTD_ONENAND_GENERIC is not set