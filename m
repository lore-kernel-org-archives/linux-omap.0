From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] omap: fix build failure due to missing include
	dma-mapping.h
Date: Tue, 08 Jun 2010 15:03:13 +0300
Message-ID: <20100608120313.24902.69896.stgit@baageli.muru.com>
References: <20100608120104.24902.36055.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55350 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0FHMDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 08:03:17 -0400
In-Reply-To: <20100608120104.24902.36055.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Amit Kucheria <amit.kucheria@canonical.com>

From: Amit Kucheria <amit.kucheria@canonical.com>

Fixes following error,

CC      arch/arm/mach-omap2/usb-ehci.o
arch/arm/mach-omap2/usb-ehci.c:263: error: implicit declaration of function
'DMA_BIT_MASK'
arch/arm/mach-omap2/usb-ehci.c:263: error: initializer element is not constant
make[1]: *** [arch/arm/mach-omap2/usb-ehci.o] Error 1

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-ehci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index c68f799..d72d1ac 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -20,6 +20,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+
 #include <asm/io.h>
 #include <plat/mux.h>
 

