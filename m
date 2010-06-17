From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/12] OMAP: voltage: use device_initcall()
Date: Wed, 16 Jun 2010 17:17:07 -0700
Message-ID: <1276733833-18510-7-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61763 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab0FQARb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:31 -0400
Received: by pxi8 with SMTP id 8so4194812pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:30 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

FIXME: this should be fixed in the SR/voltage v4 series

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/voltage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index b6d4f23..6e84ea1 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -1196,4 +1196,4 @@ static int __init omap_voltage_init(void)
 	}
 	return 0;
 }
-arch_initcall(omap_voltage_init);
+device_initcall(omap_voltage_init);
-- 
1.7.0.2

