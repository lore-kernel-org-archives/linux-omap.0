From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
Date: Tue,  4 Jan 2011 11:39:26 +0200
Message-ID: <1294133966-20279-3-git-send-email-balbi@ti.com>
References: <1294133966-20279-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51933 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab1ADJjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 04:39:41 -0500
Received: by mail-yw0-f52.google.com with SMTP id 9so5342322ywf.39
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 01:39:41 -0800 (PST)
In-Reply-To: <1294133966-20279-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

select HAVE_SPARSE_IRQ and irq_descs can be added
to a radix tree instead of an array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..c4ffe2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -826,6 +826,8 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.3.4.598.g85356

