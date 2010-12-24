From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] TWD: enable one-shot mode
Date: Fri, 24 Dec 2010 19:18:55 +0000
Message-ID: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36582 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0LXTTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 14:19:49 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codea>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org

Allow one shot timer mode to be used with the TWD.  This allows
NOHZ mode to be used on SMP systems using the TWD localtimer.

Tested on Versatile Express.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Acks/Tested-by's would be appreciated, thanks.

Merry Christmas.

 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5634dce..4a6c4d7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1282,6 +1282,7 @@ config HAVE_ARM_SCU
 config HAVE_ARM_TWD
 	bool
 	depends on SMP
+	select TICK_ONESHOT
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
