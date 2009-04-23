From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix tusb6010 init error and compilation warning
Date: Thu, 23 Apr 2009 09:30:27 +0300
Message-ID: <1240468227-15393-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52134 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZDWG3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 02:29:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Roel Kluin <roel.kluin@gmail.com>

Fix "tusb6010 init error 5, -19" and compilation warning from function
tusb6010_platform_retime "warning: 'sysclk_ps' is used uninitialized in this
function".

I suppose commit c094ba34b8f780885d029ce3c2715a194b780e5d was meant to test
for zero fclk_ps instead of sysclk_ps.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 59c1d57..c05df28 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -185,7 +185,7 @@ int tusb6010_platform_retime(unsigned is_refclk)
 	unsigned	sysclk_ps;
 	int		status;
 
-	if (!refclk_psec || sysclk_ps == 0)
+	if (!refclk_psec || fclk_ps == 0)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;
-- 
1.6.2.1

