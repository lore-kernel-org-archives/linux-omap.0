From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH 3/3] N800: Select tcm825x only if wanted
Date: Tue, 13 May 2008 19:04:23 +0300
Message-ID: <12106946633954-git-send-email-sakari.ailus@nokia.com>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com> <1210694663310-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18342 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbYEMQE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 12:04:58 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DG4hh5002099
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 19:04:56 +0300
Received: from kaali.localdomain (kaali.localdomain [192.168.239.7])
	by maxwell.research.nokia.com (Postfix) with ESMTP id 47F564675E
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 19:04:23 +0300 (EEST)
Received: from sailus by kaali.localdomain with local (Exim 4.63)
	(envelope-from <sakari.ailus@nokia.com>)
	id 1JvwzH-0005Mg-9K
	for linux-omap@vger.kernel.org; Tue, 13 May 2008 19:04:23 +0300
In-Reply-To: <1210694663310-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Don't enable automatically TCM825x on N800 unless
VIDEO_HELPER_CHIPS_AUTO is selected.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5c229cc..94beff0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,7 +35,7 @@ config MACH_OMAP_GENERIC
 config MACH_NOKIA_N800
 	bool "Nokia N800"
 	depends on ARCH_OMAP2420
-	select VIDEO_TCM825X if VIDEO_OMAP2
+	select VIDEO_TCM825X if VIDEO_OMAP2 && VIDEO_HELPER_CHIPS_AUTO
 	select CBUS if VIDEO_TCM825X
 	select CBUS_RETU if VIDEO_TCM825X
 	select MENELAUS if VIDEO_TCM825X
-- 
1.5.0.6

