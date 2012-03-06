From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix omap24xx_io_desc warning if SoC subtypes
 are not selected
Date: Tue, 6 Mar 2012 11:47:48 -0800
Message-ID: <20120306194748.GU12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965176Ab2CFTrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 14:47:52 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Otherwise we get the following warning:

arch/arm/mach-omap2/io.c:53:24: warning:
'omap24xx_io_desc' defined but not used [-Wunused-variable]

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -49,7 +49,7 @@
  * default mapping provided here.
  */
 
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
 static struct map_desc omap24xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_24XX_VIRT,
