From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/7] more DT changes for upcoming merge window
Date: Thu, 8 Mar 2012 12:53:29 -0800
Message-ID: <E1S5kLz-0000yc-FQ@merlin.infradead.org>
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

Here are some more changes to the DT branch.

As these depend both on the earlier omap dt patches pulled in, and
irqdomain patches queued by Grant, Benoit based on a merge
of the two. Looks like arm-soc/next/dt already has Grant's
commit 280ad7fd, so this should not add any new dependencies.



The following changes since commit 1f52299ec000e2161635b263d81ab92ea7f1f0a7:
  Benoit Cousson (1):
        Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 into for_3.4/dt_irq_domain2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap dt-part2

Benoit Cousson (3):
      ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
      arm/dts: OMAP3: Add interrupt-controller bindings for INTC
      ARM: OMAP2+: board-generic: Use of_irq_init API

Ilya Yanok (1):
      arm/dts: mt_ventoux: very basic support for TeeJet Mt.Ventoux board

Tony Lindgren (3):
      Merge branch 'for_3.4/dt_irq_domain' of git://git.kernel.org/.../bcousson/linux-omap-dt into dt-part2
      ARM: OMAP2+: Fix build error when only ARCH_OMAP2/3 or 4 is selected
      ARM: OMAP2+: Remove extra ifdefs for board-generic

 .../devicetree/bindings/arm/omap/intc.txt          |   27 ++++++
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |   27 ++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +-
 arch/arm/mach-omap2/board-generic.c                |   99 ++++++++++----------
 arch/arm/mach-omap2/common.h                       |   12 +++
 arch/arm/mach-omap2/irq.c                          |   60 ++++++++++--
 6 files changed, 168 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
 create mode 100644 arch/arm/boot/dts/am3517_mt_ventoux.dts
