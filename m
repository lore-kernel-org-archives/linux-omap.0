From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 07/12] omap3: sr: device: make omap_sr_latency static
Date: Thu,  5 Aug 2010 17:24:07 -0500
Message-ID: <1281047052-21346-8-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760820Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

omap_sr_latency definition does not need to be exposed to the world
but we cant make it __init data as the pointer is stored in odev
to be used beyond basic kernel boot.

also fixes sparse warning:
arch/arm/mach-omap2/sr_device.c:32:31: warning: symbol 'omap_sr_latency' was not declared. Should it be static?

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 8fb60d8..e816666 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -29,7 +29,7 @@
 
 #include "voltage.h"
 
-struct omap_device_pm_latency omap_sr_latency[] = {
+static struct omap_device_pm_latency omap_sr_latency[] = {
 	{
 		.deactivate_func = omap_device_idle_hwmods,
 		.activate_func	 = omap_device_enable_hwmods,
-- 
1.6.3.3

