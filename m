From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/2] arm: omap: gpmc: kill compile warning
Date: Tue, 29 Dec 2009 03:05:07 +0200
Message-ID: <1262048708-25033-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51608 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbZL2BFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 20:05:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

Get rid of the following warnings:

arch/arm/mach-omap2/gpmc.c:550:30: warning: non-ANSI
function declaration of function 'omap3_gpmc_save_context'

arch/arm/mach-omap2/gpmc.c:581:33: warning: non-ANSI
function declaration of function 'omap3_gpmc_restore_context'

while at that, also add a blank line between variable
declaration and function body for ease of reading.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd8cb59..32f2c51 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -547,9 +547,10 @@ void __init gpmc_init(void)
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_gpmc_regs gpmc_context;
 
-void omap3_gpmc_save_context()
+void omap3_gpmc_save_context(void)
 {
 	int i;
+
 	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
 	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
 	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
@@ -578,9 +579,10 @@ void omap3_gpmc_save_context()
 	}
 }
 
-void omap3_gpmc_restore_context()
+void omap3_gpmc_restore_context(void)
 {
 	int i;
+
 	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
 	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
 	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
-- 
1.6.6.35.g1d85d

