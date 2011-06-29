From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 6/9] OMAP device: change pr_warnings to pr_debugs
Date: Wed, 29 Jun 2011 12:05:00 +0300
Message-ID: <1309338303-2086-7-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45695 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab1F2JFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:19 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95JQ4031293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:19 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95JKc027038
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:19 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95GCS009169
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:18 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Prevents a hang when omap_device would want to print something for
serial console device while enabling / disabling its clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 49fc0df..c2b8461 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -146,12 +146,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
+				pr_debug("omap_device: %s.%d: new worst case "
 					   "activate latency %d: %llu\n",
 					   od->pdev.name, od->pdev.id,
 					   od->pm_lat_level, act_lat);
 			} else
-				pr_warning("omap_device: %s.%d: activate "
+				pr_debug("omap_device: %s.%d: activate "
 					   "latency %d higher than exptected. "
 					   "(%llu > %d)\n",
 					   od->pdev.name, od->pdev.id,
@@ -214,12 +214,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
+				pr_debug("omap_device: %s.%d: new worst case "
 					   "deactivate latency %d: %llu\n",
 					   od->pdev.name, od->pdev.id,
 					   od->pm_lat_level, deact_lat);
 			} else
-				pr_warning("omap_device: %s.%d: deactivate "
+				pr_debug("omap_device: %s.%d: deactivate "
 					   "latency %d higher than exptected. "
 					   "(%llu > %d)\n",
 					   od->pdev.name, od->pdev.id,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

