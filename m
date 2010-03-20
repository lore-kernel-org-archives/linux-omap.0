From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 19 Mar 2010 17:47:47 -0700
Message-ID: <20100320004746.GB11448@atomide.com>
References: <20100320003605.GA11448@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57903 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0CTAqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 20:46:17 -0400
Content-Disposition: inline
In-Reply-To: <20100320003605.GA11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Allen Pais <allen.pais@ti.com>, Vikram Pandita <vikram.pandita@ti.com>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100319 17:30]:
> Hi all,
> 
> Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.

And of course it won't compile because of a missing #.
Here's the working version.

Tony

--jq0ap7NbKX2Kqbes
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom-uart.patch"

>From d1d25009c085a2ea677da6bc2c905fbcf98e224e Mon Sep 17 00:00:00 2001
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
index eb62bf9..355e87d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -328,6 +328,15 @@ __create_page_tables:
 	add	r0, r4, #0xd8000000 >> 18
 	str	r3, [r0]
 #endif
+#if defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3)
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

--jq0ap7NbKX2Kqbes--
