From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/19] omap: mach-omap2/io.c: fix function declarations
Date: Thu, 11 Mar 2010 15:48:37 -0800
Message-ID: <20100311234837.4500.84957.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53681 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:13 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

Get rid of the following warnings:

	warning: non-ANSI function declaration of function [...]

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 402e8f0..ae89d55 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -237,7 +237,7 @@ static void __init _omap2_map_common_io(void)
 }
 
 #ifdef CONFIG_ARCH_OMAP2420
-void __init omap242x_map_common_io()
+void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
@@ -246,7 +246,7 @@ void __init omap242x_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
-void __init omap243x_map_common_io()
+void __init omap243x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
@@ -255,7 +255,7 @@ void __init omap243x_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-void __init omap34xx_map_common_io()
+void __init omap34xx_map_common_io(void)
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 	_omap2_map_common_io();
@@ -263,7 +263,7 @@ void __init omap34xx_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-void __init omap44xx_map_common_io()
+void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
 	_omap2_map_common_io();

