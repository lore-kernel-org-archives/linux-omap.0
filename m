From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap dts changes for v4.17, part 2
Date: Thu, 22 Mar 2018 09:43:44 -0700
Message-ID: <pull-1521736966-849602@atomide.com-2>
References: <pull-1521736966-849602@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1521736966-849602@atomide.com>
In-Reply-To: <pull-1521736966-849602@atomide.com>
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

The following changes since commit 47eee072bf90374ce98a15668e6b450de313100a:

  ARM: dts: omap4-droid4: add soundcard (2018-03-02 12:55:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/dt-pt2-signed

for you to fetch changes up to 984c7706ff180e33096c57183435d925cb644576:

  ARM: dts: omap4-droid4: Configure uart1 pins (2018-03-20 08:13:38 -0700)

----------------------------------------------------------------
Second set of dts changes for omap variants for v4.17

This series of patches configures few new drivers and adds
omap5 specific nodes:

- Enable USB OTG mode for xhci on am437x

- A series of changes to configure aux control module instance
  on omap5 mostly to get the audio clocks configured

- A series of changes to update droid4 for MDM6600 modem USB PHY
  and UART1 pinctrl

----------------------------------------------------------------
Peter Ujfalusi (1):
      ARM: dts: omap5-board-common: Add phandle for mclk clock for twl6040

Roger Quadros (1):
      ARM: dts: am43xx: Enable dual-role mode for USB1

Tero Kristo (3):
      dt-bindings: omap5: ctrl: Support for control module wkup pad config
      ARM: dts: omap5: add support for control module wkup pad config
      ARM: dts: omap5: add fref_xtal_ck support

Tony Lindgren (3):
      ARM: dts: omap4-droid4: Fix USB PHY port naming
      ARM: dts: omap4-droid4: Configure MDM6600 USB PHY
      ARM: dts: omap4-droid4: Configure uart1 pins

 .../devicetree/bindings/arm/omap/ctrl.txt          |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 103 ++++++++++++++++++++-
 arch/arm/boot/dts/omap5-board-common.dtsi          |   4 +-
 arch/arm/boot/dts/omap5.dtsi                       |  22 +++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |  10 ++
 8 files changed, 138 insertions(+), 8 deletions(-)
