From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] omap hwmod and clock fixes for v3.7-rc1
Date: Tue, 9 Oct 2012 11:46:26 -0700
Message-ID: <E1TLepN-0002ls-Sf@merlin.infradead.org>
References: <pull-1349808387-617119>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1349808387-617119>
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

The following changes since commit 0e51793e162ca432fc5f04178cf82b80a92c2659:

  Merge branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm (2012-10-07 21:20:57 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-hwmod-clock-signed-v3

for you to fetch changes up to eb20f31f6e7d3ac19738e5a45df9b09b25381e73:

  Merge tag 'omap-fixes-a-for-pre3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.7-rc1/fixes-hwmod-clock (2012-10-09 11:07:29 -0700)

----------------------------------------------------------------

>From Paul Walmsley <paul@pwsan.com>:

Some OMAP fixes for the 3.7 merge window, fixing mismerges, branch
integration issues, and bugs after the arm-soc merges.

----------------------------------------------------------------
Jon Hunter (2):
      ARM: OMAP2+: hwmod data: Fix PMU interrupt definitions
      ARM: OMAP3: fix workaround for EMU clockdomain

Paul Walmsley (2):
      ARM: OMAP: omap3evm: fix new sparse warning
      ARM: OMAP4/AM335x: hwmod: fix disable_module regression in hardreset handling

Tony Lindgren (1):
      Merge tag 'omap-fixes-a-for-pre3.7' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.7-rc1/fixes-hwmod-clock

Vaibhav Hiremath (1):
      ARM: am33xx: clk: Update clkdev table to add mcasp alias

 arch/arm/mach-omap2/board-omap3evm.c               |    3 +-
 arch/arm/mach-omap2/clock33xx_data.c               |    2 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |   44 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod.c                   |   31 ++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 6 files changed, 54 insertions(+), 30 deletions(-)
