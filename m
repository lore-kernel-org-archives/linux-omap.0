From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/9] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Thu, 03 Dec 2009 06:45:44 -0700
Message-ID: <20091203134543.16229.85418.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48973 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbZLCNwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:24 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

MPU power domain bank 0 bits are displayed in position of bank 1
in PWRSTS and PREPWRSTS registers. So read them from correct
position

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c             |    6 ++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |    1 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    5 ++++-
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 47d5768..26b3f3e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -983,6 +983,9 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
+	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
+		bank = 1;
+
 	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
@@ -1030,6 +1033,9 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
+	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
+		bank = 1;
+
 	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index fd09b08..588f7e0 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -190,6 +190,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	.wkdep_srcs	  = mpu_34xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.flags		  = PWRDM_HAS_MPU_QUIRK,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 56bb1b9..0b96005 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -42,7 +42,10 @@
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
-
+#define PWRDM_HAS_MPU_QUIRK	(1 << 1) /* MPU pwr domain has MEM bank 0 bits
+					  * in MEM bank 1 position. This is
+					  * true for OMAP3430
+					  */
 
 /*
  * Number of memory banks that are power-controllable.	On OMAP3430, the


