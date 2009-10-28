From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv2 3/3] OMAP UART: Add omap-serial driver support in
     omap_3430sdp_defconfig
Date: Wed, 28 Oct 2009 12:44:04 +0530 (IST)
Message-ID: <36486.192.168.10.88.1256714044.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53090 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329AbZJ1HOA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 03:14:00 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9S7E4rc004888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:14:04 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9S7E2Yx018363
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:14:03 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 8f743a2fcb704b2bef35b314426209a9c4197aa4 Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Wed, 28 Oct 2009 12:24:26 +0530
Subject: [PATCHv2 3/3] OMAP UART: Add omap-serial driver support in omap_3430sdp_defconfig

This patch adds omap-serial driver support for 3430SDP defconfig.

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8a4a7e2..787d52e 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -880,6 +880,7 @@ CONFIG_SERIAL_8250_RSA=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OMAP is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
-- 
1.5.5





