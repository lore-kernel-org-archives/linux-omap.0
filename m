From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 1/3] OMAP2+: Fix debug section mistmatch warnings
Date: Wed, 1 Jun 2011 11:28:16 +0530
Message-ID: <1306907896-28789-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57249 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab1FAF6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 01:58:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nishant Kamat <nskamat@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Fix the below debug section mismatch warnings.
while compiling kernel with CONFIG_DEBUG_SECTION_MISMATCH=y

WARNING: vmlinux.o(.data+0x38638): Section mismatch in reference from the
variable serial*_data to the (unknown reference) .init.data:(unknown)
The variable serial*_data references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Reported-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
Based on 3.0-rc1

 arch/arm/mach-omap2/board-3430sdp.c    |    6 +++---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ae2963a..5dac974 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -622,19 +622,19 @@ static struct omap_device_pad serial3_pads[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 73fa90b..f90623d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -681,19 +681,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 90485fc..84a8e4a 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -526,19 +526,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
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
-- 
1.7.0.4

