From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Fix GPMC remap for devices using an offset
Date: Mon, 21 Apr 2014 17:54:40 -0700
Message-ID: <1398128080-18903-3-git-send-email-tony@atomide.com>
References: <1398128080-18903-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12564 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754832AbaDVAyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 20:54:45 -0400
In-Reply-To: <1398128080-18903-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Pekon Gupta <pekon@ti.com>

At least the smc91x driver expects the device to be at 0x300
offset from bus base address. This does not work currently
for GPMC when booted in device tree mode as it attempts to
remap the the allocated GPMC partition to the address
configured by the device tree plus the device offset.

Note that this works just fine when booted with legacy mode.

Let's fix the issue by just ignoring any device specific
offset while remapping. And let's make sure the remap
address confirms to the GPMC 16MB minimum granularity
as listed in the TRM for GPMC_CONFIG7 BASEADDRESS bits.

Otherwise we can get something like this:

omap-gpmc 6e000000.gpmc: cannot remap GPMC CS 1 to 0x01000300

Cc: Pekon Gupta <pekon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 84e57e6..9fe8c94 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -527,6 +527,14 @@ static int gpmc_cs_remap(int cs, u32 base)
 		pr_err("%s: requested chip-select is disabled\n", __func__);
 		return -ENODEV;
 	}
+
+	/*
+	 * Make sure we ignore any device offsets from the GPMC partition
+	 * allocated for the chip select and that the new base confirms
+	 * to the GPMC 16MB minimum granularity.
+	 */ 
+	base &= ~(SZ_16M - 1);
+
 	gpmc_cs_get_memconf(cs, &old_base, &size);
 	if (base == old_base)
 		return 0;
-- 
1.8.1.1

