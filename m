From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap soc updates for v4.8 merge window, part 2
Date: Tue,  5 Jul 2016 00:56:53 -0700
Message-ID: <24390.1583519348$1467705483@news.gmane.org>
References: <pull-1467702709-538742>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1467702709-538742>
In-Reply-To: <pull-1467702709-538742>
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

The following changes since commit 44e7475d40eb26b8d3a6e2b2f7a5f12a5fe0942e:

  ARM: OMAP2+: Fix build if CONFIG_SMP is not set (2016-06-27 23:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/soc-pt2-signed

for you to fetch changes up to 183e2077d007aa4b697efba095ecfea7244a6107:

  ARM: AM33xx: fix module_wait_ready without clkctrl register (2016-07-04 07:15:47 -0700)

----------------------------------------------------------------
Few more omap SoC changes for v4.8 merge window:

- Fix a make randconfig build error for recent SMP kexec changes

- A series of clock related fixes to prepare things for moving
  device clkctrl register handling to drivers/clk

----------------------------------------------------------------
Tero Kristo (5):
      ARM: OMAP2+: omap_device: create clock alias purely from DT data
      ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
      ARM: OMAP2+: timer: change order of hwmod data handling
      ARM: OMAP2+: clockdomain: add usecounting support to autoidle APIs
      ARM: AM33xx: fix module_wait_ready without clkctrl register

Tony Lindgren (1):
      ARM: OMAP2+: Fix build with CONFIG_SMP and CONFIG_PM is not set

 arch/arm/mach-omap2/Makefile              |  5 +-
 arch/arm/mach-omap2/clockdomain.c         | 36 +++++++++-----
 arch/arm/mach-omap2/clockdomain.h         |  2 +
 arch/arm/mach-omap2/cm33xx.c              |  3 ++
 arch/arm/mach-omap2/cpuidle44xx.c         |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |  2 +-
 arch/arm/mach-omap2/omap-smp.c            |  2 +-
 arch/arm/mach-omap2/omap_device.c         | 17 ++++++-
 arch/arm/mach-omap2/omap_hwmod.c          | 82 +++++++++++++++++++++++--------
 arch/arm/mach-omap2/pm.c                  |  8 +--
 arch/arm/mach-omap2/powerdomain.c         | 20 +++-----
 arch/arm/mach-omap2/timer.c               |  3 +-
 12 files changed, 123 insertions(+), 59 deletions(-)
