From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/5] OMAP4: powerdomain: l4per pwrdm does not support OFF
Date: Mon, 13 Dec 2010 22:49:27 +0100
Message-ID: <1292276969-29733-4-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab0LMVuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 16:50:51 -0500
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

The l4per power domain in ES2.0 does support only RET and ON states.
The previous ES1.0 HW database was wrong and thus fixed on ES2.
Change the pwrsts field to reflect that.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 5fdf485..cec9c09 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -285,7 +285,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
-- 
1.7.0.4

