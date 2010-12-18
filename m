From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Fri, 17 Dec 2010 19:05:21 -0800
Message-ID: <20101218030521.10251.89993.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35076 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab0LRDFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:33 -0500
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Raghuveer Murthy <raghuveer.murthy@ti.com>

From: Raghuveer Murthy <raghuveer.murthy@ti.com>

This patch adds omap_reserve functionality to board-omap4panda.c.
Helps in the reserving boot time memory in SDRAM, used here for
framebuffer allocation.

This patch is in similar lines to commit id 71ee7dad9b6991, from
Russell king

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 38f942b..9f49e23 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -407,6 +407,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.map_io		= omap4_panda_map_io,
+	.reserve	= omap_reserve,
 	.init_irq	= omap4_panda_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap_timer,

