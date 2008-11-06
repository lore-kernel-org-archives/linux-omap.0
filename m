From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Wed, 5 Nov 2008 23:09:59 -0800
Message-ID: <200811052309.59974.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200811051554.24055.david-b@pacbell.net> <20081106033210.GP21736@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:32109 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752034AbYKFHKH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 02:10:07 -0500
In-Reply-To: <20081106033210.GP21736@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org

On Wednesday 05 November 2008, Tony Lindgren wrote:
> OK, I've pushed the hsmmc init patches. They still need work though.
> 
> Please everybody check your board MMC configuration and send patches
> as needed.

See the appended build fixes ... :)

Also, I suspect there needs to be an MMC_CAP_8_BIT_DATA at
some point, with hsmmc driver support.


> Also the write protect interrupts are not handled, and gpio handling
> is twl specific. Hopefully a better base for the code anyways.

I'll have a look at write protect ... it wouldn't normally
be an IRQ, just an input GPIO.  Unlike the CD, which gets
used for both purposes; that code looks iffy too.

Yes, a better base.

- Dave
 

========= CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Build fixes for "HSMMC: Improve the interface for hsmmc_init()".
The header file needs to work without MMC support enabled, and
some board files needed to include it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    3 +++
 arch/arm/mach-omap2/board-ldp.c          |    3 +++
 arch/arm/mach-omap2/board-omap2evm.c     |    3 +++
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 ++
 arch/arm/mach-omap2/board-omap3evm.c     |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c |    2 ++
 arch/arm/mach-omap2/mmc-twl4030.h        |    8 ++++----
 7 files changed, 19 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -44,6 +44,9 @@
 
 #include <asm/io.h>
 
+#include "mmc-twl4030.h"
+
+
 #define	SDP2430_FLASH_CS	0
 #define	SDP2430_SMC91X_CS	5
 
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -41,6 +41,9 @@
 #include <asm/delay.h>
 #include <mach/control.h>
 
+#include "mmc-twl4030.h"
+
+
 #define CONFIG_DISABLE_HFCLK 1
 
 #define ENABLE_VAUX1_DEDICATED	0x03
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -41,6 +41,9 @@
 #include <mach/mcspi.h>
 #include <mach/mux.h>
 
+#include "mmc-twl4030.h"
+
+
 #define GPMC_OFF_CONFIG1_0 0x60
 
 static struct mtd_partition omap2evm_nand_partitions[] = {
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -44,6 +44,8 @@
 #include <mach/mux.h>
 
 #include "twl4030-generic-scripts.h"
+#include "mmc-twl4030.h"
+
 
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -40,6 +40,8 @@
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "twl4030-generic-scripts.h"
+#include "mmc-twl4030.h"
+
 
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -47,6 +47,8 @@
 #include <mach/usb-musb.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
+#include "mmc-twl4030.h"
+
 
 #define NAND_BLOCK_SIZE SZ_128K
 #define GPMC_CS0_BASE  0x60
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -6,20 +6,20 @@
  * published by the Free Software Foundation.
  */
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
 struct twl4030_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
 	int	gpio_cd;	/* or -EINVAL */
 };
 
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
 void hsmmc_init(struct twl4030_hsmmc_info *);
 
 #else
 
-static inline void hsmmc_init(struct twl4030_hsmmc_info *)
+static inline void hsmmc_init(struct twl4030_hsmmc_info *info)
 {
 }
 

