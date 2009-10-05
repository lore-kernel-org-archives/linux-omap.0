From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 4/4] [OMAP1] Make ARCH_OMAP850 select ARCH_OMAP_OTG
Date: Mon, 5 Oct 2009 07:51:43 -0700
Message-ID: <6cb013310910050751v5e6d0cd6o3763e56d7c10e8ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:62640 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbZJEOwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 10:52:39 -0400
Received: by ywh3 with SMTP id 3so3022187ywh.22
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 07:52:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The ARCH_OMAP850 configuration option should enable ARCH_OMAP_OTG
in the same way that the ARCH_OMAP730 option does.  This patch
addresses that.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 0341d7b..27f4897 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -11,6 +11,7 @@ config ARCH_OMAP850
 	depends on ARCH_OMAP1
 	bool "OMAP850 Based System"
 	select CPU_ARM926T
+	select ARCH_OMAP_OTG

 config ARCH_OMAP15XX
 	depends on ARCH_OMAP1
-- 
1.5.6.3
