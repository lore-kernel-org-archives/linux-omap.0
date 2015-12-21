From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] omap soc changes for v4.5 merge window
Date: Mon, 21 Dec 2015 13:06:34 -0800
Message-ID: <33851.128727156$1450732058@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/soc-initcall

for you to fetch changes up to f2e6a0a913b53f5af87c7e9a783ceae5bb4ae2c4:

  ARM: OMAP2+: Remove device creation for omap-pcm-audio (2015-12-17 10:34:41 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.5 merge window. The main change here is to
change the omap initcall levels a bit to initialize things later to allow
early device drivers at core_initcall level. This makes things easier
for us as most clocks can be made into regular device drivers except for
a few early clocks needed to initialize system timers. I wanted to have
these changes sit in Linux next for a few weeks before sending out a pull
request, and so far now issues have showed up.

The other changes in this series are timer changes for making use of the
new PWM driver, and timer changes to support more high security SoCs.
Also few minor improvments for module autoidle settings for ti81xx spinbox
and dra7 debug on uart4 in hwmod code. The rest is pretty much just removal
of platform data for SoCs that are all device tree only nowadays.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: RX-51: fix a typo in log writing

Franklin S Cooper Jr (1):
      ARM: omap4: hwmod: Remove elm address space from hwmod data

J.D. Schroeder (1):
      ARM: DRA7: hwmod: Enable DEBUG_LL for UART4

Neil Armstrong (3):
      ARM: OMAP: dmtimer: Add clock source from DT
      ARM: OMAP: add DT support for ti,dm816-timer
      ARM: OMAP2+: Add hwmod spinbox support for dm816x

Peter Ujfalusi (2):
      ARM: OMAP1: Remove device creation for omap-pcm-audio
      ARM: OMAP2+: Remove device creation for omap-pcm-audio

Suman Anna (6):
      ARM: OMAP2+: Remove legacy device instantiation of IOMMUs
      ARM: OMAP3: hwmod data: Remove legacy IOMMU data
      ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
      ARM: OMAP2+: Remove omap_mmu_dev_attr structure
      ARM: OMAP: dmtimer: check for fixed timers during config
      ARM: OMAP2+: timer: Remove secure timer for DRA7xx HS devices

Tony Lindgren (2):
      ARM: OMAP2+: Change core_initcall levels to postcore_initcall
      Merge branch 'omap-for-v4.5/initcall' into omap-for-v4.5/soc-v2

 arch/arm/mach-omap1/devices.c                | 19 --------
 arch/arm/mach-omap2/Makefile                 |  2 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |  2 +-
 arch/arm/mach-omap2/devices.c                | 25 ++---------
 arch/arm/mach-omap2/omap-iommu.c             | 66 ----------------------------
 arch/arm/mach-omap2/omap2-restart.c          |  2 +-
 arch/arm/mach-omap2/omap_device.c            |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |  2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   | 42 ------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   | 41 -----------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c    |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c   | 35 +++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c           |  2 +-
 arch/arm/mach-omap2/serial.c                 |  2 +-
 arch/arm/mach-omap2/timer.c                  |  6 +--
 arch/arm/plat-omap/dmtimer.c                 | 42 +++++++++++++++++-
 include/linux/platform_data/iommu-omap.h     |  9 ----
 17 files changed, 90 insertions(+), 211 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-iommu.c
