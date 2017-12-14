From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] dts changes for omaps for v4.16 merge window
Date: Thu, 14 Dec 2017 07:58:27 -0800
Message-ID: <pull-1513266986-900907@atomide.com-3>
References: <pull-1513266986-900907@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1513266986-900907@atomide.com>
In-Reply-To: <pull-1513266986-900907@atomide.com>
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

The following changes since commit bc686442f8a601bccac1f22506ecdb4b0d62cadd:

  Merge branch 'dts-fixes' into omap-for-v4.15/fixes-dt (2017-11-28 08:12:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-signed

for you to fetch changes up to a38867305203ef5a27f0c9ff1e943a0c2fabdbce:

  ARM: dts: Move move WiFi bindings to logicpd-torpedo-37xx-devkit (2017-12-11 09:43:53 -0800)

----------------------------------------------------------------
Dts related changes for omaps for v4.16 merge window

These changes are mostly improvments for various devices.
Note that these are based on my earlier fixes branch
omap-for-v4.15/fixes-dt to avoid a pointless merge conflict
between a fix and removal. The summary of changes is:

- Fix audio codec reset pin for am335x-pepper and n900, this
  has been always broken and won't get fixed until the related
  driver changes are also merged in for v4.16, so not urgent

- Fix tps65917 powerhold property for dra76-evm

- Changes to logicpd boards to remove MTD partition information
  and to add support for omap35xx variants by setting up common
  dts files for the logicpd boards

- Disable dra7 USB metastability workaround, this won't do
  anything until the related driver changes are also merged
  into v4.16, so not urgent

----------------------------------------------------------------
Adam Ford (6):
      ARM: dts: omap3: logicpd kits: Remove partition information
      ARM: dts: Move most of logicpd-som-lv-37xx-devkit.dts to logicpd-som-lv-baseboard.dtsi
      ARM: dts: Add minimal support for LogicPD OMAP35xx SOM-LV devkit
      ARM: dts: Move most of logicpd-torpedo-37xx-devkit to logicpd-torpedo-baseboard
      ARM: dts: Add minimal support for LogicPD OMAP35xx Torpedo devkit
      ARM: dts: Move move WiFi bindings to logicpd-torpedo-37xx-devkit

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Keerthy (1):
      ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Peter Ujfalusi (1):
      ARM: dts: dra7: Add missing hdmi audio DMA channel information

Roger Quadros (1):
      ARM: dts: dra7: Disable USB metastability workaround for USB2

Tony Lindgren (1):
      Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.16/dt

 arch/arm/boot/dts/am335x-pepper.dts               |   2 +-
 arch/arm/boot/dts/dra7.dtsi                       |   3 +
 arch/arm/boot/dts/dra76-evm.dts                   |   1 +
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts  |  17 +
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts  | 249 +------------
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi   | 256 ++++++++++++++
 arch/arm/boot/dts/logicpd-som-lv.dtsi             |  27 --
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts |  17 +
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 411 +++-------------------
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi  | 395 +++++++++++++++++++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |  84 -----
 arch/arm/boot/dts/omap3-n900.dts                  |   4 +-
 12 files changed, 735 insertions(+), 731 deletions(-)
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
