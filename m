From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Thu, 28 Aug 2008 20:30:44 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A534486D6A4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbYH2Bav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 21:30:51 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7T1UkON004271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:30:51 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7T1UkuQ000829
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:30:46 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Added the table end 'CMD_BASE_END_OFFSET' define in wcdioctl.h

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---

Index: omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:03:10.000000000 -0500
+++ omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:20:05.000000000 -0500
@@ -515,4 +515,5 @@
 #define CMD_CMM_GETINFO_OFFSET	  (CMD_CMM_BASE_OFFSET + 3)
 #define CMD_CMM_END_OFFSET	      CMD_CMM_GETINFO_OFFSET
 
+#define CMD_BASE_END_OFFSET	CMD_CMM_END_OFFSET
 #endif				/* WCDIOCTL_ */
