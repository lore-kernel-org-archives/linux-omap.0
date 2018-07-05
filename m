From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.18-rc cycle
Date: Thu,  5 Jul 2018 01:50:20 -0700
Message-ID: <pull-1530780550-652944@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/fixes-signed

for you to fetch changes up to 0144eb204cdcdf09a76794b4a294291388e739bc:

  ARM: dts: omap3: Fix am3517 mdio and emac clock references (2018-07-03 00:39:09 -0700)

----------------------------------------------------------------
Fixes for omap for v4.18-rc cycle

Few dts fixes for regressions for various SoCs and
devices for touchscreen wake, dra7 USB quirk, pinmux
for beaglebone mmc, and emac clock.

Also included is a change for ti-sysc to use kcalloc
that Kees wanted to get into v4.18 as that's the last
one he wanted to fix for improved defense against
allocation overflows.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: Fix am3517 mdio and emac clock references

Daniel Mack (1):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source

Kees Cook (1):
      bus: ti-sysc: Use 2-factor allocator arguments

Robert Nelson (1):
      ARM: dts: am335x-bone-common: Fix mmc0 Write Protect

Roger Quadros (1):
      ARM: dts: dra7: Disable metastability workaround for USB2

Tony Lindgren (1):
      Merge branch 'omap-for-v4.19/ti-sysc' into omap-for-v4.18/fixes

 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 -
 arch/arm/boot/dts/am3517.dtsi             | 4 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts       | 2 ++
 arch/arm/boot/dts/dra7.dtsi               | 2 +-
 drivers/bus/ti-sysc.c                     | 8 ++++----
 5 files changed, 11 insertions(+), 6 deletions(-)
