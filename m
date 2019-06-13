From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] dts changes for omap variants for v5.3
Date: Thu, 13 Jun 2019 00:10:51 -0700
Message-ID: <pull-1560399818-512977@atomide.com-2>
References: <pull-1560399818-512977@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1560399818-512977@atomide.com>
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

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/dt-signed

for you to fetch changes up to 8f62581f820d32eec9698e477ddff21ebfbe0541:

  Merge branch 'baltos' into omap-for-v5.3/dt (2019-06-12 00:57:27 -0700)

----------------------------------------------------------------
dts changes for omap variants for v5.3

This series of changes improves support for few boards:

- configure another lcd type for logicpd torpedo devkit

- a series of updates for am335x phytec boards

- configure mmc card detect pin for am335x-baltos

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: Add LCD type 28 support to LogicPD Torpedo DM3730 devkit

Daniel Schultz (1):
      ARM: dts: am335x-phycore-som: Add emmc node

Teresa Remmet (5):
      ARM: dts: am335x phytec boards: Remove regulator node
      ARM: dts: am335x-phycore-som: Enable gpmc node in dts files
      ARM: dts: am335x-pcm-953: Update user led names
      ARM: dts: am335x-pcm-953: Remove eth phy delay
      ARM: dts: Add support for phyBOARD-REGOR-AM335x

Tony Lindgren (1):
      Merge branch 'baltos' into omap-for-v5.3/dt

Yegor Yefremov (2):
      ARM: dts: am335x-baltos: Fix PHY mode for ethernet
      ARM: dts: am335x-baltos: add support for MMC1 CD pin

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |  14 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |  14 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |  13 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi              |  22 +-
 arch/arm/boot/dts/am335x-phycore-rdk.dts           |   4 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  47 +++--
 arch/arm/boot/dts/am335x-regor-rdk.dts             |  24 +++
 arch/arm/boot/dts/am335x-regor.dtsi                | 223 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-wega-rdk.dts              |   4 +
 arch/arm/boot/dts/am335x-wega.dtsi                 |  16 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit-28.dts    |  32 +++
 13 files changed, 372 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-regor-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-regor.dtsi
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
