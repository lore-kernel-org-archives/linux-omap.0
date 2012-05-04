From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/3] ARM: OMAP4: VC: fix I2C timing
Date: Fri, 4 May 2012 16:57:20 +0300
Message-ID: <1336139842-845-2-git-send-email-t-kristo@ti.com>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32784 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757372Ab2EDN5e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 09:57:34 -0400
In-Reply-To: <1336139842-845-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Current I2C timing parameters do not work with Panda board at least.
Parameters updated based on TI recommendation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 1fd976e..a731400 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -585,7 +585,9 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 	omap4_set_timings(voltdm, true);
 
 	/* XXX These are magic numbers and do not belong! */
-	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
+	vc_val = (0x28 << OMAP4430_SCLL_SHIFT | 0x2c << OMAP4430_SCLH_SHIFT);
+	vc_val |= (0x0b << OMAP4430_HSSCLL_SHIFT);
+	vc_val |= (0x0 << OMAP4430_HSSCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
 }
 
-- 
1.7.4.1

