From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/7] musb: set 'extvbus' default value to zero
Date: Sun, 15 Nov 2009 14:29:37 +0530
Message-ID: <1258275578-1773-7-git-send-email-ajay.gupta@ti.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-4-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-5-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-6-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbZKOI7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:59:44 -0500
In-Reply-To: <1258275578-1773-6-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: felipe.balbi@nokia.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Default value of 'extvbus' is being set as '0' to maintain the
current programming state of all the musb boards.

This flag should be set to '1' for boards using external vbus
supply such as, OMAP3EVM Rev >=E.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
 arch/arm/mach-davinci/board-sffsdr.c        |    3 ++-
 arch/arm/mach-omap2/board-2430sdp.c         |    3 ++-
 arch/arm/mach-omap2/board-3430sdp.c         |    3 ++-
 arch/arm/mach-omap2/board-cm-t35.c          |    3 ++-
 arch/arm/mach-omap2/board-ldp.c             |    3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c     |    3 ++-
 arch/arm/mach-omap2/board-omap3evm.c        |    3 ++-
 arch/arm/mach-omap2/board-omap3pandora.c    |    3 ++-
 arch/arm/mach-omap2/board-overo.c           |    3 ++-
 arch/arm/mach-omap2/board-rx51.c            |    3 ++-
 13 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 31c5741..ed011ae 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -322,6 +322,7 @@ static struct spi_board_info dm355_evm_spi_info[] __initconst = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static __init void dm355_evm_init(void)
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 2c534f1..4ab8ab5 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -248,6 +248,7 @@ static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static __init void dm355_leopard_init(void)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 307520e..9e99882 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -443,6 +443,7 @@ static struct pcf857x_platform_data pcf_data_u18 = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 /* U35 - various I/O signals used to manage USB, CF, ATA, etc */
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 5dceeb0..c6c9b20 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -153,7 +153,8 @@ static struct davinci_uart_config uart_config __initdata = {
 /* musb board specific data */
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 0,	/* (power in mA)/2 */
-	.potpgt = 0	/* (potpgt in msec)/2 */
+	.potpgt = 0,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static void __init davinci_sffsdr_map_io(void)
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 03d3634..074941c 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -196,7 +196,8 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap_2430sdp_init(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index dde1a96..fd6fc56 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -486,7 +486,8 @@ static void enable_board_wakeup_source(void)
 }
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 5d7656c..134069c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -385,7 +385,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 0546c78..11526d6 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -376,7 +376,8 @@ static struct platform_device *ldp_devices[] __initdata = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init omap_ldp_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 683b468..2c970e3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -402,7 +402,8 @@ static void __init omap3beagle_flash_init(void)
 }
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index dad690f..0bcf909 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -378,7 +378,8 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index da97a0d..7d91ac4 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -389,7 +389,8 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d16c714..68c3f5f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -386,7 +386,8 @@ static struct platform_device *overo_devices[] __initdata = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 60c8f9f..6b41a53 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -57,7 +57,8 @@ static struct omap_board_config_kernel rx51_config[] = {
 };
 
 static struct musb_hdrc_board_data musb_bdata __initdata = {
-	.power = 50
+	.power = 50,
+	.extvbus = 0,
 };
 
 static void __init rx51_init_irq(void)
-- 
1.6.2.4

