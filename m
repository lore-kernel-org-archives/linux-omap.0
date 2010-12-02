From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP4 build error - omapfb
Date: Thu, 2 Dec 2010 21:25:41 +0000
Message-ID: <20101202212541.GH10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38802 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab0LBVZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 16:25:53 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

drivers/built-in.o: In function `omapfb_do_probe':
drivers/video/omap/omapfb_main.c:1773: undefined reference to `omap2_int_ctrl'

Looks like there's a missing dependency for CONFIG_FB_OMAP.  As the
only place omap2_int_ctrl is defined is in drivers/video/omap/dispc.c,
and this isn't built for OMAP4, maybe FB_OMAP is missing a dependency
such that it's only available for OMAP1, OMAP2 and OMAP3 ?

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 455c605..083c8fe 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -1,7 +1,7 @@
 config FB_OMAP
 	tristate "OMAP frame buffer support (EXPERIMENTAL)"
-	depends on FB && ARCH_OMAP && (OMAP2_DSS = "n")
-
+	depends on FB && (OMAP2_DSS = "n")
+	depends on ARCH_OMAP1 || ARCH_OMAP2 || ARCH_OMAP3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
