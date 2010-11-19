From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
Date: Fri, 19 Nov 2010 23:01:06 +0530
Message-ID: <1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53786 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949Ab0KSRb2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:31:28 -0500
In-Reply-To: <1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The AXI protocol specifies that the write response can only
be sent back to an AXI master when the last write data has been
accepted. This optimization enables the PL310 to send the write
response of certain write transactions as soon as the store buffer
accepts the write address. This behavior is not compatible with
the AXI protocol and is disabled by default. You enable this
optimization by setting the Early BRESP Enable bit in the
Auxiliary Control Register (bit [30]).

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2006da1..e7a9b7f 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -82,7 +82,8 @@ static int __init omap_l2_cache_init(void)
 		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
-			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT));
+			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
 	}
 	if (omap_rev() != OMAP4430_REV_ES1_0)
 		omap_smc1(0x109, aux_ctrl);
-- 
1.6.0.4

