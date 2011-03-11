From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] omap2+: mux: Fix compile when CONFIG_OMAP_MUX is not
	selected
Date: Fri, 11 Mar 2011 12:34:17 -0800
Message-ID: <20110311203417.26901.26592.stgit@baageli.muru.com>
References: <20110311203317.26901.67180.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10962 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab1CKUeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 15:34:17 -0500
In-Reply-To: <20110311203317.26901.67180.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix compile when CONFIG_OMAP_MUX is not selected

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-cm-t35.c     |    2 ++
 arch/arm/mach-omap2/board-cm-t3517.c   |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 27bea54..71545c9 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -675,6 +675,7 @@ static void __init cm_t35_init_early(void)
 			     mt46h32m32lf6_sdrc_params);
 }
 
+#ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* nCS and IRQ for CM-T35 ethernet */
 	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE0),
@@ -772,6 +773,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+#endif
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 9da6e82..4c737e4 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -260,6 +260,7 @@ static void __init cm_t3517_init_early(void)
 	omap2_init_common_devices(NULL, NULL);
 }
 
+#ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* GPIO186 - Green LED */
 	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
@@ -285,6 +286,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+#endif
 
 static void __init cm_t3517_init(void)
 {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 728f27c..472a25b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -625,6 +625,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* nCS and IRQ for Devkit8000 ethernet */
 	OMAP3_MUX(GPMC_NCS6, OMAP_MUX_MODE0),
@@ -778,6 +779,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+#endif
 
 static void __init devkit8000_init(void)
 {

