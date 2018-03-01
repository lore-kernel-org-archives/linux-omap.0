From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] ARM: omap2plus_defconfig: Select MFD_TI_LMU
Date: Thu,  1 Mar 2018 14:16:57 -0800
Message-ID: <20180301221704.104530-4-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

We have REGULATOR_LM363X selected but not MFD_TI_LMU and
REGULATOR_LM363X depends on MFD_TI_LMU.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -295,6 +295,7 @@ CONFIG_OMAP_WATCHDOG=m
 CONFIG_TWL4030_WATCHDOG=m
 CONFIG_MFD_CPCAP=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
+CONFIG_MFD_TI_LMU=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TI_LP873X=y
-- 
2.16.2
