From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND/PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ numbering
Date: Tue, 17 May 2011 02:46:12 +0300
Message-ID: <1305589572-5812-2-git-send-email-balbi@ti.com>
References: <1305589572-5812-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35115 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718Ab1EPXq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 19:46:27 -0400
Received: by mail-bw0-f45.google.com with SMTP id 16so60513bwz.32
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 16:46:26 -0700 (PDT)
In-Reply-To: <1305589572-5812-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

Select HAVE_SPARSE_IRQ to allow OMAP to use
sparse IRQ numbering scheme. The main difference
is that irq_descs will be added to a radix tree
instead of a static array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 416b02f..d5e2571 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -861,6 +861,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.4.1.343.ga91df

