From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/12] OMAP: SR: use device_initcall()
Date: Wed, 16 Jun 2010 17:17:08 -0700
Message-ID: <1276733833-18510-8-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab0FQARc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:32 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:32 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

DROP ME: this should be fixed in SR/voltage v4 series

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sr_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 5ca0253..dbf7603 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -174,4 +174,4 @@ static int __init omap_devinit_smartreflex(void)
 {
 	return omap_hwmod_for_each_by_class("smartreflex", sr_dev_init, NULL);
 }
-subsys_initcall(omap_devinit_smartreflex);
+device_initcall(omap_devinit_smartreflex);
-- 
1.7.0.2

