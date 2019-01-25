From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] dts fixes for omaps for v5.0-rc cycle
Date: Fri, 25 Jan 2019 08:51:49 -0800
Message-ID: <pull-1548435073-725543@atomide.com>
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc3

for you to fetch changes up to 063c20e12f8bbbc10cabc2413606b140085beb62:

  ARM: dts: am335x-shc.dts: fix wrong cd pin level (2019-01-23 16:14:33 -0800)

----------------------------------------------------------------
Device tree fixes for omaps for v5.0-rc cycle

This series of dts fixes for omap devices fixes several device specific
regressions:

- The onenand timings for n950/n9 have been wrong for a while since
  we moved to dts based timings

- A typo for the cpcap pmic is now producing erors during boot as the
  level should be 0 for unconfigurable triggering instead of 1

- Changes for ti-sysc for omap5 left uart3 with debug flags that should
  not be set

- Fix a new dtc warning started showing up for omap3-gta04 grap_port

- With the generic MMC card detection code we need to fix the gpio
  in dts for n900 and am335x-shc

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: dts: N950/N9: fix onenand timings

Arthur Demchenkov (1):
      ARM: dts: n900: fix mmc1 card detect gpio polarity

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: fix wrong cd pin level

Tony Lindgren (3):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      ARM: dts: Remove unnecessary idle flags for omap5 uart3
      ARM: dts: omap3-gta04: Fix graph_port warning

 arch/arm/boot/dts/am335x-shc.dts               |  2 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi             |  4 ---
 arch/arm/boot/dts/omap3-n900.dts               |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi           | 42 +++++++++++++++++---------
 arch/arm/boot/dts/omap5-l4.dtsi                |  2 --
 6 files changed, 31 insertions(+), 23 deletions(-)
