From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 3/4] ARM: OMAP1: remove duplicated #include
Date: Tue, 16 Jun 2009 16:56:21 +0800
Message-ID: <1245142581-3260-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:64614 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbZFPI4a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 04:56:30 -0400
Received: by pzk17 with SMTP id 17so2550006pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 01:56:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include in arch/arm/mach-omap1/board-nokia770.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index e70fc7c..ff24c90 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -36,7 +36,6 @@
 #include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
-#include <mach/usb.h>
 #include <mach/clock.h>
 
 #define ADS7846_PENDOWN_GPIO	15
-- 
1.6.1.3

