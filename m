From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/6] omap HDQ1W and smartreflex driver changes for v3.6
 merge window
Date: Sun, 1 Jul 2012 02:01:16 -0700
Message-ID: <E1SlGIc-00045S-DH@merlin.infradead.org>
References: <pull-1341133277-501333>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341133277-501333>
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

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-driver-for-v3.6

for you to fetch changes up to bb0adf6ca6c78758c12b054fe3f25023033072ab:

  ARM: OMAP2+: do not allow SmartReflex to be built as a module (2012-06-29 05:54:31 -0700)

----------------------------------------------------------------
Here are omap driver changes for v3.6 that were agreed to be merged
via the omap tree. These changes convert omap HDQ1W driver to use
runtime PM, and finally move omap SmartReflex driver from arch/arm
to live under drivers.

----------------------------------------------------------------
J Keerthy (1):
      ARM: OMAP2+: Voltage: Move the omap_volt_data structure to plat

Jean Pihet (10):
      ARM: OMAP2+: SmartReflex: move the smartreflex header to include/linux/power
      ARM: OMAP3+: SmartReflex: class drivers should use struct omap_sr *
      ARM: OMAP2+: smartreflex: Use the names from hwmod data instead of voltage domains.
      ARM: OMAP3: hwmod: rename the smartreflex entries
      ARM: OMAP2+: SmartReflex: introduce a busy loop condition test macro
      ARM: OMAP2+: SmartReflex: Use per-OPP data structure
      ARM: OMAP2+: SmartReflex: Create per-opp debugfs node for errminlimit
      ARM: OMAP2+: SmartReflex: add POWER_AVS Kconfig options
      ARM: OMAP: SmartReflex: Move smartreflex driver to drivers/
      ARM: OMAP2+: do not allow SmartReflex to be built as a module

Paul Walmsley (4):
      W1: OMAP HDQ1W: allow driver to be built on all OMAP2+
      W1: OMAP HDQ1W: use 32-bit register accesses
      ARM: OMAP2+: HDQ1W: use omap_device
      W1: OMAP HDQ1W: use runtime PM

Tony Lindgren (3):
      Merge tag 'omap-devel-b-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into devel-driver
      ARM: OMAP2: Use hwmod to initialize mmc for 2420
      Merge branch 'for_3.6/pm/sr-move' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-driver

 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/devices.c                      |  108 -------------
 arch/arm/mach-omap2/hdq1w.c                        |   26 ++++
 arch/arm/mach-omap2/msdi.c                         |   73 +++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   12 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    3 +-
 arch/arm/mach-omap2/pm.h                           |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c           |   29 ++--
 arch/arm/mach-omap2/sr_device.c                    |   39 ++++-
 arch/arm/mach-omap2/voltage.h                      |   21 +--
 arch/arm/plat-omap/Kconfig                         |   31 ++--
 arch/arm/plat-omap/include/plat/voltage.h          |   21 ++-
 drivers/power/Kconfig                              |    2 +
 drivers/power/Makefile                             |    1 +
 drivers/power/avs/Kconfig                          |   12 ++
 drivers/power/avs/Makefile                         |    1 +
 .../mach-omap2 => drivers/power/avs}/smartreflex.c |  161 ++++++++------------
 drivers/w1/masters/Kconfig                         |    2 +-
 drivers/w1/masters/omap_hdq.c                      |   86 +++--------
 .../linux/power}/smartreflex.h                     |   74 +++++++--
 20 files changed, 352 insertions(+), 357 deletions(-)
 create mode 100644 drivers/power/avs/Kconfig
 create mode 100644 drivers/power/avs/Makefile
 rename {arch/arm/mach-omap2 => drivers/power/avs}/smartreflex.c (90%)
 rename {arch/arm/mach-omap2 => include/linux/power}/smartreflex.h (79%)
