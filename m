From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 2/2][GIT 3/4+] Adding description to bridge debug option
Date: Fri, 15 Aug 2008 17:12:01 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530825E2F7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50667 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbYHOWMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 18:12:09 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7FMC3Nq032469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:12:08 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7FMC2um009001
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:12:03 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adding description to bridge debug option and indenting Kconfig lines

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---

Index: omapkernel/drivers/dsp/bridge/Kconfig
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/Kconfig	2008-08-15 16:00:59.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/Kconfig	2008-08-15 16:04:08.000000000 -0500
@@ -29,5 +29,7 @@
 	static power consumption of the IVA sub system.
 
 config BRIDGE_DEBUG
-       bool "DSP Bridge Debug Support"
-       depends on MPU_BRIDGE
+	bool "DSP Bridge Debug Support"
+	depends on MPU_BRIDGE
+	help
+	Say Y to enable Bridge debugging capabilities
