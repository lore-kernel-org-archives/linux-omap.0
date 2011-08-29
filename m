From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 16/22] OMAP2+: voltage: enable VC bypass scale method when VC is initialized
Date: Mon, 29 Aug 2011 10:35:49 -0700
Message-ID: <1314639355-12713-17-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:37012 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643Ab1H2Rf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:35:59 -0400
Received: by mail-yw0-f41.google.com with SMTP id 13so4764801ywm.28
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:35:58 -0700 (PDT)
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

VC is initialized first, set default scaling method to VC bypass.
If/when VP is initialized, default scaling method will be changed to
VP force-update.

Enabling VC bypass as default as soon as VC is initialized allows for
VC bypass scaling to work when no VP is configured/initialized for a
given voltage domain.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c6352e3..e1a22a3 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -802,8 +802,10 @@ int __init omap_voltage_late_init(void)
 		if (!voltdm->scalable)
 			continue;
 
-		if (voltdm->vc)
+		if (voltdm->vc) {
+			voltdm->vdd->volt_scale = omap_vc_bypass_scale;
 			omap_vc_init_channel(voltdm);
+		}
 
 		if (voltdm->vdd) {
 			if (omap_vdd_data_configure(voltdm))
-- 
1.7.6

