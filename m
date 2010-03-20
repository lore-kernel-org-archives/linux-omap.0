From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 19 Mar 2010 17:36:05 -0700
Message-ID: <20100320003605.GA11448@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63170 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab0CTAee (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 20:34:34 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Allen Pais <allen.pais@ti.com>, Vikram Pandita <vikram.pandita@ti.com>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.

Regards,

Tony

--tKW2IUtsqtDRztdT
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom-uart.patch"

>From d1fa6f3fbc46546f3ade9026dcba80d6fd5bd6bd Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 19 Mar 2010 17:18:45 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3

Zoom2 and 3 have UARTs only on the external debug board.
GPMC needs to be mapped early to use it for DEBUG_LL.

Note that with the pending serial.c patches you need to
set console=ttyS0,115200n8 as it will be the only UART
mapped. To use DEBUG_LL, you need to pass also earlyprintk
in cmdline.

Cc: Allen Pais <allen.pais@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..bd23aa9 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -328,6 +328,15 @@ __create_page_tables:
 	add	r0, r4, #0xd8000000 >> 18
 	str	r3, [r0]
 #endif
+if defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3)
+	/*
+	 * Zoom2 and Zoom3 have UARTs only on the debug board.
+	 * The debug board is connected to the GPMC.
+	 */
+	add	r0, r4, #0xfb000000 >> 18
+	orr	r3, r7, #0x10000000
+	str	r3, [r0]
+#endif
 #endif
 	mov	pc, lr
 ENDPROC(__create_page_tables)

--tKW2IUtsqtDRztdT--
