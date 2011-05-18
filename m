From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 03/11] OMAP3+: PM: VP: fix vstepmax
Date: Wed, 18 May 2011 00:17:26 -0500
Message-ID: <1305695854-9638-4-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47759 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1ERFRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:39 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdD7028653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4I5Hdmn004912
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Kevin's
OMAP3+: VP: remove omap_vp_runtime_data

has a typo to fix which causes waittime to be populated for stepmax.
this is flawed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 6336ba6..e7d38f6 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -87,7 +87,7 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	voltdm->write(val, vp->vstepmin);
 
 	/* VSTEPMAX */
-	val = (waittime << vp->common->vstepmax_stepmax_shift) |
+	val = (vstepmax << vp->common->vstepmax_stepmax_shift) |
 		(waittime << vp->common->vstepmax_smpswaittimemax_shift);
 	voltdm->write(val, vp->vstepmax);
 
-- 
1.7.0.4

