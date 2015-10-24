From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap soc clean-up for v4.4 merge window
Date: Sat, 24 Oct 2015 13:42:10 -0700
Message-ID: <20151024204209.GB892@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/soc-clean-up

for you to fetch changes up to ef4da0c1c8f3ca3e9dcf6936bf687a32cd62f293:

  Merge tag 'for-v4.4/omap-hwmod-cleanup-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.4/soc (2015-10-23 18:13:38 -0700)

----------------------------------------------------------------
Minimal omap SoC changes for v4.4 merge window. As we've spent quite a
bit of time sorting out regressions for v4.3 and are very late with
these, I've kept the changes down to minimum:

- A series of timer changes from Felipe Balbi to get us closer to
  moving the remaining timer code into drivers

- A series of hwmod clean-up changes queued by Paul Walmsley

- SoC detection clean-up to use soc_is instead of cpu_is as CPU is
  within the SoC and is confusing naming. The rest we can now change
  along with the other clean-up

----------------------------------------------------------------
Felipe Balbi (13):
      arm: omap2: timer: always define omap4_local_timer_init
      arm: omap2: timer: get rid of obfuscating macros
      arm: omap2: timer: add a gptimer argument to sync32k_timer_init()
      arm: omap2: timer: remove __omap_gptimer_init()
      arm: omap2: timer: provide generic sync32k_timer_init function
      arm: omap2: timer: move realtime_counter_init() around
      arm: omap2: timer: always call clocksource_of_init() when DT
      arm: omap2: timer: rename omap_sync32k_timer_init()
      clocksource: add TI 32.768 Hz counter driver
      arm: omap2+: select 32k clocksource driver
      arm: omap2: timer: limit hwmod usage to non-DT boots
      clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
      arm: omap2: board-generic: use omap4_local_timer_init for AM437x

Franklin S Cooper Jr (2):
      ARM: DRA7/AM335x/AM437x: hwmod: Remove elm address space from hwmod data
      ARM: DRA7/AM335x/AM437x: hwmod: Remove gpmc address space from hwmod data

Javier Martinez Canillas (1):
      ARM: OMAP: Remove duplicated operand in OR operation

Keerthy (1):
      ARM: OMAP: Change all cpu_is_* occurences to soc_is_* for id.c

Suman Anna (3):
      ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
      ARM: DRA7: hwmod data: Remove spinlock hwmod addrs
      ARM: OMAP3: hwmod data: Remove legacy mailbox data and addrs

Tony Lindgren (3):
      ARM: OMAP2+: Rename cpu_is macros to soc_is
      Merge branch 'for-tony' of git://git.kernel.org/.../balbi/usb into omap-for-v4.4/soc
      Merge tag 'for-v4.4/omap-hwmod-cleanup-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.4/soc

 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/board-generic.c                |  12 +-
 arch/arm/mach-omap2/board-ldp.c                    |   2 +-
 arch/arm/mach-omap2/board-rx51.c                   |   2 +-
 arch/arm/mach-omap2/common.h                       |   3 +-
 arch/arm/mach-omap2/id.c                           |  30 ++--
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  20 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  29 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  10 --
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   3 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  30 ----
 arch/arm/mach-omap2/soc.h                          | 195 +++++++++++----------
 arch/arm/mach-omap2/timer.c                        | 162 ++++++++---------
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-ti-32k.c                 | 126 +++++++++++++
 16 files changed, 339 insertions(+), 295 deletions(-)
 create mode 100644 drivers/clocksource/timer-ti-32k.c
