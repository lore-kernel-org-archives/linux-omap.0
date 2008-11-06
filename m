From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git] cbus build fixes
Date: Wed, 5 Nov 2008 23:13:52 -0800
Message-ID: <200811052313.52300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:37148 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752433AbYKFHNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 02:13:54 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Build fixes for CBUS stuff.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/cbus/cbus.c  |    1 +
 drivers/cbus/retu.c  |    1 +
 drivers/cbus/tahvo.c |    1 +
 3 files changed, 3 insertions(+)

--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -31,6 +31,7 @@
 
 #include <mach/gpio.h>
 #include <mach/board.h>
+#include <mach/board-nokia.h>
 
 #include <asm/io.h>
 
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -41,6 +41,7 @@
 #include <mach/mux.h>
 #include <mach/gpio.h>
 #include <mach/board.h>
+#include <mach/board-nokia.h>
 
 #include "cbus.h"
 #include "retu.h"
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -41,6 +41,7 @@
 #include <mach/mux.h>
 #include <mach/gpio.h>
 #include <mach/board.h>
+#include <mach/board-nokia.h>
 
 #include "cbus.h"
 #include "tahvo.h"
