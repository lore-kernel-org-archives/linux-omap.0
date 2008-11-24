From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: Please fix or remove OMAP2 onenand driver
Date: Mon, 24 Nov 2008 13:37:05 +0200
Message-ID: <492A91E1.50305@nokia.com>
References: <20081123165011.GB17438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60209 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbYKXL2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 06:28:38 -0500
In-Reply-To: <20081123165011.GB17438@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org

Russell King - ARM Linux wrote:
> Clearly this driver has been put into mainline prematurely - it takes
> no account of the relocation of headers.
> 
> It's causing a regression - omap_2430sdp_defconfig used to build in
> mainline, and it no longer does.
> 
> Please fix, or remove this broken driver from mainline.

From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Date: Mon, 24 Nov 2008 13:34:53 +0200
Subject: [PATCH] MTD: OMAP: OneNAND: header file relocation

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mtd/onenand/omap2.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index e39b21d..28034ef 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -35,16 +35,16 @@
 
 #include <asm/io.h>
 #include <asm/mach/flash.h>
-#include <asm/arch/gpmc.h>
-#include <asm/arch/onenand.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/pm.h>
+#include <mach/gpmc.h>
+#include <mach/onenand.h>
+#include <mach/gpio.h>
+#include <mach/pm.h>
 
 #include <linux/dma-mapping.h>
 #include <asm/dma-mapping.h>
-#include <asm/arch/dma.h>
+#include <mach/dma.h>
 
-#include <asm/arch/board.h>
+#include <mach/board.h>
 
 #define DRIVER_NAME "omap2-onenand"
 
-- 
1.5.4.3
