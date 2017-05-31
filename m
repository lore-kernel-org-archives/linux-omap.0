From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Remove unused omap legacy code
Date: Wed, 31 May 2017 15:51:28 -0700
Message-ID: <20170531225139.30723-1-tony@atomide.com>
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

Hi all,

We can now remove quite a bit of clutter with legacy booting
gone. Basically anything with of_have_populated_dt() not set
can now go.

Regards,

Tony

Tony Lindgren (11):
  ARM: OMAP2+: Remove unused legacy code for opp
  ARM: OMAP2+: Remove unused legacy code for timer
  ARM: OMAP2+: Remove unused legacy code for PMU
  ARM: OMAP2+: Remove unused legacy code for device init
  ARM: OMAP2+: Remove unused legacy code for McBSP
  ARM: OMAP2+: Remove unused legacy code for io.c
  ARM: OMAP2+: Remove unused legacy code for DMA
  ARM: OMAP2+: Remove unused legacy code for PRM
  ARM: OMAP2+: Remove unused legacy code for interconnects
  ARM: OMAP2+: Remove unused legacy code for watchdog
  ARM: OMAP2+: Remove unused legacy code for n8x0

 arch/arm/mach-omap2/Makefile               |   4 -
 arch/arm/mach-omap2/board-n8x0.c           |  14 +--
 arch/arm/mach-omap2/devices.c              | 163 ---------------------------
 arch/arm/mach-omap2/dma.c                  |  30 +----
 arch/arm/mach-omap2/io.c                   |  59 +++-------
 arch/arm/mach-omap2/mcbsp.c                |  70 ------------
 arch/arm/mach-omap2/omap_device.c          |   5 +-
 arch/arm/mach-omap2/omap_hwmod.c           |  23 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   3 +-
 arch/arm/mach-omap2/opp.c                  | 104 -----------------
 arch/arm/mach-omap2/opp3xxx_data.c         |  86 ---------------
 arch/arm/mach-omap2/opp4xxx_data.c         |  79 -------------
 arch/arm/mach-omap2/pmu.c                  |  97 ----------------
 arch/arm/mach-omap2/prm3xxx.c              |  17 ++-
 arch/arm/mach-omap2/prm44xx.c              |  59 ----------
 arch/arm/mach-omap2/prm_common.c           |   9 +-
 arch/arm/mach-omap2/timer.c                | 172 ++++-------------------------
 arch/arm/mach-omap2/wd_timer.c             |  28 -----
 18 files changed, 63 insertions(+), 959 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/opp.c
 delete mode 100644 arch/arm/mach-omap2/pmu.c

-- 
2.13.0
