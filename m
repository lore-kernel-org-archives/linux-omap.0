From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP2+: remove duplicated include from board-omap3stalker.c
Date: Sun, 7 Oct 2012 21:25:03 +0800
Message-ID: <CAPgLHd-DH3T=WxZqSBF0hHAsJbqC2Kw0K-+R9GLT8dtKsFfYjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:53067 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2JGNZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 09:25:04 -0400
Received: by mail-qc0-f180.google.com with SMTP id v28so2197582qcm.11
        for <linux-omap@vger.kernel.org>; Sun, 07 Oct 2012 06:25:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-omap3stalker.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index c7f3d02..731235e 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -48,11 +48,6 @@
 #include <video/omap-panel-tfp410.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/input/matrix_keypad.h>
-#include <linux/spi/spi.h>
-#include <linux/interrupt.h>
-#include <linux/smsc911x.h>
-#include <linux/i2c/at24.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mux.h"

