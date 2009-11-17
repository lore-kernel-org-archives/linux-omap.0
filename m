From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/8] musb: set 'extvbus = 0' for OMAP3 boards
Date: Tue, 17 Nov 2009 20:39:54 +0530
Message-ID: <1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-6-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbZKQPKd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 10:10:33 -0500
In-Reply-To: <1258470596-24321-6-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Default value of 'extvbus' is being set as '0' to maintain the
current programming state of all OMAP3 musb boards.

This flag should be set to '1' for boards using external vbus
supply such as, OMAP3EVM Rev >=E.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    1 +
 arch/arm/mach-omap2/board-3430sdp.c      |    1 +
 arch/arm/mach-omap2/board-ldp.c          |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c     |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c |    1 +
 arch/arm/mach-omap2/board-overo.c        |    1 +
 arch/arm/mach-omap2/board-rx51.c         |    1 +
 8 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 970dcab..0a2abf1 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -197,6 +197,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap_2430sdp_init(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 85cd24f..8dbb03a 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -488,6 +488,7 @@ static void enable_board_wakeup_source(void)
 /* musb board specific details */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap_3430sdp_init(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index a8338a4..dfee4c5 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -377,6 +377,7 @@ static struct platform_device *ldp_devices[] __initdata = {
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap_ldp_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 113bcfe..34ec334 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -404,6 +404,7 @@ static void __init omap3beagle_flash_init(void)
 /* musb board specific details */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap3_beagle_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 9e2656a..0066bee 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -301,6 +301,7 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 /* musb board specific details */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap3_evm_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 9bcd324..bf387b8 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -391,6 +391,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 /* musb board specific details */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap3pandora_init(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e2acb91..d53c61d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -388,6 +388,7 @@ static struct platform_device *overo_devices[] __initdata = {
 /* musb board specific details */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init overo_init(void)
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 839d7a8..1b2ece0 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -56,6 +56,7 @@ static struct omap_board_config_kernel rx51_config[] = {
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init rx51_init_irq(void)
-- 
1.6.2.4

