From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH 5/5] DSPBRIDGE: Removes checkpatch error with file_operations
Date: Sat, 17 Apr 2010 14:00:36 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC26227F2@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab0DQTAl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Apr 2010 15:00:41 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 8d29388e77d01a9cf549a5adfdc8f21244f14cad Mon Sep 17 00:00:00 2001
From: Armando Uribe De Leon <x0095078@ti.com>
Date: Thu, 8 Apr 2010 19:26:23 -0500
Subject: [PATCH 5/5] DSPBRIDGE: Removes checkpatch error with file_operations

This patch removes the checptach error sue to the missing const modifier in file_operations.

Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 3369e6c..ed3a60c 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -140,7 +140,7 @@ MODULE_VERSION(DSPBRIDGE_VERSION);
 
 static char *driver_name = DRIVER_NAME;
 
-static struct file_operations bridge_fops = {
+static const struct file_operations bridge_fops = {
 	.open = bridge_open,
 	.release = bridge_release,
 	.unlocked_ioctl = bridge_ioctl,
--
1.6.0.4

