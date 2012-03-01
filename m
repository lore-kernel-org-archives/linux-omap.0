From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Fix build error when only ARCH_OMAP2/3 or
 4 is selected
Date: Thu, 01 Mar 2012 09:42:16 -0800
Message-ID: <20120301174216.12471.75885.stgit@kaulin.local>
References: <20120301174037.12471.72457.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab2CARmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 12:42:19 -0500
In-Reply-To: <20120301174037.12471.72457.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we'll get undefined reference to `gic_of_init' or
undefined reference to `omap_intc_of_init'.

This was caused by commit fbf75da733e82bb17a01e1b907b0e40d9c028823
(ARM: OMAP2+: board-generic: Use of_irq_init API).

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 12f4c5f..25d195f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -25,6 +25,13 @@
 #include "common.h"
 #include "common-board-devices.h"
 
+#if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
+#define omap_intc_of_init	NULL
+#endif
+#ifndef CONFIG_ARCH_OMAP4
+#define gic_of_init		NULL
+#endif
+
 static struct of_device_id irq_match[] __initdata = {
 	{ .compatible = "ti,omap2-intc", .data = omap_intc_of_init, },
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },

