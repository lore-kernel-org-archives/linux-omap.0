From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] DSP: Fix up dspgateway when building n800 kernel images
Date: Tue, 18 Mar 2008 14:37:16 +0200
Message-ID: <1205843836-19121-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21797 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYCRMjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 08:39:19 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2ICdvtQ017899
	for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2008 07:41:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

A missing include file. Thanks to Tony Lindgren for
pointing that out.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/dspgateway/dsp_ctl_core.c |    1 +
 drivers/dsp/dspgateway/taskwatch.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/dspgateway/dsp_ctl_core.c b/drivers/dsp/dspgateway/dsp_ctl_core.c
index 956ef26..3c13572 100644
--- a/drivers/dsp/dspgateway/dsp_ctl_core.c
+++ b/drivers/dsp/dspgateway/dsp_ctl_core.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <asm/io.h>
 #include "dsp.h"
 
 #define CTL_MINOR	0
diff --git a/drivers/dsp/dspgateway/taskwatch.c b/drivers/dsp/dspgateway/taskwatch.c
index 4297b51..0fab20e 100644
--- a/drivers/dsp/dspgateway/taskwatch.c
+++ b/drivers/dsp/dspgateway/taskwatch.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <asm/arch/dsp.h>
+#include <asm/io.h>
 #include "dsp_mbcmd.h"
 #include "dsp.h"
 
-- 
1.5.4.4.481.g5075

