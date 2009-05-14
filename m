From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] ARM: OMAP2: Fix SPI driver failure on 2420 when running
	multi-omap config
Date: Thu, 14 May 2009 10:47:20 -0700
Message-ID: <20090514174719.12080.79578.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55547 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZENRrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:47:20 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

SPI driver will do unhandled fault on OMAP2420 if trying to probe
non-existing SPI busses. Register those additional busses runtime only
for cpus having them.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 496983a..894cc35 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -354,10 +354,12 @@ static void omap_init_mcspi(void)
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	platform_device_register(&omap2_mcspi3);
+	if (cpu_is_omap2430() || cpu_is_omap343x())
+		platform_device_register(&omap2_mcspi3);
 #endif
 #ifdef CONFIG_ARCH_OMAP3
-	platform_device_register(&omap2_mcspi4);
+	if (cpu_is_omap343x())
+		platform_device_register(&omap2_mcspi4);
 #endif
 }
 

