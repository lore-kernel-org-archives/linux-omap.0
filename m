From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/3] omap3: Fix typo on IGEP v2 board
Date: Wed, 18 Nov 2009 19:13:23 +0100
Message-ID: <1258568004-6993-2-git-send-email-eballetbo@gmail.com>
References: <1258568004-6993-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:51262 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbZLNR6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 12:58:43 -0500
Received: by ey-out-2122.google.com with SMTP id d26so922506eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 09:58:42 -0800 (PST)
In-Reply-To: <1258568004-6993-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 10eafa7..8726638 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -139,7 +139,7 @@ config MACH_CM_T35
 	select OMAP_MUX
 
 config MACH_IGEP0020
-	bool "IGEP0020"
+	bool "IGEP v2 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select OMAP_PACKAGE_CBB
 
-- 
1.5.4.3

