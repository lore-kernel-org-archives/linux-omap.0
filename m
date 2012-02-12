From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 12 Feb 2012 11:44:30 +0000
Message-ID: <20120212114430.GA18505@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41284 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2BLLog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Feb 2012 06:44:36 -0500
Content-Disposition: inline
In-Reply-To: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Here's another issue which kautobuildv2 just found, as I've now added
randconfig to the suite of OMAP4430 SDP builds.  Obviously, as it's
using a different configuration each time, it's going to find different
issues on each run.

For this, the seed config has the following extra lines compared with
allnoconfig:

CONFIG_ARM_PATCH_PHYS_VIRT=y
CONFIG_THUMB2_KERNEL=n

The reason for the last line is that -mauto-it is not supported by my
toolchain, so if it were to be enabled, it would cause an immediate
build failure.  The second to late line ensures that we don't end up
with randconfig having to dream up a value for CONFIG_PHYS_OFFSET,
which it can't do.

The seed configs can now be viewed or downloaded from the build site.
8<========
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: OMAP: fix missing __devexit_p() annotations

Missing __devexit_p() annotations in driver structures for remove functions
marked with __devexit is waiting for build errors to happen, such as:

`omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/built-in.o: defined in discarded section `.devexit.text' of arch/arm/plat-omap/built-in.o

Add the necessary annotation, and as a result of audit, fix others which
are also missing in arch/arm/*omap*.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/plat-omap/dma.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7e755bb..47c77a1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.driver		= {
 		.name	= "smartreflex",
 	},
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..cb856fe 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2125,7 +2125,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
+	.remove		= __devexit_p(omap_system_dma_remove),
 	.driver		= {
 		.name	= "omap_dma_system"
 	},

