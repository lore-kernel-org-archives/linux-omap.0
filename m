From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] dtc warning fixes for omaps for v4.8 merge window
Date: Thu, 30 Jun 2016 00:13:01 -0700
Message-ID: <2800.86927018619$1467270848@news.gmane.org>
References: <pull-1467270686-995259>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1467270686-995259>
In-Reply-To: <pull-1467270686-995259>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 52c7c91319e469142628199548852198bcc3150f:

  ARM: dts: AM43xx: Add node for RNG (2016-06-22 00:44:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/dt-part2-signed

for you to fetch changes up to 480985b06c8e3999940929bf024042e4181bbdce:

  ARM: dts: am57xx: sbc-am57x: remove unneded unit name (2016-06-29 00:05:39 -0700)

----------------------------------------------------------------
Second set of device tree updates for omaps for v4.8 merge window.
This is a series of dtc warning fixes when compiled with make W=2
from Javier Martinez Canillas <javier@osg.samsung.com>.

----------------------------------------------------------------
Javier Martinez Canillas (27):
      ARM: dts: omap2: add missing unit name to func_96m_ck
      ARM: dts: am3517-craneboard: remove unneeded unit name for fixedregulator
      ARM: dts: dm3730-torpedo-devkit: remove unneeded unit names
      ARM: dts: n900: remove unneeded unit name for dmtimer-pwm
      ARM: dts: omap3-beagle: remove unneeded unit names
      ARM: dts: omap3-beagle-xm: remove unneeded unit names
      ARM: dts: cm-t3x: remove unneeded unit name in connector
      ARM: dts: omap3-devkit8000: remove unneeded unit names
      ARM: dts: omap3-devkit8000-lcd-common: remove unneeded unit names
      ARM: dts: omap3-gta04: remove unneeded unit names
      ARM: dts: omap3-ha-lcd: remove unneeded unit name
      ARM: dts: omap3: overo: remove unneded unit names in display nodes
      ARM: dts: omap3-igep0020-common: remove unneded unit names
      ARM: dts: omap3-overo-common-dvi: remove unneded unit names
      ARM: dts: omap3-pandora-common: remove unneded unit name
      ARM: dts: sbc-t3x30: remove unneded unit names
      ARM: dts: omap3-thunder: remove unneded unit name
      ARM: dts: omap4-duovero-parlor: remove unneded unit name
      ARM: dts: omap4-panda-common: remove unneded unit names
      ARM: dts: omap4-sdp: remove unneded unit names
      ARM: dts: omap4-var-om44customboard: remove unneded unit name
      ARM: dts: am43xx-epos-evm: remove unneded unit name
      ARM: dts: am437x-gp-evm: remove unneded unit name
      ARM: dts: am437x: cm-t43: remove unneded unit names
      ARM: dts: omap5-cm-t54: remove unneded unit names and add reg properties
      ARM: dts: omap5-board-common: remove unneded unit names
      ARM: dts: am57xx: sbc-am57x: remove unneded unit name

 arch/arm/boot/dts/am3517-craneboard.dts            |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  2 +-
 arch/arm/boot/dts/am437x-sbc-t43.dts               |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/am57xx-sbc-am57x.dts             |  2 +-
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  4 ++--
 arch/arm/boot/dts/omap24xx-clocks.dtsi             |  2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              | 10 +++++-----
 arch/arm/boot/dts/omap3-beagle.dts                 | 10 +++++-----
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     | 12 ++++++------
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  4 ++--
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  8 ++++----
 arch/arm/boot/dts/omap3-ha-lcd.dts                 |  2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |  8 ++++----
 arch/arm/boot/dts/omap3-n900.dts                   |  2 +-
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi      |  8 ++++----
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |  8 ++++----
 arch/arm/boot/dts/omap3-thunder.dts                |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 16 ++++++++--------
 arch/arm/boot/dts/omap4-sdp.dts                    |  8 ++++----
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  8 ++++----
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 15 ++++++++++-----
 31 files changed, 80 insertions(+), 75 deletions(-)
