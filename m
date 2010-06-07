From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] omap2 usb-ehci: Add missing dma-mapping.h
Date: Mon,  7 Jun 2010 18:00:41 +0100
Message-ID: <1275930041-17500-1-git-send-email-jic23@cam.ac.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:47047 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0FGRBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 13:01:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, eballetbo@iseebcn.com, Jonathan Cameron <jic23@cam.ac.uk>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 I'm not a user of this code but was browsing the kautobuild logs
 and saw the igep0020 build error that has been there since
 24th of May using the defconfig.  Looks like a trivial
 missing header to me.  I can not verify the resulting
 build works, but it does build cleanly with this patch
 on mainline as of a few minutes ago.  Sorry for the noise
 if this has already been addressed but I'm not seeing
 anything in the linux-omap@vger archive.

 arch/arm/mach-omap2/usb-ehci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index c68f799..465699f 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <plat/mux.h>
 
-- 
1.6.4.4

