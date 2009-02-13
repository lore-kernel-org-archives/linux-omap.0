From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] ARM: OMAP: Removal of duplicate cbus entry
Date: Fri, 13 Feb 2009 16:00:45 +0200
Message-ID: <1234533645-30120-1-git-send-email-ameya.palande@nokia.com>
References: <20090213092300.1b9a5d38.jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56301 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbZBMOAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 09:00:49 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1DE0cQ4009071
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 16:00:45 +0200
In-Reply-To: <20090213092300.1b9a5d38.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 67de08b..fec4d8e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_FB_INTEL)          += video/intelfb/
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
-obj-y				+= base/ block/ misc/ mfd/ net/ media/ cbus/
+obj-y				+= base/ block/ misc/ mfd/ net/ media/
 obj-y				+= i2c/
 obj-y				+= cbus/
 obj-$(CONFIG_NUBUS)		+= nubus/
-- 
1.5.6.3

