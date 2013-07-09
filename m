From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 8/8] ARM: DRA7: Kconfig: Increase the default gpio count
Date: Tue, 9 Jul 2013 12:57:53 +0530
Message-ID: <1373354873-12359-9-git-send-email-rnayak@ti.com>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51020 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab3GIH24 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:28:56 -0400
In-Reply-To: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

DRA7xx has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
In order for the gpiolib to detect and initialize these
additional GPIOs and other TWL GPIOs, ARCH_NR_GPIO is set
to 512 instead of present 256.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ef7af0..9faed52 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1599,7 +1599,7 @@ config LOCAL_TIMERS
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 512 if SOC_OMAP5
+	default 512 if SOC_OMAP5 || SOC_DRA7XX
 	default 512 if ARCH_KEYSTONE
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
-- 
1.7.9.5

