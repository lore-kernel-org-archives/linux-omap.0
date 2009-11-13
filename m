From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv3 3/3] OMAP UART: Add omap-serial driver support in
     omap_3430sdp_defconfig.
Date: Fri, 13 Nov 2009 12:24:22 +0530 (IST)
Message-ID: <45428.192.168.10.88.1258095262.squirrel@dbdmail.itg.ti.com>
References: <36486.192.168.10.88.1256714044.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39310 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991AbZKMGyR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:54:17 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAD6sNYj014352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:54:23 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAD6sLLI002586
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:54:22 -0600 (CST)
In-Reply-To: <36486.192.168.10.88.1256714044.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 8dae69c5e17421123b88414021289974e968fd02 Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Fri, 13 Nov 2009 12:08:42 +0530
Subject: [PATCH] OMAP UART: Add omap-serial driver support in omap_3430sdp_defconfig

This patch adds omap-serial driver support for 3430SDP defconfig.

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 7dbfa7f..9f94965 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -794,6 +794,7 @@ CONFIG_SERIAL_8250_RSA=y
 # CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OMAP is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
-- 
1.5.5


