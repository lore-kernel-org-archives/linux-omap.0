From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] drop selected platform data for am3 and am4
Date: Tue, 26 Mar 2019 11:13:20 -0700
Message-ID: <20190326181324.32140-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the pending patches for ti-sysc interconnect target module driver,
we can now drop legacy platform data for selected devices.

This series depends on the following pathces:

[PATCH 0/7] omap changes to allocate struct omap_hwmod dynamically
[PATCH 00/14] ti-sysc changes to probe devices with dts data only

Additionally am3 depends on the following fix:

[PATCH] ARM: dts: Fix dcan clkctrl clock for am3


Tony Lindgren (4):
  ARM: OMAP2+: Drop mmc platform data for am330x and am43xx
  ARM: OMAP2+: Drop i2c platform data for am33xx and am43xx
  ARM: OMAP2+: Drop gpio platform data for am33xx and am43xx
  ARM: OMAP2+: Drop uart platform data for am33xx and am43xx

 .../omap_hwmod_33xx_43xx_common_data.h        |  29 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  | 103 -------
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 253 ------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  64 -----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    | 113 --------
 5 files changed, 562 deletions(-)

-- 
2.21.0
