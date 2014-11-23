From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] part 2 of omap dts changes for v3.19
Date: Sat, 22 Nov 2014 16:44:50 -0800
Message-ID: <22592.4865845174$1416703583@news.gmane.org>
References: <pull-1416703431-245942>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1416703431-245942>
In-Reply-To: <pull-1416703431-245942>
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

The following changes since commit 065bd7fe50de5e6d0fd5034cbc87120a558a1219:

  ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v3.19/dt-v2

for you to fetch changes up to 0f39f7b906dbeabe2ffd8739d5201e890d102ea6:

  ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and am43x-epos-evm (2014-11-21 16:25:06 -0800)

----------------------------------------------------------------
Adam YH Lee (1):
      ARM: dts: Gumstix DuoVero: Bind vdac regulator to hdmi node

Dmitry Lifshitz (6):
      ARM: dts: cm-t3x: cleanup comments indentation
      ARM: dts: cm-t3x: add ADS7846 touchscreen support
      ARM: OMAP2+: remove cm-t3x touchscreen pdata quirk
      ARM: dts: cm-t3x: add EEPROM support
      ARM: dts: sb-t35: add EEPROM support
      ARM: dts: cm-t3x30: add keypad support

George McCollister (1):
      ARM: dts: Add devicetree for NovaTech OrionLXm

Lokesh Vutla (1):
      ARM: dts: DRA7: Add node for RTC

Sebastian Reichel (2):
      ARM: dts: OMAP3-N900: add si4713 support
      ARM: dst: OMAP3-N900: Add n900-battery support

Vignesh R (1):
      ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and am43x-epos-evm

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/am335x-lxm.dts                   | 362 +++++++++++++++++++++
 arch/arm/boot/dts/am4372.dtsi                      |  20 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                |   8 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   8 +
 arch/arm/boot/dts/dra7.dtsi                        |   9 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  76 ++++-
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi              |  17 +
 arch/arm/boot/dts/omap3-n900.dts                   |  16 +
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |  20 ++
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |   1 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   3 -
 13 files changed, 536 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-lxm.dts
