From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] omap changes to allocate struct omap_hwmod dynamically
Date: Mon, 25 Mar 2019 11:38:12 -0700
Message-ID: <20190325183819.15400-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

With ti-sysc interconnect target module, and clkctrl clock driver,
we can start allocating struct omap_hwmod dynamically from dts and
configure devices at module_init time. Here's a series of changes
to prepare the hwmod code for that.

Note that we also still need related changes to the ti-sysc
interconnect target module driver that I'll post separately.

Regards,

Tony


Tony Lindgren (7):
  ARM: OMAP2+: Fix potentially uninitialized return value for
    _setup_reset()
  ARM: OMAP2+: Make interconnect target module allocation functions
    static
  ARM: OMAP2+: Prepare class allocation for dynamically allocated
    modules
  ARM: OMAP2+: Define _HWMOD_STATE_DEFAULT and use it
  ARM: OMAP2+: Allocate struct omap_hwmod based on dts data
  ARM: OMAP2+: Remove hwmod .rev data and use local SoC checks instead
  ARM: OMAP2+: Handle reset quirks for dynamically allocated modules

 arch/arm/mach-omap2/common.h                  |   9 +
 arch/arm/mach-omap2/i2c.c                     |  11 +-
 arch/arm/mach-omap2/io.c                      |   7 +-
 arch/arm/mach-omap2/omap_hwmod.c              | 200 +++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod.h              |   8 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |   1 -
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 .../omap_hwmod_33xx_43xx_ipblock_data.c       |   2 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   3 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |   7 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c    |   1 -
 arch/arm/mach-omap2/sr_device.c               |   5 +-
 15 files changed, 198 insertions(+), 64 deletions(-)

-- 
2.21.0
