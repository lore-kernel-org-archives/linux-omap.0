From: Nishanth Menon <nm@ti.com>
Subject: [PATCH]RESEND:OMAP3:configs: rename sdp and ldp defconfig
Date: Wed, 22 Apr 2009 15:47:22 -0500
Message-ID: <1240433242-29386-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39726 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756458AbZDVUr3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2009 16:47:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Rename the 3430sdp and ldp defconfig to make
names to make them collected with omap3 filenames

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 ...p_3430sdp_defconfig => omap3_3430sdp_defconfig} |    0 
 .../{omap_ldp_defconfig => omap3_zoom1_defconfig}  |    0 
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/configs/{omap_3430sdp_defconfig => omap3_3430sdp_defconfig} (100%)
 rename arch/arm/configs/{omap_ldp_defconfig => omap3_zoom1_defconfig} (100%)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap3_3430sdp_defconfig
similarity index 100%
rename from arch/arm/configs/omap_3430sdp_defconfig
rename to arch/arm/configs/omap3_3430sdp_defconfig
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap3_zoom1_defconfig
similarity index 100%
rename from arch/arm/configs/omap_ldp_defconfig
rename to arch/arm/configs/omap3_zoom1_defconfig
-- 
1.5.4.3

