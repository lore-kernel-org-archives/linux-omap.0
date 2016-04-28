From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap soc changes for v4.7 merge window
Date: Thu, 28 Apr 2016 10:25:07 -0700
Message-ID: <14088.604579638$1461864378@news.gmane.org>
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

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/soc-signed

for you to fetch changes up to 22292b91ee1a72ce744a2bd1b0f490ffc766f0dd:

  Merge tag 'for-v4.7/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.7/soc (2016-04-22 15:15:33 -0700)

----------------------------------------------------------------
SoC related changes for omaps for v4.7 merge window:

- Remove now unnecessary multi vs single SoC compile time optimizations
  as we are now using multiarch

- Configure dra7 powerdomains

- Clarify why omap-wakeupgen does not need to handle FROZEN transitions

- Add dra7 module configuration for MaASP, PWMSS and timer 12

- Add RTC module configuration unlock and lock functions

- Fix hwmod idle state sanity check sequence

----------------------------------------------------------------
Anna-Maria Gleixner (1):
      ARM: OMAP2+: wakeupgen: Add comment for unhandled FROZEN transitions

Jonas Rabenstein (1):
      ARM: OMAP2+: remove redundant multiplatform checks

Keerthy (1):
      ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Lokesh Vutla (4):
      ARM: OMAP2+: hwmod: Fix updating of sysconfig register
      ARM: OMAP2+: hwmod: RTC: Add lock and unlock functions
      ARM: DRA7: RTC: Add lock and unlock functions
      ARM: AMx3xx: RTC: Add lock and unlock functions

Nishanth Menon (3):
      ARM: OMAP: DRA7: powerdomain data: Erratum i892 workaround: Disable core INA
      ARM: OMAP: DRA7: powerdomain data: Fix "ON" state for memories
      ARM: OMAP: DRA7: powerdomain data: Remove wrong OSWR capability

Peter Ujfalusi (1):
      ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimer 12
      ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check sequence

Tony Lindgren (1):
      Merge tag 'for-v4.7/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.7/soc

Vignesh R (1):
      ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS

 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   5 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  20 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 364 ++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  65 ++++
 arch/arm/mach-omap2/powerdomains7xx_data.c         |  82 ++---
 arch/arm/mach-omap2/soc.h                          | 140 ++------
 10 files changed, 510 insertions(+), 174 deletions(-)
