From: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Subject: [PATCH 1/1] SDP2430 Fix dependency in include file
Date: Sun, 31 Aug 2008 20:57:44 -0500
Message-ID: <cb8016980808311857y693787daq8c641c785732058c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:12593 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbYIAB5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 21:57:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so253586ywe.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2008 18:57:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

TWL4030_MODIRQ_KEYPAD was undeclared, adding the required file.

Signed-off-by: Abraham Arce <abraham.arce.moreno@gmail.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c
b/arch/arm/mach-omap2/board-2430sdp.c
index 64e76e8..195d53c 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-rtc.h>

 #include <mach/hardware.h>
--
1.5.6.4
