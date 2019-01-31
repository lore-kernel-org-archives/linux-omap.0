From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] dts changes for omaps for v5.1
Date: Thu, 31 Jan 2019 08:23:56 -0800
Message-ID: <pull-1548951676-587288@atomide.com-3>
References: <pull-1548951676-587288@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1548951676-587288@atomide.com>
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-signed

for you to fetch changes up to b4c30df0eb354d8e081132b7b7449f6d17619614:

  ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot (2019-01-24 08:23:43 -0800)

----------------------------------------------------------------
dts updates for omap variants for v5.1 merge window

This series contains board specific dts updates and few minor
clean-up changes:

- add stdout-path for am335x-chiliboard

- add wlcore wakeirq for omap3-evm, pandaboard and omap4-droid4

- remove unnecessary address-cells and io-cells for am33xx

- replace deprecated linux,wakeup with wakeup-source property

- use spdx license for am335x-shc

- configure ethernet pins for omap4-sdp

----------------------------------------------------------------
Felix Brack (1):
      ARM: dts: am33xx: Remove unnecessary properties

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: Switch to SPDX identifier

Marcin Niestroj (1):
      ARM: dts: am335x-chiliboard: Add stdout-path property

Peter Ujfalusi (1):
      ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot

Sudeep Holla (1):
      ARM: dts: am437x: replace linux,wakeup with wakeup-source property

Tony Lindgren (4):
      ARM: dts: Add wlcore wakeirq for omap3-evm
      ARM: dts: Configure wlcore wakeirq for pandaboard
      ARM: dts: omap4-droid4: Configure wlcore wakeirq
      Merge branch 'omap-for-v4.21/dt' into omap-for-v5.1/dt

 arch/arm/boot/dts/am335x-chiliboard.dts           |  4 +++
 arch/arm/boot/dts/am335x-shc.dts                  |  4 +--
 arch/arm/boot/dts/am33xx-l4.dtsi                  |  2 --
 arch/arm/boot/dts/am437x-gp-evm.dts               |  2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi           |  7 ++++--
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 10 +++++++-
 arch/arm/boot/dts/omap4-droid4-xt894.dts          | 10 +++++---
 arch/arm/boot/dts/omap4-panda-common.dtsi         |  6 +++--
 arch/arm/boot/dts/omap4-sdp.dts                   | 30 +++++++++++++++++++++++
 9 files changed, 61 insertions(+), 14 deletions(-)
