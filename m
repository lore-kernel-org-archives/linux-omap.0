From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Drop omap hwmod legacy resources
Date: Tue, 29 Aug 2017 10:29:55 -0700
Message-ID: <20170829173001.20358-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are changes to drop hwmod legacy resources for dma, irq and io.

Note that these are against current next and needs the following
two sets of fixes in preparation:

[PATCH 00/17] Fix missing device tree hwmods and IO ranges omap variants
[PATCH 0/5] Fixes for omap hwmod for dropping legacy data

These are naturally too late for v4.14 merge window but might be
doable for v4.15.

Regards,

Tony


Tony Lindgren (6):
  ARM: OMAP2+: Populate legacy resources for dma and smartreflex
  ARM: OMAP3: Remove legacy IRQ for PRM
  ARM: OMAP4: Remove legacy IRQ for PRM
  ARM: OMAP2+: Drop omap_hwmod_irq_info
  ARM: OMAP2+: Drop omap_hwmod_dma_info
  ARM: OMAP2+: Drop legacy struct omap_hwmod_addr_space

 arch/arm/mach-omap2/Makefile                       |   1 -
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |  24 -
 arch/arm/mach-omap2/omap_device.c                  | 269 ++++------
 arch/arm/mach-omap2/omap_device.h                  |   4 -
 arch/arm/mach-omap2/omap_hwmod.c                   | 444 +----------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  62 ---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  27 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  15 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   6 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 100 ----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  39 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  43 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 548 ---------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  20 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  38 --
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  44 --
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  41 --
 arch/arm/mach-omap2/prcm-common.h                  |   1 -
 arch/arm/mach-omap2/prm.h                          |   2 -
 arch/arm/mach-omap2/prm3xxx.c                      |  14 +-
 arch/arm/mach-omap2/prm44xx.c                      |  21 +-
 arch/arm/mach-omap2/prm_common.c                   |  12 +-
 25 files changed, 107 insertions(+), 1673 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c

-- 
2.14.1
