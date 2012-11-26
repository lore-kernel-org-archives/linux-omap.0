From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and OMAP4_KBD_SYSSTATUS
Date: Mon, 26 Nov 2012 16:21:19 +0530
Message-ID: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab2KZKv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 05:51:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
so remove them.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index c05f98c..d2b72b7 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -36,8 +36,6 @@
 
 /* OMAP4 registers */
 #define OMAP4_KBD_REVISION		0x00
-#define OMAP4_KBD_SYSCONFIG		0x10
-#define OMAP4_KBD_SYSSTATUS		0x14
 #define OMAP4_KBD_IRQSTATUS		0x18
 #define OMAP4_KBD_IRQENABLE		0x1C
 #define OMAP4_KBD_WAKEUPENABLE		0x20
-- 
1.7.5.4

