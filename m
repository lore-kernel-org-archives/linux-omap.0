From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP: PM: Fixed omap_pm_set_min_bus_tput
Date: Thu, 14 May 2009 15:09:50 +0300
Message-ID: <1242302990-4104-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17031 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759592AbZENMgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 08:36:24 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4ECaJQw026236
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 15:36:20 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n4ECaKbB007538
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 15:36:20 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Parameter check for this function was bugged.

Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/plat-omap/omap-pm-noop.c |    4 ++--
 arch/arm/plat-omap/omap-pm-srf.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 490bc8e..4ba261a 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -62,8 +62,8 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 
 void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
-	if (!dev || agent_id != OCP_INITIATOR_AGENT ||
-	    agent_id != OCP_TARGET_AGENT) {
+	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
+	    agent_id != OCP_TARGET_AGENT)) {
 		WARN_ON(1);
 		return;
 	};
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index 72e32de..226662d 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -76,8 +76,8 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 
 void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
-	if (!dev || agent_id != OCP_INITIATOR_AGENT ||
-	    agent_id != OCP_TARGET_AGENT) {
+	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
+	    agent_id != OCP_TARGET_AGENT)) {
 		WARN_ON(1);
 		return;
 	};
-- 
1.5.4.3

