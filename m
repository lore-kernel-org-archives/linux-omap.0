From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 linux-next 3/4] arm: configs: multi_v7_defconfig: Change CONFIG_REMOTEPROC  from m to y
Date: Fri, 20 Sep 2019 13:29:45 +0530
Message-ID: <20190920075946.13282-4-j-keerthy@ti.com>
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

So fix the multi_v7_defconfig to have CONFIG_REMOTEPROC built in.

Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 13ba53286901..198de8e36d92 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -933,7 +933,7 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
-CONFIG_REMOTEPROC=m
+CONFIG_REMOTEPROC=y
 CONFIG_ST_REMOTEPROC=m
 CONFIG_RPMSG_VIRTIO=m
 CONFIG_ASPEED_LPC_CTRL=m
-- 
2.17.1
