From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/7] omap1 ams-delta clean-up
Date: Thu, 8 Mar 2012 12:53:29 -0800
Message-ID: <E1S5kLP-0000mK-Qe@merlin.infradead.org>
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

This one contains the recently discussed omap1 ams-delta
clean-up to pull into the board branch. This removes the
last remaining section warnings for omap1, at least when
using omap1_defconfig.

As this depends on already merged omap1 branch 967809b
in arm-soc boards branch, and for a later than -rc1 to
compile on omap1, this one is based on a merge of omap1
and -rc5. So the suggested pull location is boards branch.


The following changes since commit 42392762149cba0a74c1c5b1b1bb868d86e62383:
  Tony Lindgren (1):
        Merge branch 'omap1' into ams-delta

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ams-delta

Janusz Krzysztofik (5):
      ARM: OMAP1: ams-delta: fix incorrect section tags
      ARM: OMAP1: ams-delta: clean up init data section assignments
      ARM: OMAP1: ams-delta: set up regulator over modem reset GPIO pin
      ARM: OMAP1: ams-delta: update the modem to use regulator API
      ASoC: OMAP: ams-delta: drop .set_bias_level callback

 arch/arm/mach-omap1/Kconfig                       |    2 +
 arch/arm/mach-omap1/board-ams-delta.c             |  116 +++++++++++++++++----
 arch/arm/plat-omap/include/plat/board-ams-delta.h |    1 -
 drivers/input/serio/ams_delta_serio.c             |    2 +-
 drivers/mtd/nand/ams-delta.c                      |    2 +-
 drivers/video/omap/lcd_ams_delta.c                |    2 +-
 sound/soc/omap/ams-delta.c                        |   32 ------
 7 files changed, 101 insertions(+), 56 deletions(-)
