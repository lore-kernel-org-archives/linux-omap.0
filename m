From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 3/3] arm: Kconfig: allow OMAP to use sparse IRQ numbering
Date: Thu, 20 Jan 2011 08:43:32 +0200
Message-ID: <1295505812-5062-4-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53718 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab1ATGoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:44:03 -0500
Received: by mail-yw0-f42.google.com with SMTP id 5so68468yws.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:44:02 -0800 (PST)
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Select HAVE_SPARSE_IRQ to allow OMAP to use
sparse IRQ numbering scheme. The main difference
is that irq_descs will be added to a radix tree
instead of a static array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c231192..d0b5b26 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -858,6 +858,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.4.rc2

