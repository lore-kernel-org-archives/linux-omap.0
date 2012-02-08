From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 08/16] ARM: omap: fix section mismatch warning in mux.c
Date: Wed, 08 Feb 2012 16:38:29 +0000
Message-ID: <E1RvAXN-0006HJ-RK@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2BHQie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:38:34 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x15a4): Section mismatch in reference from the function omap_mux_init_signals() to the function .init.text:omap_mux_init_signal()
The function omap_mux_init_signals() references
the function __init omap_mux_init_signal().
This is often because omap_mux_init_signals lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/mux.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index e1cc75d..f26b2fa 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1094,8 +1094,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 		omap_mux_package_init_balls(package_balls, superset);
 }
 
-static void omap_mux_init_signals(struct omap_mux_partition *partition,
-				  struct omap_board_mux *board_mux)
+static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
+					 struct omap_board_mux *board_mux)
 {
 	omap_mux_set_cmdline_signals();
 	omap_mux_write_array(partition, board_mux);
@@ -1109,8 +1109,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 {
 }
 
-static void omap_mux_init_signals(struct omap_mux_partition *partition,
-				  struct omap_board_mux *board_mux)
+static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
+					 struct omap_board_mux *board_mux)
 {
 }
 
-- 
1.7.4.4

