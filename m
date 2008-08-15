From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [RESEND][PATCH 2/2][GIT 3/4+] Adding description to bridge debug
 option
Date: Fri, 15 Aug 2008 17:24:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530825E2FF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYHOWYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 18:24:45 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7FMOdjt007143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:24:44 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7FMOcxM023258
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:24:39 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Please ignore the previous patch.


Adding description to bridge debug option and indenting Kconfig lines

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---

Index: omapkernel/drivers/dsp/bridge/Kconfig
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/Kconfig	2008-08-13 22:52:00.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/Kconfig	2008-08-15 17:25:34.000000000 -0500
@@ -6,28 +6,31 @@
 	tristate "DSP Bridge driver"
 	default n
 	help
-	DSP/BIOS Bridge is designed for platforms that contain a GPP and one or
-	more attached DSPs.  The GPP is considered the master or "host" processor,
-	and the attached DSPs are processing resources that can be utilized by
-	applications and drivers running on the GPP.
+	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
+	  one or more attached DSPs.  The GPP is considered the master or
+	  "host" processor, and the attached DSPs are processing resources
+	  that can be utilized by applications and drivers running on the GPP.
 
 config DISABLE_BRIDGE_DVFS
 	bool "Disable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
 	depends on MPU_BRIDGE
 	default y
 	help
-	DVFS allows DSP Bridge to initiate the operating point change to scale
-	the chip voltage and frequency in order to match the performance and
-	power consumption to the current processing requirements.
+	  DVFS allows DSP Bridge to initiate the operating point change to
+	  scale the chip voltage and frequency in order to match the
+	  performance and power consumption to the current processing
+	  requirements.
 
 config DISABLE_BRIDGE_PM
 	bool "Disable Bridge Power Management"
 	depends on MPU_BRIDGE && PM
 	default y
 	help
-	DSP Bridge employs power management techniques to save dynamic and
-	static power consumption of the IVA sub system.
+	  DSP Bridge employs power management techniques to save dynamic and
+	  static power consumption of the IVA sub system.
 
 config BRIDGE_DEBUG
-       bool "DSP Bridge Debug Support"
-       depends on MPU_BRIDGE
+	bool "DSP Bridge Debug Support"
+	depends on MPU_BRIDGE
+	help
+	  Say Y to enable Bridge debugging capabilities
