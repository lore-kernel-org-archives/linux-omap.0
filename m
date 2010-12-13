From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] arm: omap: update mach-types for rm680
Date: Mon, 13 Dec 2010 16:16:35 +0530
Message-ID: <1292237195-5695-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab0LMKqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 05:46:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>

Temporary hack to update mach-types for rm680; without
this the master branch of linux-omap will be broken for
omap2plus_defconfig builds.

Nyet-Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Tony,

Not sure how this is handled normally. Do you sync up
mach-types with Russell's tree, or locally apply a patch
like the one below?

- Anand

 arch/arm/tools/mach-types |    1 +
 1 file changed, 1 insertion(+)

Index: ehci/arch/arm/tools/mach-types
===================================================================
--- ehci.orig/arch/arm/tools/mach-types
+++ ehci/arch/arm/tools/mach-types
@@ -3044,3 +3044,4 @@ harvest_desoto		MACH_HARVEST_DESOTO	HARV
 msm8x60_qrdc		MACH_MSM8X60_QRDC	MSM8X60_QRDC		3060
 spear900		MACH_SPEAR900		SPEAR900		3061
 pcontrol_g20		MACH_PCONTROL_G20	PCONTROL_G20		3062
+nokia_rm680		MACH_NOKIA_RM680	NOKIA_RM680		3220
