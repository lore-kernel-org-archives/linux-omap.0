From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/19] OMAP3 PM: Defining .pwrsts_logic_ret field for core
	power domain structure
Date: Mon, 15 Feb 2010 18:24:47 -0700
Message-ID: <20100216012445.1101.91246.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57410 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab0BPB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:58 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch adds the flag .pwrsts_logic_ret info for the core power domain
in the associated powerdomain structure. This flag specifies the states
core domain logic can hit in event of the domain entering retention.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 186c013..bd87112 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -82,6 +82,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -98,6 +99,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {


