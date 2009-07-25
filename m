From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 32/32] ARM: OMAP: RX51: set MMC capabilities and
	power-saving flag
Date: Sun, 26 Jul 2009 00:53:29 +0100
Message-ID: <20090725235329.GE12665@console-pimps.org>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower> <20090710124353.1262.22788.sendpatchset@ahunter-tower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752867AbZGYXxy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090710124353.1262.22788.sendpatchset@ahunter-tower>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 10, 2009 at 03:43:53PM +0300, Adrian Hunter wrote:
> >From 3865867159f25cf706480236f6d4f0e4adde5dac Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Fri, 10 Jul 2009 10:32:44 +0300
> Subject: [PATCH] ARM: OMAP: RX51: set MMC capabilities and power-saving flag
> 
> Specify MMC capabilities and set the power-saving flag
> for RX51.
> 

After the changes to [PATCH 7/32], this becomes,

---

ARM: OMAP: RX51: set MMC capabilities and power-saving flag

Specify MMC capabilities and set the power-saving flag for RX51.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a0bf67..d2ce938 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 
 #include <mach/mcspi.h>
 #include <mach/mux.h>
@@ -102,6 +103,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
+		.caps		= MMC_CAP_SD,
 	},
 	{
 		.name		= "internal",
@@ -109,6 +112,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
+		.caps		= MMC_CAP_MMC | MMC_CAP_NONREMOVABLE,
 	},
 	{}	/* Terminator */
 };
-- 
1.6.4.rc0
