From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] one bug fix and few other fixes for v4.17-rc cycle
Date: Fri,  4 May 2018 08:49:56 -0700
Message-ID: <pull-1525448974-362873@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

The following changes since commit fb289e3ab10c16834741bb02be740fa9d025fde0:

  Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes (2018-04-19 15:48:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/fixes-rc3

for you to fetch changes up to 647efef69de483f1dd7944ede31b4cae16acb124:

  ARM: dts: correct missing "compatible" entry for ti81xx SoCs (2018-05-03 10:07:47 -0700)

----------------------------------------------------------------
Fixes for omap variants for v4.17-rc cycle

This series of patches contains one BUG fix for trace if
CONFIG_DEBUG_PREEMPT is enabled and a regression fix for omap1
FIQ handling on ams-delta. Then there's a dts fix for missing SoC
compatible on ti81xx board dts files that did matter until we added
the clkctrl clocks and without that some clocks are now not found.

Then there are three minor logicpd-som-lv specific dts fixes that
fix misconfigured pins for WLAN, audio and USB.

----------------------------------------------------------------
Adam Ford (3):
      ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
      ARM: dts: logicpd-som-lv: Fix Audio Mute
      ARM: dts: logicpd-som-lv: Fix pinmux controller references

Graeme Smecher (1):
      ARM: dts: correct missing "compatible" entry for ti81xx SoCs

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: fix deferred_fiq handler

Tero Kristo (1):
      ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace

 arch/arm/boot/dts/dm8148-evm.dts       |  2 +-
 arch/arm/boot/dts/dm8148-t410.dts      |  2 +-
 arch/arm/boot/dts/dm8168-evm.dts       |  2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts |  2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi  | 15 +++++++++------
 arch/arm/mach-omap1/ams-delta-fiq.c    | 28 +++++++++++++++-------------
 arch/arm/mach-omap2/powerdomain.c      |  4 ++--
 7 files changed, 30 insertions(+), 25 deletions(-)
