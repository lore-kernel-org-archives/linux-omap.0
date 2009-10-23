From: y@vip-tid.localdomain
Subject: [PATCH] update mach-types
Date: Thu, 22 Oct 2009 19:01:12 -0500
Message-ID: <4252.03066920421$1256256203@news.gmane.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZJWADH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 20:03:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Added zoom3 and sdp3630 board support

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
Tony: Please host this patch temporarily on l-o till rmk pulls in
the mach-types updates

 arch/arm/tools/mach-types |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 94be7bb..d61277b 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -2421,3 +2421,5 @@ liberty			MACH_LIBERTY		LIBERTY			2434
 mh355			MACH_MH355		MH355			2435
 pc7802			MACH_PC7802		PC7802			2436
 gnet_sgc		MACH_GNET_SGC		GNET_SGC		2437
+omap_zoom3		MACH_OMAP_ZOOM3		OMAP_ZOOM3		2464
+omap_3630sdp		MACH_OMAP_3630SDP	OMAP_3630SDP		2465
-- 
1.6.5.rc1.19.g8426

