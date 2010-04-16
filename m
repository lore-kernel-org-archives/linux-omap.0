From: Viral Mehta <viral.vkm@gmail.com>
Subject: [PATCH v2] select ARCH_OMAP_OTG for OMAP2430 SDP
Date: Fri, 16 Apr 2010 10:25:46 +0530
Message-ID: <q2w94efb1e51004152155h320f6287o1a77eb1976cb9c03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:33938 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab0DPEzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 00:55:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Configuration for OMAP2430 should select ARCH_OMAP_OTG just like
it is done for OMAP2420

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
---
One more effort,
V2: no mangling between tabs and spaces, hopefully :)

 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8a3d1e..8f9d9c9 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -10,6 +10,7 @@ config ARCH_OMAP2420
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
+	select ARCH_OMAP_OTG

 config ARCH_OMAP3430
 	bool "OMAP3430 support"
-- 
1.6.6
