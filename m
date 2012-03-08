From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 7/7] minimal omap board updates for upcoming merge window
Date: Thu, 8 Mar 2012 12:53:29 -0800
Message-ID: <E1S5kMR-0001GD-Jj@merlin.infradead.org>
References: <pull-1331240009-558004>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1331240009-558004>
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

This one contains minimal updates to existing board
files so people can use the mainline kernel easier.

Note that the board-omap4panda.c changes have a minor merge
conflict in the ASoC tree in next/master.


The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
  Linus Torvalds (1):
        Linux 3.3-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap board

Aaro Koskinen (1):
      ARM: OMAP: add minimal support for Nokia RM-696

Alex (1):
      ARM: OMAP: Add omap_reserve functionality

Grazvydas Ignotas (1):
      ARM: OMAP: pandora: add support for backlight and poweroff

Igor Grinberg (1):
      ARM: OMAP3: cm-t3517: add EMAC support

Ilya Yanok (1):
      ARM: OMAP: move generic EMAC init to separate file

Mircea Gherzan (1):
      ARM: OMAP: enable Bluetooth on the PandaBoard

Uwe Kleine-Knig (1):
      ARM: OMAP4: board-4430sdp: don't initialize value that is never used

Vladimir Zapolskiy (1):
      ARM: OMAP3: RX-51: add explicit mux configuration of tsc2005 control gpios

 arch/arm/mach-omap2/Kconfig                  |    3 +-
 arch/arm/mach-omap2/Makefile                 |    3 +
 arch/arm/mach-omap2/am35xx-emac.c            |  117 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/am35xx-emac.h            |   15 ++++
 arch/arm/mach-omap2/board-4430sdp.c          |    5 +-
 arch/arm/mach-omap2/board-am3517evm.c        |  117 +-------------------------
 arch/arm/mach-omap2/board-cm-t3517.c         |    2 +
 arch/arm/mach-omap2/board-omap3logic.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c     |   11 +++
 arch/arm/mach-omap2/board-omap4panda.c       |    6 ++
 arch/arm/mach-omap2/board-rm680.c            |   14 +++-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   25 +++---
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 13 files changed, 192 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 create mode 100644 arch/arm/mach-omap2/am35xx-emac.h
