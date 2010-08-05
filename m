From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 3/7] OMAP4: pm: Change l3_main to l3_main_1 during bus device init
Date: Thu,  5 Aug 2010 17:47:52 +0200
Message-ID: <1281023276-15679-4-git-send-email-b-cousson@ti.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35477 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758190Ab0HEPsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 11:48:11 -0400
In-Reply-To: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

The OMAP4 L3 interconnect is split in 3 part for power saving reason.
Because of that there is no l3_main like on OMAP2 & 3 but 3 differentes
l3_main_X instances.

In the case of OMAP4, query only the l3_main_1 part. The clock and
voltage are shared across the 3 instances.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 68f9f2e..89e8125 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -70,7 +70,10 @@ static void omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu", &mpu_dev);
 	_init_omap_device("iva", &dsp_dev);
-	_init_omap_device("l3_main", &l3_dev);
+	if (cpu_is_omap44xx())
+		_init_omap_device("l3_main_1", &l3_dev);
+	else
+		_init_omap_device("l3_main", &l3_dev);
 }
 
 static int __init omap2_common_pm_init(void)
-- 
1.6.1.3

