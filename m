From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 linux-next 1/4] arm: configs: omap2plus_defconfig: Change CONFIG_REMOTEPROC from m to y
Date: Fri, 20 Sep 2019 13:29:43 +0530
Message-ID: <20190920075946.13282-2-j-keerthy@ti.com>
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

So fix the omap2plus_defconfig to have CONFIG_REMOTEPROC built in.

Fixes: commit 6334150e9a3646 ("remoteproc: don't allow modular build")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 64eb896907bf..af4069476582 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -481,7 +481,7 @@ CONFIG_RTC_DRV_OMAP=m
 CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
 CONFIG_OMAP_IOMMU=y
-CONFIG_REMOTEPROC=m
+CONFIG_REMOTEPROC=y
 CONFIG_OMAP_REMOTEPROC=m
 CONFIG_WKUP_M3_RPROC=m
 CONFIG_SOC_TI=y
-- 
2.17.1
