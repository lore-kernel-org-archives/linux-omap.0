From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] cpufreq: OMAP: move to drivers/cpufreq and updates for v3.3
Date: Fri, 18 Nov 2011 13:20:23 -0800
Message-ID: <871ut5w2js.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: cpufreq@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Dave,

Here's the updated pull request after a rebase onto v3.2-rc1 and some
fixes to address other changes that went into v3.2.

This is targetted for v3.3, so I'd like to get it into your tree and
into linux-next.

Also, let me know if you want a MAINTAINERS entry for this file, as I'm
happy to maintain it.

Kevin


The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/omap-cpufreq

Colin Cross (1):
      cpufreq: OMAP: notify even with bad boot frequency

Kevin Hilman (1):
      cpufreq: OMAP: fixup for omap_device changes, include <linux/module.h>

Nishanth Menon (6):
      cpufreq: OMAP: move clk name decision to init
      cpufreq: OMAP: deny initialization if no mpudev
      cpufreq: OMAP: dont support !freq_table
      cpufreq: OMAP: only supports OPP library
      cpufreq: OMAP: put clk if cpu_init failed
      cpufreq: OMAP: fix freq_table leak

Russell King (1):
      cpufreq: OMAP: Add SMP support for OMAP4+

Santosh Shilimkar (1):
      cpufreq: OMAP: cleanup for multi-SoC support, move into drivers/cpufreq

Todd Poynor (1):
      cpufreq: OMAP: Enable all CPUs in shared policy mask

 arch/arm/plat-omap/Makefile    |    1 -
 arch/arm/plat-omap/cpu-omap.c  |  171 -------------------------
 drivers/cpufreq/Makefile       |    1 +
 drivers/cpufreq/omap-cpufreq.c |  274 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 172 deletions(-)
 delete mode 100644 arch/arm/plat-omap/cpu-omap.c
 create mode 100644 drivers/cpufreq/omap-cpufreq.c
