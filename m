From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 2/6] OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
Date: Tue, 27 Sep 2011 19:18:02 +0200
Message-ID: <1317143886-13285-3-git-send-email-b-cousson@ti.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38913 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1I0RS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Sep 2011 13:18:57 -0400
In-Reply-To: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Nishanth Menon <nm@ti.com>

Replace the multiple omap2_get_XXX_device APIs with the new
omap_hwmod_name_get_dev that uses the hwmod name to get the proper
device.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..9815b2b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -493,8 +493,8 @@ static void __init beagle_opp_init(void)
 	if (cpu_is_omap3630()) {
 		struct device *mpu_dev, *iva_dev;
 
-		mpu_dev = omap2_get_mpuss_device();
-		iva_dev = omap2_get_iva_device();
+		mpu_dev = omap_device_get_by_hwmod_name("mpu");
+		iva_dev = omap_device_get_by_hwmod_name("iva");
 
 		if (!mpu_dev || !iva_dev) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
-- 
1.7.0.4

