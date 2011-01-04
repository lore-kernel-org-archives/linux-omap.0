From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] arm: Kconfig: allow OMAP to use sparse IRQ numbering
Date: Tue,  4 Jan 2011 14:02:57 +0200
Message-ID: <1294142577-28772-5-git-send-email-balbi@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41887 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1ADMDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 07:03:22 -0500
Received: by gxk27 with SMTP id 27so6275274gxk.8
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 04:03:22 -0800 (PST)
In-Reply-To: <1294142577-28772-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

Select HAVE_SPARSE_IRQ to allow OMAP to use
sparse IRQ numbering scheme. The main difference
is that irq_descs will be added to a radix tree
instead of a static array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 106d9f6..2413aa6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -820,6 +820,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.3.4.598.g85356

