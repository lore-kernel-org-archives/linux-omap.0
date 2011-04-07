From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH] arm: omap2plus: kill section mismatches
Date: Thu,  7 Apr 2011 11:05:11 +0300
Message-ID: <1302163511-32510-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35344 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754631Ab1DGIFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 04:05:20 -0400
Received: by ewy5 with SMTP id 5so643729ewy.6
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 01:05:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Those were very simple to fix and while we should
be putting effort on code consolidation, having
a noisy compilation is very painful and makes it
more difficult to see newer warnings introduced
by re-factoring other code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c    |   10 +++++-----
 arch/arm/mach-omap2/board-4430sdp.c    |    8 ++++----
 arch/arm/mach-omap2/board-omap4panda.c |    8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..5f15767 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -719,25 +719,25 @@ static struct omap_device_pad serial3_pads[] __initdata = {
 			 OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial1_data = {
+static struct omap_board_data serial1_data __initdata = {
 	.id		= 0,
 	.pads		= serial1_pads,
 	.pads_cnt	= ARRAY_SIZE(serial1_pads),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
 };
 
-static inline void board_serial_init(void)
+static inline void __init board_serial_init(void)
 {
 	omap_serial_init_port(&serial1_data);
 	omap_serial_init_port(&serial2_data);
@@ -746,7 +746,7 @@ static inline void board_serial_init(void)
 #else
 #define board_mux	NULL
 
-static inline void board_serial_init(void)
+static inline void __init board_serial_init(void)
 {
 	omap_serial_init();
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..ab701cd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -736,25 +736,25 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id		= 3,
 	.pads		= serial4_pads,
 	.pads_cnt	= ARRAY_SIZE(serial4_pads),
 };
 
-static inline void board_serial_init(void)
+static inline void __init board_serial_init(void)
 {
 	struct omap_board_data bdata;
 	bdata.flags	= 0;
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..4573b96 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -551,25 +551,25 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id             = 1,
 	.pads           = serial2_pads,
 	.pads_cnt       = ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id             = 2,
 	.pads           = serial3_pads,
 	.pads_cnt       = ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id             = 3,
 	.pads           = serial4_pads,
 	.pads_cnt       = ARRAY_SIZE(serial4_pads),
 };
 
-static inline void board_serial_init(void)
+static inline void __init board_serial_init(void)
 {
 	struct omap_board_data bdata;
 	bdata.flags     = 0;
-- 
1.7.4.1.343.ga91df

