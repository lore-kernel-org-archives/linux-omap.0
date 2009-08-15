From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/13] OMAP clock: associate MPU clocks with the mpu_clkdm
Date: Sat, 15 Aug 2009 14:20:01 +0300
Message-ID: <20090815111953.7384.75804.stgit@localhost.localdomain>
References: <20090815111704.7384.31564.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32965 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZHOL0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 07:26:14 -0400
In-Reply-To: <20090815111704.7384.31564.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org

All MPU-related clocks should be in the mpu_clkdm.  This is needed for the
upcoming omap_hwmod patches, which needs to know the clockdomain that arm_fck
is in.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 53bf008..575478a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1020,6 +1020,7 @@ static struct clk arm_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
+	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 


