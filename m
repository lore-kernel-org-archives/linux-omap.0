From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap late timer clean-up (and a warning fix) for v3.8
 merge window
Date: Mon, 26 Nov 2012 17:06:11 -0800
Message-ID: <9931.29347120902$1353978426@news.gmane.org>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:

  Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-timer-signed

for you to fetch changes up to 26f01998b0657a61167a819f1c37cb9f9e9d674b:

  ARM: OMAP3: cm-t3517: use GPTIMER for system clock (2012-11-21 10:20:43 -0800)

----------------------------------------------------------------
Timer clean-up to get us closer to moving timer code to drivers,
and to get rid of CONFIG_OMAP_32K_TIMER and rely on the board
or devicetree provided timer configuration.

Note that these changes are on top of the recent timer fixes.

----------------------------------------------------------------
Igor Grinberg (2):
      ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
      ARM: OMAP3: cm-t3517: use GPTIMER for system clock

Jon Hunter (8):
      ARM: OMAP: Clean-up dmtimer reset code
      ARM: OMAP: Define omap_dm_timer_prepare function as static
      ARM: OMAP: Don't store timers physical address
      ARM: OMAP2+: Remove unnecessary local variable in timer code
      ARM: OMAP: Remove unnecessary omap_dm_timer structure declaration
      ARM: OMAP: Add platform data header for DMTIMERs
      ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
      ARM: OMAP2+: Fix compiler warning for 32k timer

Tony Lindgren (1):
      Merge branch 'cleanup-timer' of git://github.com/jonhunter/linux into omap-for-v3.8/timer

 arch/arm/mach-omap1/timer.c                |   1 +
 arch/arm/mach-omap1/timer32k.c             |   1 -
 arch/arm/mach-omap2/board-cm-t3517.c       |   2 +-
 arch/arm/mach-omap2/common.h               |   1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   1 -
 arch/arm/mach-omap2/pm-debug.c             |   1 -
 arch/arm/mach-omap2/timer.c                | 167 +++++++++++++----------------
 arch/arm/plat-omap/Kconfig                 |   6 ++
 arch/arm/plat-omap/dmtimer.c               |  54 ++++++----
 arch/arm/plat-omap/include/plat/dmtimer.h  |  80 ++++----------
 drivers/staging/tidspbridge/core/ue_deh.c  |   1 -
 include/linux/platform_data/dmtimer-omap.h |  31 ++++++
 13 files changed, 168 insertions(+), 179 deletions(-)
 create mode 100644 include/linux/platform_data/dmtimer-omap.h
