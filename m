From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/8] OMAP3: clock: add clockdomains for UART1 & 2
Date: Thu, 17 Dec 2009 21:20:20 -0700
Message-ID: <20091218042019.27280.13461.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40405 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZLREVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 23:21:50 -0500
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

UART1 & 2 were missing clockdomains resulting in broken omap_hwmod
init for these devices.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 8bdcc9c..c60b19a 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -1500,6 +1500,7 @@ static struct clk uart2_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1509,6 +1510,7 @@ static struct clk uart1_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 


