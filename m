From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap coccinelle warning fixes for v4.15 merge window
Date: Mon, 30 Oct 2017 09:41:14 -0700
Message-ID: <pull-1509381562-551838@atomide.com-2>
References: <pull-1509381562-551838@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1509381562-551838@atomide.com>
In-Reply-To: <pull-1509381562-551838@atomide.com>
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

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/coccinelle-signed

for you to fetch changes up to d9ecbef39438391dcee511e17b6f65a970b28639:

  ARM: OMAP3: Delete an unnecessary variable initialisation in omap3xxx_hwmod_init() (2017-10-25 09:54:08 -0700)

----------------------------------------------------------------
Few coccinelle robot clean-up patches for careless human coding
issues for v4.15 merge window sent by their human operatorrrrrs.

----------------------------------------------------------------
Bhumika Goyal (1):
      ARM: omap1: add const and initconst to omap_lcd_config

Markus Elfring (2):
      ARM: OMAP3: Use common error handling code in omap3xxx_hwmod_init()
      ARM: OMAP3: Delete an unnecessary variable initialisation in omap3xxx_hwmod_init()

 arch/arm/mach-omap1/board-ams-delta.c      |  2 +-
 arch/arm/mach-omap1/board-fsample.c        |  2 +-
 arch/arm/mach-omap1/board-h2.c             |  2 +-
 arch/arm/mach-omap1/board-h3.c             |  2 +-
 arch/arm/mach-omap1/board-htcherald.c      |  2 +-
 arch/arm/mach-omap1/board-innovator.c      |  4 ++--
 arch/arm/mach-omap1/board-nokia770.c       |  2 +-
 arch/arm/mach-omap1/board-osk.c            |  2 +-
 arch/arm/mach-omap1/board-palmte.c         |  2 +-
 arch/arm/mach-omap1/board-palmtt.c         |  2 +-
 arch/arm/mach-omap1/board-palmz71.c        |  2 +-
 arch/arm/mach-omap1/board-perseus2.c       |  2 +-
 arch/arm/mach-omap1/board-sx1.c            |  2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 18 +++++++++---------
 14 files changed, 23 insertions(+), 23 deletions(-)
