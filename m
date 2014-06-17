From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control setting
Date: Tue, 17 Jun 2014 16:04:51 +0530
Message-ID: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaFQKhn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 06:37:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>

ROM code on AM437x does not support writing to L2C-310 power control
register. The L2C driver, however, tries writing to this register for
all revisions >= r3p0.

This leads to a warning dump on boot which leads most users to believe
that L2 cache is non-functional.

Since the problem is understood, and cannot be addressed through software,
replace the warning with a pr_info() while maintaining the WARN_ON() for
other truly unexpected scenarios.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 326cd98..9139729 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -188,6 +188,10 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 		smc_op = OMAP4_MON_L2X0_PREFETCH_INDEX;
 		break;
 
+	case L310_POWER_CTRL:
+		pr_info_once("OMAP L2C310: ROM does not support power control setting\n");
+		return;
+
 	default:
 		WARN_ONCE(1, "OMAP L2C310: ignoring write to reg 0x%x\n", reg);
 		return;
-- 
1.7.10.1

