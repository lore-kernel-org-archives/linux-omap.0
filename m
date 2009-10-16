From: Tony Lindgren <tony@atomide.com>
Subject: 24xx/n8x0 booting again, linux-omap updated to -rc5
Date: Thu, 15 Oct 2009 18:27:47 -0700
Message-ID: <20091016012747.GA12576@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53814 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758867AbZJPB2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 21:28:31 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Mybbh-0007qb-VR
	for linux-omap@vger.kernel.org; Fri, 16 Oct 2009 01:27:50 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Thanks to Paul's "OMAP2xxx clock: set up clockdomain pointer in struct clk"
patch, we got 24xx booting again both in mainline and in linux-omap.

The following patch is also needed to change the n8x0 serial console CMDLINE
from ttyS0 to ttyS2 as the port numbering now matches the physical ports.
The patch is already in linux-omap, but not yet in mainline.

Also, I've rebuilt linux-omap again on top of -rc5. Will merge in the plat
header patches tomorrow.

Cheers,

Tony

--tKW2IUtsqtDRztdT
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="n8x0-serial-fix.patch"

>From 71d3bff80f77cdd286303f19308058c6c844458f Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Oct 2009 18:13:28 -0700
Subject: [PATCH] omap: Fix console serial port number for n8x0

With the recent changes omap serial ports match the physical
numbering like they should. Fix the kernel CMDLINE accordingly
so console works.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 8da75de..264f52b 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -304,7 +304,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x10C08000
 CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
-CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS0,115200n8"
+CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS2,115200n8"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 

--tKW2IUtsqtDRztdT--
