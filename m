From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 4/9] OMAP: Devkit8000: Remove unnecessary include file
Date: Wed, 24 Mar 2010 13:52:13 +0100
Message-ID: <1269435138-27192-5-git-send-email-weber@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
In-Reply-To: <1269435138-27192-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Remove include otg.h.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index cf90fe0..33880f1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -50,7 +50,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/usb/otg.h>
 #include <linux/dm9000.h>
 #include <linux/interrupt.h>
 
-- 
1.6.4.4

