From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH] OMAP4: hwmod data: remove duplicated #include
Date: Thu, 28 Jul 2011 21:35:09 +0800
Message-ID: <1311860109-5816-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47309 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab1G1Nfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 09:35:30 -0400
Received: by gxk21 with SMTP id 21so1787881gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:35:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..374edcf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -28,7 +28,6 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
-#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
-- 
1.5.6.4

