From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2+: Fix 9 section mismatch(es) warnings from mach-omap2/built-in.o
Date: Mon,  4 Apr 2011 15:32:05 +0530
Message-ID: <1301911325-2275-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42923 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab1DDKCR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Apr 2011 06:02:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The serial*_data should have been marked as __initdata as per
it's usage in the board files. Fix the same to remove the
section mismatch warnings caused by it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c    |    6 +++---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..a0f85a8 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -719,19 +719,19 @@ static struct omap_device_pad serial3_pads[] __initdata = {
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
index 56702c5..c98e955 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -736,19 +736,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
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
index f3a7b10..eeb22cd 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -551,19 +551,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
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
1.6.0.4

