From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] Removal of duplicate cbus entry
Date: Thu, 12 Feb 2009 17:39:53 +0200
Message-ID: <499442C9.7030406@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64714 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZBLPj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 10:39:57 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1CFdjXv029373
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 17:39:54 +0200
Received: from [172.21.34.209] (esdhcp034209.research.nokia.com [172.21.34.209])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1CFdojd005931
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 17:39:51 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Removal of duplicate cbus entry.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
  drivers/Makefile |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 67de08b..1eff6ed 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -41,7 +41,6 @@ obj-y				+= serial/
  obj-$(CONFIG_PARPORT)		+= parport/
  obj-y				+= base/ block/ misc/ mfd/ net/ media/ cbus/
  obj-y				+= i2c/
-obj-y				+= cbus/
  obj-$(CONFIG_NUBUS)		+= nubus/
  obj-$(CONFIG_ATM)		+= atm/
  obj-y				+= macintosh/
