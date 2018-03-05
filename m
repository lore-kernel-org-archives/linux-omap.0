From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/6] omap timer changes for v4.17
Date: Mon,  5 Mar 2018 10:11:02 -0800
Message-ID: <pull-1520273005-304551@atomide.com-2>
References: <pull-1520273005-304551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com>
In-Reply-To: <pull-1520273005-304551@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 2fdc82776ac2ac49c5ee666d834718ac36420e49:

  Merge branch 'omap-for-v.16/dmtimer-fix' into omap-for-v4.17/timer (2018-02-22 10:46:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/timer-signed

for you to fetch changes up to 58a54f03e73d67432216931854363e4ba15839b9:

  clocksource: timer-ti-dm: Check prescaler value (2018-02-28 13:41:30 -0800)

----------------------------------------------------------------
Move omap timer to drivers for 4.17

This series from Keerthy and Ladislav Michl move omap dmtimer code
to drivers. As we don't want to export custom timer functions to
random drivers, we also need to update the related PWM driver to
pass the timer specific functions in platform data.

Note that this series is based on a merge of omap1 specific timer
fix and omap2+ platform data clean-up to keep things working and
make the move a bit simpler.

----------------------------------------------------------------
Keerthy (9):
      ARM: OMAP: dmtimer: Remove all the exports
      ARM: OMAP: timer: Wrap the inline functions under OMAP2PLUS define
      ARM: OMAP: Move dmtimer.h out of plat-omap
      clocksource: timer-ti-dm: Replace architecture
      ARM: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource
      clocksource: timer-ti-dm: Add timer ops to the platform data structure
      clocksource: timer-ti-dm: Populate the timer ops to the pdata
      pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
      ARM: OMAP: pdata-quirks: Remove unused timer pdata

Ladislav Michl (4):
      clocksource: timer-ti-dm: Hook device platform data if not already assigned
      clocksource: timer-ti-dm: Make unexported functions static
      clocksource: timer-ti-dm: Consolidate set source
      clocksource: timer-ti-dm: Check prescaler value

 arch/arm/mach-omap1/Kconfig                        |   1 +
 arch/arm/mach-omap1/pm.c                           |   2 +-
 arch/arm/mach-omap1/timer.c                        |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  32 ---
 arch/arm/mach-omap2/timer.c                        |   2 +-
 arch/arm/plat-omap/Kconfig                         |   6 -
 arch/arm/plat-omap/Makefile                        |   1 -
 drivers/clocksource/Kconfig                        |   3 +
 drivers/clocksource/Makefile                       |   1 +
 .../dmtimer.c => drivers/clocksource/timer-ti-dm.c | 286 ++++++++++-----------
 drivers/pwm/pwm-omap-dmtimer.c                     |  68 +++--
 .../dmtimer.h => include/clocksource/timer-ti-dm.h |  40 +--
 include/linux/platform_data/dmtimer-omap.h         |  38 +++
 13 files changed, 241 insertions(+), 241 deletions(-)
 rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-ti-dm.c (87%)
 rename arch/arm/plat-omap/include/plat/dmtimer.h => include/clocksource/timer-ti-dm.h (88%)
