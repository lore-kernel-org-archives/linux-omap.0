From: Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Tue, 1 Nov 2011 09:40:52 -0600
Message-ID: <1320162052-32276-2-git-send-email-vishalm@ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40187 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab1KAUhd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Nov 2011 16:37:33 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA1KbWZc015638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:32 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA1KbWEb029970
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:32 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA1KbWE0004302
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:32 -0500 (CDT)
In-Reply-To: <1320162052-32276-1-git-send-email-vishalm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishal Mahaveer <vishalm@ti.com>

omap4_clk32kg regulator is used by connectivity (WLAN/BT/GPS) chip on
omap4 platforms.
Set always_on flag to true for connectivity chip to operate.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 5224357..8910cea 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -270,6 +270,7 @@ static struct regulator_init_data omap4_vusb_idata = {
 static struct regulator_init_data omap4_clk32kg_idata = {
 	.constraints = {
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+		.always_on		= true,
 	},
 };
 
-- 
1.7.0.4

