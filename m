From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 linux-next 2/4] arm: configs: davinci_all_defconfig: Change CONFIG_REMOTEPROC  from m to y
Date: Fri, 20 Sep 2019 13:29:44 +0530
Message-ID: <20190920075946.13282-3-j-keerthy@ti.com>
References: <20190920075946.13282-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920075946.13282-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, nsekhar@ti.com, olof@lixom.net, t-kristo@ti.com, catalin.marinas@arm.com, will@kernel.org, tony@atomide.com
Cc: s-anna@ti.com, hch@lst.de, bjorn.andersson@linaro.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 6334150e9a36 ("remoteproc: don't allow modular build")
changes CONFIG_REMOTEPROC to a boolean from a tristate config
option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
a module in compiling the remoteproc and dependent config options.

So fix the davinci_all_defconfig to have CONFIG_REMOTEPROC built in.

Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b34970ce6b31..01e3c0f4be92 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -228,7 +228,7 @@ CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_COMMON_CLK_PWM=m
-CONFIG_REMOTEPROC=m
+CONFIG_REMOTEPROC=y
 CONFIG_DA8XX_REMOTEPROC=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
-- 
2.17.1
