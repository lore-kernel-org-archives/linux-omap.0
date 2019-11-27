From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap dts fixes for v5.5 merge window
Date: Wed, 27 Nov 2019 08:06:27 -0800
Message-ID: <pull-1574870758-237468@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit abb0e36b434d784864fe0e4d5dedd17f4d72f3e3:

  ARM: dts: logicpd-torpedo: Disable USB Host (2019-11-11 13:03:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/dt-fixes-merge-window-signed

for you to fetch changes up to 3e5c3c41ae925458150273e2f74ffbf999530c5f:

  ARM: dts: Fix sgx sysconfig register for omap4 (2019-11-25 07:40:01 -0800)

----------------------------------------------------------------
Device tree fixes for omap variants for for v5.5 merge window

This series of changes contains fixes for few SoC and board specific
issues that would be good to have merged for v5.5-rc1:

- Fix incorrect MMC card detection polarity for omap3-tao3530

- Fix wrong am57xx-beagle-x15 pinmux named states for eMMC

- Fix dra7 cpsw mdio clock that causes wrong speed

- Fix vcsi for droid4 so it won't get turned off after init

- Fix rev and sysconfig register offsets for omap4 sgx so it can idle

Then there are also two minor late changes to logicpd-torpedo-baseboard
to configure 1-wire HDQ for battery stats, and remove out of date
workaround comments no longer needed.

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: logicpd-torpedo-baseboard:  Enable HDQ
      ARM: dts: logicpd-torpedo: Remove unnecessary notes/comments

Faiz Abbas (1):
      ARM: dts: am57xx-beagle-x15: Update pinmux name to ddr_3_3v

Grygorii Strashko (1):
      ARM: dts: dra7: fix cpsw mdio fck clock

Jarkko Nikula (1):
      ARM: dts: omap3-tao3530: Fix incorrect MMC card detection GPIO polarity

Tony Lindgren (2):
      ARM: dts: Fix vcsi regulator to be always-on for droid4 to prevent hangs
      ARM: dts: Fix sgx sysconfig register for omap4

 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts        |  2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts         |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                       |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts |  1 -
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi     | 13 ++++++++++++-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi       |  4 ++--
 arch/arm/boot/dts/omap3-tao3530.dtsi                 |  2 +-
 arch/arm/boot/dts/omap4.dtsi                         |  4 ++--
 8 files changed, 20 insertions(+), 10 deletions(-)
