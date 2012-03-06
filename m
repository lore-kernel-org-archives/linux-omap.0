From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Fix section mismatch for omap1_init_early()
Date: Tue, 6 Mar 2012 10:19:01 -0800
Message-ID: <20120306181901.GS12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65199 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152Ab2CFSTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 13:19:05 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Fix the following warning:

WARNING: vmlinux.o(.text+0x1286c): Section mismatch in reference
from the function omap1_init_early() to the function .init.text:omap1_clk_init()
The function omap1_init_early() references
the function __init omap1_clk_init().
This is often because omap1_init_early lacks a __init
annotation or the annotation of omap1_clk_init is wrong.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -118,7 +118,7 @@ void __init omap16xx_map_io(void)
 /*
  * Common low-level hardware init for omap1.
  */
-void omap1_init_early(void)
+void __init omap1_init_early(void)
 {
 	omap_check_revision();
 
