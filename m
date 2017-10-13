From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] soc changes for omaps for v4.15 merge window
Date: Fri, 13 Oct 2017 09:39:00 -0700
Message-ID: <pull-1507912705-793554@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/soc-signed

for you to fetch changes up to 28fd7e99257c7d8ff41544a6ee23c96cc10799e0:

  ARM: OMAP: Fix typos in two comment lines in _omap_dm_timer_request() (2017-10-11 11:13:20 -0700)

----------------------------------------------------------------
SoC changes for omaps for v4.15 merge window that are mostly non-urgent
fixes and clean-up in preparation for dropping more platform data later
on:

- Fix am33xx/am437x MMC address space offsets

- Fix overwriting clkctrl and modulemode values when dts data is
  used

- Drop unused platform init code for omap_init_hdq

- Drop unused struct omap_hwmod_mux_info

- Remove duplicate define for dra722 es1.0 silicon revision

- Add support for dra71x es2.1

- Make omap_dma_dev_info __initdata

- A series of fixes for Coccinelle found issues

----------------------------------------------------------------
Bhumika Goyal (1):
      ARM: OMAP2+: make omap_dma_dev_info __initdata

Markus Elfring (4):
      ARM: OMAP: Delete an error message for a failed memory allocation in two functions
      ARM: OMAP: Improve a size determination in two functions
      ARM: OMAP: Use kcalloc() in omap_system_dma_probe()
      ARM: OMAP: Fix typos in two comment lines in _omap_dm_timer_request()

Tony Lindgren (4):
      ARM: OMAP2+: Fix MMC address space mismatch for am33xx and am43xx
      ARM: OMAP2+: Fix overwriting of clkctrl and modulemode values
      ARM: OMAP2+: Drop unused omap_init_hdq
      ARM: OMAP2+: Drop unused omap_hwmod_mux_info

Vishal Mahaveer (2):
      ARM: DRA722: remove redundant definition of 1.0 device
      ARM: DRA722: Add support for DRA71x Silicon Rev 2.1

 arch/arm/mach-omap2/dma.c                          |  2 +-
 arch/arm/mach-omap2/hdq1w.c                        | 22 ----------
 arch/arm/mach-omap2/id.c                           |  5 ++-
 arch/arm/mach-omap2/omap_hwmod.c                   | 49 ++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod.h                   | 21 ++--------
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 30 -------------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  6 +--
 arch/arm/mach-omap2/soc.h                          |  2 +-
 arch/arm/plat-omap/dma.c                           | 12 +++---
 arch/arm/plat-omap/dmtimer.c                       | 10 ++---
 10 files changed, 62 insertions(+), 97 deletions(-)
