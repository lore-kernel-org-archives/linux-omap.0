From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap intc changes for v3.18 merge window
Date: Thu, 11 Sep 2014 16:28:56 -0700
Message-ID: <33595.3942420476$1410478223@news.gmane.org>
References: <pull-1410478051-378788>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1410478051-378788>
In-Reply-To: <pull-1410478051-378788>
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

The following changes since commit 176da6c766ce3d5d8c88a7afdaefcc5fd6d8afac:

  arm: omap: irq: make omap_irq_base global (2014-09-11 13:03:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/intc-for-v3.18

for you to fetch changes up to 55601c9f24670ba926ebdd4d712ac3b177232330:

  arm: omap: intc: switch over to linear irq domain (2014-09-11 13:05:50 -0700)

----------------------------------------------------------------
Interrupt code related clean-up for omap2 and 3 to make
it ready to move to drivers/irqchip. Note that this series
does not yet move the interrupt code to drivers, that will
be posted separately as a follow-up series.

Note that this branch has a dependency to patches both
in fixes-v3.18-not-urgent and soc-for-v3.18 and is based on
a merge. Without doing the merge, off-idle would not work
properly for git bisect.

----------------------------------------------------------------
Felipe Balbi (28):
      arm: omap: irq: define INTC_ILR0 register
      arm: omap: irq: start to remove irq_banks array
      arm: omap: irq: add a global omap_nr_irqs variable
      arm: omap: irq: remove rest of irq_banks usage
      arm: omap: irq: remove unused macro
      arm: omap: irq: switch over to intc_readl on omap_intc_handle_irq
      arm: omap: irq: remove unnecessary base_addr argument
      arm: omap: irq: rename omap3_intc_regs
      arm: omap: irq: always define omap3 support
      arm: omap: irq: reorganize code a little bit
      arm: omap: irq: make intc_of_init static
      arm: omap: irq: call set_handle_irq() from intc_of_init
      arm: omap: irq: use IRQCHIP_DECLARE macro
      arm: omap: irq: drop .handle_irq and .init_irq fields
      arm: omap: irq: add specific compatibles for omap3 and am33xx devices
      arm: omap: irq: use compatible flag to figure out number of IRQ lines
      arm: boot: dts: am33xx/omap3: fix intc compatible flag
      arm: omap: irq: drop ti,intc-size support
      arm: boot: dts: omap2/3/am33xx: drop ti,intc-size
      arm: omap: irq: move some more code around
      arm: omap: irq: call set_handle_irq() from .init_irq
      arm: omap: irq: drop omap3_intc_handle_irq()
      arm: omap: irq: drop omap2_intc_handle_irq()
      arm: omap: irq: remove unnecessary header
      arm: omap: irq: remove nr_irqs argument
      arm: omap: irq: introduce omap_nr_pending
      arm: omap: irq: get rid of ifdef hack
      arm: omap: intc: switch over to linear irq domain

 arch/arm/boot/dts/am33xx.dtsi              |   3 +-
 arch/arm/boot/dts/omap2.dtsi               |   1 -
 arch/arm/boot/dts/omap3.dtsi               |   3 +-
 arch/arm/mach-omap2/board-3430sdp.c        |   1 -
 arch/arm/mach-omap2/board-am3517crane.c    |   1 -
 arch/arm/mach-omap2/board-am3517evm.c      |   1 -
 arch/arm/mach-omap2/board-cm-t35.c         |   2 -
 arch/arm/mach-omap2/board-cm-t3517.c       |   1 -
 arch/arm/mach-omap2/board-devkit8000.c     |   1 -
 arch/arm/mach-omap2/board-generic.c        |  14 -
 arch/arm/mach-omap2/board-ldp.c            |   1 -
 arch/arm/mach-omap2/board-omap3beagle.c    |   1 -
 arch/arm/mach-omap2/board-omap3logic.c     |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c   |   1 -
 arch/arm/mach-omap2/board-omap3stalker.c   |   1 -
 arch/arm/mach-omap2/board-omap3touchbook.c |   1 -
 arch/arm/mach-omap2/board-overo.c          |   1 -
 arch/arm/mach-omap2/board-rx51.c           |   1 -
 arch/arm/mach-omap2/common.h               |  13 -
 arch/arm/mach-omap2/irq.c                  | 409 +++++++++++++++--------------
 20 files changed, 213 insertions(+), 246 deletions(-)
