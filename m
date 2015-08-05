From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] ARM: omap2plus_defconfig: make PCF857x built-in
Date: Wed, 5 Aug 2015 19:13:49 +0530
Message-ID: <1438782229-25118-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

One of the lines from PCF857x is connected to the vdd line of MMC1
in DRA74x and DRA72x EVMs and is modelled as a regulator. If PCF857x
is not made as built-in, the regulator_get in omap_hsmmc fails making
it difficult to use MMC1 as rootfs.

Make PCF857x built-in.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ac521e7..7cedfe9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -236,7 +236,7 @@ CONFIG_SSI_PROTOCOL=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PCF857X=m
+CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_GPIO_PALMAS=y
 CONFIG_W1=m
-- 
1.7.9.5
