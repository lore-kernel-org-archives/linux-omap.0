From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] omap board changes for v3.6 merge window
Date: Tue, 10 Jul 2012 06:05:55 -0700
Message-ID: <E1SoaCS-0001W5-7h@merlin.infradead.org>
References: <pull-1341925556-888624>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341925556-888624>
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

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-for-v3.6

for you to fetch changes up to b103a2e22a238085f5c50d96345e1a09bb1efd50:

  ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS support (2012-07-09 23:22:24 -0700)

----------------------------------------------------------------
Board and platform data related changes for omaps

----------------------------------------------------------------
Andy Gross (1):
      omap2+: add drm device

Dmitry Lifshitz (2):
      ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
      ARM: OMAP3: cm-t35: add tvp5150 decoder support

Peter Ujfalusi (2):
      ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
      ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2

Tony Lindgren (1):
      ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS support

Zumeng Chen (4):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      ARM: OMAP3530evm: set pendown_state and debounce time for ads7846

 arch/arm/mach-omap2/Makefile                       |    4 +
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +
 arch/arm/mach-omap2/board-cm-t35.c                 |   89 ++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c               |   78 ++++++++++++++++-
 arch/arm/mach-omap2/board-omap4panda.c             |    3 +
 arch/arm/mach-omap2/common-board-devices.c         |   18 +++-
 arch/arm/mach-omap2/common-board-devices.h         |    1 +
 arch/arm/mach-omap2/drm.c                          |   61 ++++++++++++++
 drivers/staging/omapdrm/omap_drv.h                 |    2 +-
 .../linux/platform_data/omap_drm.h                 |   19 ++---
 10 files changed, 263 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-omap2/drm.c
 rename drivers/staging/omapdrm/omap_priv.h => include/linux/platform_data/omap_drm.h (81%)
