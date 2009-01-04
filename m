From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: omap mmc: remove duplicated #include's
Date: Sun, 04 Jan 2009 11:13:52 +0800
Message-ID: <20090104110120.C99F.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:4183 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZADDNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2009 22:13:49 -0500
Received: by ti-out-0910.google.com with SMTP id b6so9149698tic.23
        for <linux-omap@vger.kernel.org>; Sat, 03 Jan 2009 19:13:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Removed duplicated #include's in arch/arm/mach-omap1/board-voiceblue.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index c224f3c..a765354 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -22,7 +22,6 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
-#include <linux/irq.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>

