From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 5/5] ARM: omap2plus_defconfig: Add CONFIG_ARM_CPUIDLE
Date: Thu, 12 Dec 2019 21:07:55 -0600
Message-ID: <20191213030755.16096-6-d-gerlach@ti.com>
References: <20191213030755.16096-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191213030755.16096-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add CONFIG_ARM_CPUIDLE and supporting CONFIG_DT_IDLE_STATES as am335x
and am437x will make use of these drivers.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8c37cc8ab6f2..84c2423cbe89 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -56,6 +56,8 @@ CONFIG_CPUFREQ_DT=m
 # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
 CONFIG_ARM_TI_CPUFREQ=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
+CONFIG_DT_IDLE_STATES=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
 CONFIG_ARM_CRYPTO=y
-- 
2.20.1
