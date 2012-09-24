From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap platform and board related late patches for v3.7
 merge window
Date: Mon, 24 Sep 2012 14:25:52 -0700
Message-ID: <E1TGGAD-0000D1-9o@merlin.infradead.org>
References: <pull-1348521952-285145>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1348521952-285145>
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

The following changes since commit 0e70156de4c8465bfb8cb45cdc1bbc2fa474ce14:

  ARM: OMAP2+: Make omap4-keypad.h local (2012-09-20 15:04:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-late-v2-for-v3.7

for you to fetch changes up to ead53717d9ab28c942b9adf66f8c02442dbfbc8a:

  arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX (2012-09-24 10:32:39 -0700)

----------------------------------------------------------------
These board and platform related patches have been posted
quite a while ago but have somehow fallen though the cracks
as most of the focus has been making things to work with
device tree. As the first patch depends on sparse IRQ
related removal of irqs.h and related header moves, these
are based on omap-cleanup-local-headers-for-v3.7 tag.

----------------------------------------------------------------
AnilKumar Ch (1):
      ARM: OMAP2+: serial: Change MAX_HSUART_PORTS to 6

Peter Ujfalusi (1):
      ARM: OMAP4: twl-common: Support for additional devices on i2c1 bus

Yegor Yefremov (1):
      arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX

 arch/arm/Kconfig                              |    5 ++--
 arch/arm/mach-omap2/board-4430sdp.c           |   12 ++++++--
 arch/arm/mach-omap2/board-omap4panda.c        |   12 ++++++--
 arch/arm/mach-omap2/twl-common.c              |   37 ++++++++-----------------
 arch/arm/mach-omap2/twl-common.h              |    3 +-
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 6 files changed, 37 insertions(+), 34 deletions(-)
