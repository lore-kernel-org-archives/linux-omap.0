From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: OMAP3 sleep code clean-up
Date: Thu, 18 Nov 2010 15:51:44 +0100
Message-ID: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55955 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0KROwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 09:52:42 -0500
Received: by wwa36 with SMTP id 36so3423123wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 06:52:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>:

 [PATCH 1/2]: OMAP3 PM: move omap3 sleep to ddr

   For historical reasons the OMAP3 sleep code is run from SRAM.
   This code can run from DDR which provides better performance and
   leaves the SRAM available for other uses.

   Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
   with full RET and OFF modes.

 [PATCH 2/2] OMAP3: clean up ASM idle code

   Clean up of the ASM code:
   - reworked and simplified the execution paths, for better
      readability and to avoid duplication of code,
   - reworked the comments for better readability,
   - reworked the code formating and alignment,
   - added comments for the i443 errata workarounds,
   - replaced the cache flush code by a call to the kernel
      common code for ARMv7 (v7_flush_kern_cache_all), which is
      better maintained and so more mature,
   - clean up of non used symbols.

   Tested on Zoom3, OMAP3EVM, Beagleboard, n900
   with full RET and OFF mode.

