From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 5/9] ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
Date: Sun, 4 Aug 2013 21:57:33 +0530
Message-ID: <1375633657-6835-6-git-send-email-rnayak@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40784 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab3HDQ2o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Aug 2013 12:28:44 -0400
In-Reply-To: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

DRA7xx has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
In order for the gpiolib to detect and initialize these
and other TWL GPIOs, ARCH_NR_GPIO is set to 512 using the
kconfig default for DRA7.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 37c0f4e..b9e64f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1600,7 +1600,7 @@ config LOCAL_TIMERS
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5
+	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
-- 
1.7.9.5

