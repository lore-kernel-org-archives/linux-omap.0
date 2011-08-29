From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 5/7] OMAP3+: voltage: update nominal voltage in voltdm_scale() not VC post-scale
Date: Mon, 29 Aug 2011 11:10:47 -0700
Message-ID: <1314641449-5089-6-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43738 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754680Ab1H2SKa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:10:30 -0400
Received: by mail-pz0-f46.google.com with SMTP id 32so10284581pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:10:29 -0700 (PDT)
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Currently, the nominal voltage is updated in the VC post-scale function
which is common to both scaling methods.  However, this has readabiliy
problems as this update is not where it might be expected.  Instead, move
the updated into voltdm_scale() upon a successful return of voltdm->scale()

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c      |    2 --
 arch/arm/mach-omap2/voltage.c |    6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 130df29..1c2bb9c 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -143,8 +143,6 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 	smps_delay = ((smps_steps * voltdm->pmic->step_size) /
 			voltdm->pmic->slew_rate) + 2;
 	udelay(smps_delay);
-
-	voltdm->nominal_volt = target_volt;
 }
 
 /* vc_bypass_scale - VC bypass method of voltage scaling */
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 441c2d9..64070ac 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -85,7 +85,11 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
-	return voltdm->scale(voltdm, target_volt);
+	ret = voltdm->scale(voltdm, target_volt);
+	if (!ret)
+		voltdm->nominal_volt = target_volt;
+
+	return ret;
 }
 
 /**
-- 
1.7.6

