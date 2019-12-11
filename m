From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/16] Drop legacy platform data for various omap devices
Date: Wed, 11 Dec 2019 09:19:58 -0800
Message-ID: <20191211172014.35201-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Vignesh R <vigneshr@ti.com>, Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

In order to get the l4 instances closer to being usable with genpd, we
continue dropping legacy platform data for various devices.

Please test, some patches may depend on the earlier patches to drop
platform data to apply as they touch the same files.

Regards,

Tony


Tony Lindgren (16):
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 epwmss
  ARM: OMAP2+: Drop legacy platform data for dra7 epwmss
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 spinlock
  ARM: OMAP2+: Drop legacy platform data for omap4 spinlock
  ARM: OMAP2+: Drop legacy platform data for omap5 spinlock
  ARM: OMAP2+: Drop legacy platform data for dra7 spinlock
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 spi
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 dcan
  ARM: OMAP2+: Drop legacy platform data for dra7 dcan
  ARM: OMAP2+: Drop legacy platform data for am3 adc_tsc
  ARM: OMAP2+: Drop legacy platform data for am4 adc_tsc
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 rtc
  ARM: OMAP2+: Drop legacy platform data for am3 and am4 elm
  ARM: OMAP2+: Drop legacy platform data for omap4 elm
  ARM: OMAP2+: Drop legacy platform data for dra7 elm
  ARM: OMAP2+: Drop legacy platform data for am3 lcdc

 arch/arm/boot/dts/am33xx-l4.dtsi              |  12 -
 arch/arm/boot/dts/am437x-l4.dtsi              |  19 +-
 arch/arm/boot/dts/am43x-epos-evm.dts          |   4 +
 arch/arm/boot/dts/dra7-l4.dtsi                |   5 -
 arch/arm/boot/dts/omap4-l4.dtsi               |   2 -
 arch/arm/boot/dts/omap5-l4.dtsi               |   1 -
 .../omap_hwmod_33xx_43xx_common_data.h        |  21 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  |  76 ------
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 247 ------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  85 ------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    | 183 -------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  85 ------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |  43 ---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     | 236 -----------------
 14 files changed, 5 insertions(+), 1014 deletions(-)

-- 
2.24.1
