From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 0/9] USB Host support for OMAP5 uEVM (for 3.14)
Date: Thu, 9 Jan 2014 17:38:14 +0530
Message-ID: <1389269303-30465-1-git-send-email-rogerq@ti.com>
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
To: bcousson@baylibre.com, tony@atomide.com
Cc: mark.rutland@arm.com, m.paolino@virtualopensystems.com, arnd@arndb.de, devicetree@vger.kernel.org, sre@debian.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Benoit & Tony,

This patchset brings up USB Host ports and Ethernet port on
the OMAP5 uEVM board.

It depends on the TI Clock DT conversion patches [1] and is based
on 3.13-rc7

[1] - http://article.gmane.org/gmane.linux.ports.arm.kernel/289895

NOTE: I've tested this only on the OMAP5 uEVM board. Since the patchset
changes could affect OMAP3/4, it must be verified at least on
a Beagleboard and a Panda board before being pulled in.
I request someone to verify this on OMAP3/4 since I don't have access
to those boards at the moment. Thanks.

Changelog:

v5:
- Expose all clocks in the DT binding document for mfd:omap-usb-host
and mfd:omap-usb-tll

v4:
- Updated DT binding document for clock binding

v3:
- Rebased on top of 3.13-rc7

cheers,
-roger

Roger Quadros (9):
  mfd: omap-usb-host: Use resource managed clk_get()
  mfd: omap-usb-host: Get clocks based on hardware revision
  mfd: omap-usb-host: Update DT clock binding information
  mfd: omap-usb-tll: Update DT clock binding information
  ARM: dts: omap4: Update omap-usb-host node
  ARM: dts: omap5: Update omap-usb-host node
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock
  ARM: OMAP2+: Remove legacy_init_ehci_clk()

 .../devicetree/bindings/mfd/omap-usb-host.txt      |  23 +++
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |  10 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
 arch/arm/boot/dts/omap4.dtsi                       |   6 +
 arch/arm/boot/dts/omap5-uevm.dts                   |   8 +-
 arch/arm/boot/dts/omap5.dtsi                       |   6 +
 arch/arm/mach-omap2/pdata-quirks.c                 |  16 --
 drivers/mfd/omap-usb-host.c                        | 172 ++++++++++-----------
 8 files changed, 128 insertions(+), 121 deletions(-)

-- 
1.8.3.2
