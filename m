From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/6] omap soc changes for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:35 -0700
Message-ID: <E1Umpjr-0005dj-A3@merlin.infradead.org>
References: <pull-1371061475-206272>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371061475-206272>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/soc-signed

for you to fetch changes up to 4f288f081bb67813d35c10d1b2fa68e863c4b188:

  ARM: OMAP2+: AM43x: SRAM base and size (2013-06-12 08:07:23 -0700)

----------------------------------------------------------------
Omap SoC changes. Mostly improves am33xx support, and adds
minimal support for am43x SoCs.

----------------------------------------------------------------
Afzal Mohammed (8):
      ARM: OMAP2+: separate out OMAP4 restart
      ARM: OMAP2+: AM43x: Kconfig
      ARM: OMAP2+: AM43x: kbuild
      ARM: OMAP2+: AM43x: soc_is support
      ARM: OMAP2+: AM437x: SoC revision detection
      ARM: OMAP2+: AM43x: static mapping
      ARM: OMAP2+: AM43x: early init
      ARM: OMAP2+: AM43x: GP or HS ?

Philip Avinash (1):
      ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK

Roger Quadros (1):
      ARM: OMAP3: clock data: get rid of unused USB host clock aliases and dummies

Sanjeev Premi (1):
      ARM: OMAP2+: AM43x: SRAM base and size

Tony Lindgren (1):
      Merge tag 'omap-devel-b-for-3.11' of http://git.kernel.org/cgit/linux/kernel/git/pjw/omap-pending into omap-for-v3.11/soc

Vaibhav Hiremath (1):
      ARM: OMAP2+: AM33xx: Add missing reset status info to GFX hwmod

 arch/arm/mach-omap2/Kconfig                |  8 ++++++++
 arch/arm/mach-omap2/Makefile               |  8 ++++++++
 arch/arm/mach-omap2/am33xx.h               |  1 +
 arch/arm/mach-omap2/cclock33xx_data.c      | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cclock3xxx_data.c      | 11 -----------
 arch/arm/mach-omap2/cm33xx.h               |  2 +-
 arch/arm/mach-omap2/common.h               |  1 +
 arch/arm/mach-omap2/control.h              |  8 ++++++++
 arch/arm/mach-omap2/id.c                   |  8 +++++++-
 arch/arm/mach-omap2/io.c                   | 17 +++++++++++++++--
 arch/arm/mach-omap2/omap4-common.c         | 16 ----------------
 arch/arm/mach-omap2/omap4-restart.c        | 27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  3 ++-
 arch/arm/mach-omap2/soc.h                  | 23 +++++++++++++++++++++++
 arch/arm/mach-omap2/sram.c                 |  3 +++
 15 files changed, 134 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-restart.c
