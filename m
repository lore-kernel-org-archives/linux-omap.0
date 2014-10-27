From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Mon, 27 Oct 2014 13:00:09 -0700
Message-ID: <20141027200008.GR2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46079 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbaJ0UBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 16:01:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We're moving omaps to use device tree based booting and already have
omap2, omap4, omap5, am335x and am437x booting in device tree only
mode.

Only omap3 still has legacy booting still around and we really want
to make that device tree only. So let's add a warning about deprecated
legacy booting so we get people to upgrade their boards to use device
tree based booting and find out about any remaining issues.

Note that for most boards we already have the .dts file and those can
be booted with without changing the bootloader using the appended
DTB mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -917,6 +917,10 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
 static int __init omap_device_late_init(void)
 {
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
+
+	if (!of_have_populated_dt())
+		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
+
 	return 0;
 }
 omap_late_initcall_sync(omap_device_late_init);
