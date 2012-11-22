From: Igor Mazanov <i.mazanov@gmail.com>
Subject: [PATCH v2] ARM: OMAP2+: omap2plus_defconfig: Enable TPS65217 PMIC
Date: Thu, 22 Nov 2012 19:45:28 +0400
Message-ID: <50AE4898.8030308@gmail.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, b-cousson@ti.com, anilkumar@ti.com
List-Id: linux-omap@vger.kernel.org

  The BeagleBone platform uses TPS65217 PMIC to control
  voltages on the board. This patch enables TPS65217 MFD and
  regulator drivers in omap2plus_defconfig.

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
  arch/arm/configs/omap2plus_defconfig |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig 
b/arch/arm/configs/omap2plus_defconfig
index 6230304..69ddbf7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -132,9 +132,11 @@ CONFIG_POWER_SUPPLY=y
  CONFIG_WATCHDOG=y
  CONFIG_OMAP_WATCHDOG=y
  CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_TPS65217=y
  CONFIG_REGULATOR_TWL4030=y
  CONFIG_REGULATOR_TPS65023=y
  CONFIG_REGULATOR_TPS6507X=y
+CONFIG_REGULATOR_TPS65217=y
  CONFIG_FB=y
  CONFIG_FIRMWARE_EDID=y
  CONFIG_FB_MODE_HELPERS=y
--
1.7.4.4
