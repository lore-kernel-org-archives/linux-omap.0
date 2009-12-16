From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [rfc/rft/patch-v2.6.32-omap1+ 2/2] arm: omap: add missing
	__initdata to omap_board_config_kernel
Date: Thu, 17 Dec 2009 00:41:44 +0100
Message-ID: <20091216234144.GA11702@localhost.localdomain>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com> <1261000355-2174-3-git-send-email-felipe.balbi@nokia.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.76.43]:59892 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965210AbZLPXCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 18:02:24 -0500
Content-Disposition: inline
In-Reply-To: <1261000355-2174-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <kjh@hilman.org>

On Wed, Dec 16, 2009 at 11:52:35PM +0200, Felipe Balbi wrote:
> we still need to get rid of the OMAP_TAG_LCD, but while
> it's still there, let's kill the section mismatches.

Hmm, couldn't we just simply remove all empty declarations first? As data section
is zeroed it should not cause any harm. Anyway, patch bellow is entirely untested
and posted for your convenience only :-)

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1195a3..bea32cf 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -57,9 +57,6 @@ static struct omap_usb_config generic1610_usb_config __initdata = {
 };
 #endif
 
-static struct omap_board_config_kernel generic_config[] __initdata = {
-};
-
 static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -80,9 +77,6 @@ static void __init omap_generic_init(void)
 		omap_usb_init(&generic1610_usb_config);
 	}
 #endif
-
-	omap_board_config = generic_config;
-	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 1691835..5a95391 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -150,9 +150,6 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_board_config_kernel voiceblue_config[] = {
-};
-
 static void __init voiceblue_init_irq(void)
 {
 	omap1_init_common_hw();
@@ -194,8 +191,6 @@ static void __init voiceblue_init(void)
 	set_irq_type(gpio_to_irq(15), IRQ_TYPE_EDGE_RISING);
 
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
-	omap_board_config = voiceblue_config;
-	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
 	omap_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..4bfd8e3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -298,13 +298,8 @@ static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_dss_device,
 };
 
-static struct omap_board_config_kernel sdp3430_config[] __initdata = {
-};
-
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap_board_config = sdp3430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 7390596..f460d4f 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -72,13 +72,8 @@ static void __init omap_sdp_map_io(void)
 	omap2_map_common_io();
 }
 
-static struct omap_board_config_kernel sdp_config[] __initdata = {
-};
-
 static void __init omap_sdp_init_irq(void)
 {
-	omap_board_config = sdp_config;
-	omap_board_config_size = ARRAY_SIZE(sdp_config);
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index b4e6eca..c16cb3f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,17 +35,11 @@
 /*
  * Board initialization
  */
-static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
-};
-
 static struct platform_device *am3517_evm_devices[] __initdata = {
 };
 
 static void __init am3517_evm_init_irq(void)
 {
-	omap_board_config = am3517_evm_config;
-	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
-
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2626a9f..3ec2687 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -462,14 +462,8 @@ static void __init cm_t35_init_i2c(void)
 			      ARRAY_SIZE(cm_t35_i2c_boardinfo));
 }
 
-static struct omap_board_config_kernel cm_t35_config[] __initdata = {
-};
-
 static void __init cm_t35_init_irq(void)
 {
-	omap_board_config = cm_t35_config;
-	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
-
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 7e6e6ca..cad8b9c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,13 +31,8 @@
 #include <plat/board.h>
 #include <plat/common.h>
 
-static struct omap_board_config_kernel generic_config[] = {
-};
-
 static void __init omap_generic_init_irq(void)
 {
-	omap_board_config = generic_config;
-	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 117b8fd..c38fed2 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -99,9 +99,6 @@ static inline void __init igep2_init_smsc911x(void)
 static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
-static struct omap_board_config_kernel igep2_config[] __initdata = {
-};
-
 static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -166,8 +163,6 @@ static struct twl4030_usb_data igep2_usb_data = {
 
 static void __init igep2_init_irq(void)
 {
-	omap_board_config = igep2_config;
-	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index a9fe918..84e193c 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -30,13 +30,8 @@ static void __init omap_zoom_map_io(void)
 	omap2_map_common_io();
 }
 
-static struct omap_board_config_kernel zoom_config[] __initdata = {
-};
-
 static void __init omap_zoom_init_irq(void)
 {
-	omap_board_config = zoom_config;
-	omap_board_config_size = ARRAY_SIZE(zoom_config);
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();

