From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/4] omap: Enable GPMC clock in gpmc_init
Date: Wed, 20 Jan 2010 18:08:27 -0800
Message-ID: <20100121020827.GJ23467@atomide.com>
References: <20100120212248.25335.55761.stgit@baageli.muru.com>
 <20100120212343.25335.73402.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61424 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0AUCIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 21:08:17 -0500
Content-Disposition: inline
In-Reply-To: <20100120212343.25335.73402.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's one more fix.

Tony

--MfFXiAuoTsnnDAfZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpmc-clock.patch"

>From 1daa8c1d75876f690ed8d3f13c806034af5984eb Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Wed, 20 Jan 2010 22:39:29 +0000
Subject: [PATCH] omap: Enable GPMC clock in gpmc_init

Don't assume that gpmc_l3_clk is on, enable it before touching
configuration registers.

Note that the current code assumes that this clock is always
enabled. We are already setting smart idle and L3 autogating
for GPMC clock in gpmc_init.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd8cb59..3f1334f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -534,6 +534,8 @@ void __init gpmc_init(void)
 		BUG();
 	}
 
+	clk_enable(gpmc_l3_clk);
+
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 	/* Set smart idle mode and automatic L3 clock gating */

--MfFXiAuoTsnnDAfZ--
