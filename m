From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
Date: Wed, 12 Nov 2008 13:07:35 -0600
Message-ID: <200811121307.35591.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58011 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbYKLTHl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 14:07:41 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mACJ7a1i006888
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 13:07:41 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id mACJ7Zgh015758
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 13:07:35 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Lower i2c bus 1 speed to 400KHz for LDP.

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

