From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
Date: Wed, 12 Nov 2008 14:21:38 -0600
Message-ID: <200811121421.38438.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYKLUVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 15:21:45 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mACKLdiI019768
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 14:21:44 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id mACKLcR2013891
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 14:21:39 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Resending patch with more descriptive comment.

Lower i2c bus 1 speed to 400KHz for LDP.
At 2600KHz i2c reads from twl4030 keypad driver are returning 
incorrect data. Reason unknown. Lowering bus speed as temporary 
fix to get LDP keypad working.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d889ce8..b2e8c9c 100755
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -797,7 +797,7 @@ static struct i2c_board_info __initdata ldp_i2c_boardinfo_2[] = {
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
+	omap_register_i2c_bus(1, 400, ldp_i2c_boardinfo,
 			ARRAY_SIZE(ldp_i2c_boardinfo));
 	omap_register_i2c_bus(2, 100, ldp_i2c_boardinfo_2,
 			ARRAY_SIZE(ldp_i2c_boardinfo_2));
-- 
1.5.4.1

