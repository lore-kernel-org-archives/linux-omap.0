From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: [PATCH] OMAP3: Rename configuration files
Date: Thu, 9 Apr 2009 13:54:29 -0500
Message-ID: <782515bb0904091154n57a95249kad76565d2945d325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43166 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760313AbZDISyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 14:54:32 -0400
Received: by fxm2 with SMTP id 2so730789fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2009 11:54:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From fdc5cc07b1e674ae081e331a62d0771124c3910f Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 9 Apr 2009 13:12:31 -0500
Subject: [PATCH] OMAP3: Rename configuration files

Rename 3430sdp and ldp with omap3 prefix
This allows for all omap3 configurations to be listed together

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 ...p_3430sdp_defconfig => omap3_3430sdp_defconfig} |    0
 .../{omap_ldp_defconfig => omap3_zoom1_defconfig}  |    0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/configs/{omap_3430sdp_defconfig =>
omap3_3430sdp_defconfig} (100%)
 rename arch/arm/configs/{omap_ldp_defconfig => omap3_zoom1_defconfig} (100%)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig
b/arch/arm/configs/omap3_3430sdp_defconfig
similarity index 100%
rename from arch/arm/configs/omap_3430sdp_defconfig
rename to arch/arm/configs/omap3_3430sdp_defconfig
diff --git a/arch/arm/configs/omap_ldp_defconfig
b/arch/arm/configs/omap3_zoom1_defconfig
similarity index 100%
rename from arch/arm/configs/omap_ldp_defconfig
rename to arch/arm/configs/omap3_zoom1_defconfig
-- 
1.5.4.3
