From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH 4/5] OMAP SSI integration into misc drivers
Date: Fri,  3 Oct 2008 13:29:41 +0300
Message-ID: <1223029782-12009-4-git-send-email-carlos.chinea@nokia.com>
References: <1223029515.32631.148.camel@groo.research.nokia.com>
 <1223029782-12009-1-git-send-email-carlos.chinea@nokia.com>
 <1223029782-12009-2-git-send-email-carlos.chinea@nokia.com>
 <1223029782-12009-3-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22511 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbYJCKa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 06:30:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m93ATMO5006247
	for <linux-omap@vger.kernel.org>; Fri, 3 Oct 2008 05:30:26 -0500
In-Reply-To: <1223029782-12009-3-git-send-email-carlos.chinea@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/misc/Kconfig  |    2 ++
 drivers/misc/Makefile |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f0202ee..b09dc68 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -488,4 +488,6 @@ config SGI_GRU_DEBUG
 	This option enables addition debugging code for the SGI GRU driver. If
 	you are unsure, say N.
 
+source "drivers/misc/ssi/Kconfig"
+
 endif # MISC_DEVICES
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b6167e7..39e153d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
+obj-$(CONFIG_OMAP_SSI)		+= ssi/
-- 
1.5.3.6

