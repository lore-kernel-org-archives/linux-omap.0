From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/13] ARM: gpio: davinci: convert drivers to use asm/gpio.h
 rather than mach/gpio.h
Date: Tue, 09 Aug 2011 09:06:21 +0100
Message-ID: <E1QqhKP-0003aK-9R@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41914 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1HIIG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 04:06:29 -0400
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/musb/davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 8bdf25a..f9a3f62 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -35,7 +35,7 @@
 
 #include <mach/hardware.h>
 #include <mach/memory.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/cputype.h>
 
 #include <asm/mach-types.h>
-- 
1.7.4.4

