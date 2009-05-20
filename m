From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 10/14] BRIDGE: Number of supported OPPs increased to 5
Date: Wed, 20 May 2009 00:02:16 -0500
Message-ID: <1242795740-21535-10-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
 <1242795740-21535-9-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40805 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZETE6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-9-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Armando Uribe de Leon <x0095078@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Armando Uribe de Leon <x0095078@ti.com>

This patch increases the supported opp numbers within bridge driver,
it will also fix the opp table to be fully populated in the shared memory;
before, it was causing the QOS test reported numbers to be inaccurate.

Signed-off-by: Armando Uribe de Leon <x0095078@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index c8af75c..e937766 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -210,7 +210,7 @@ static struct file_operations bridge_fops = {
 static u32 timeOut = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
 static struct clk *clk_handle;
-s32 dsp_max_opps = VDD1_OPP3;
+s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
 /* Maximum Opps that can be requested by IVA*/
-- 
1.6.2.4

