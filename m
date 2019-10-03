From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 0/4] Convert all btwilink users to hci_ll and drop btwilink
Date: Thu,  3 Oct 2019 15:41:43 +0200
Message-ID: <20191003134147.9458-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

Hi,

This moves the remaining users of btwilink to the "new" serdev based hci_ll
driver and drops the btwilink driver afterwards. The patches were only compile
tested by me, but Enric tested the IGEP platform and Adam will test the LogicPD
platform.

I kept the TI_ST driver for now, since I plan to send a second patchset for the
FM radio driver. Once the FM driver has been converted to also use hci_ll, we
can remove TI_ST completly.

My suggestion is for the patch handling is, that everything simply goes through
Tony's tree.

Changes since PATCHv1 [0]
 * rebase to 5.4-rc1
 * move FM radio patches into separate patchset

[0] https://lore.kernel.org/lkml/20181221011752.25627-1-sre@kernel.org/

-- Sebastian

Sebastian Reichel (4):
  ARM: dts: LogicPD Torpedo: Add WiLink UART node
  ARM: dts: IGEP: Add WiLink UART node
  ARM: OMAP2+: pdata-quirks: drop TI_ST/KIM support
  Bluetooth: btwilink: drop superseded driver

 .../boot/dts/logicpd-torpedo-37xx-devkit.dts  |   8 +
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts    |   8 +
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts    |   8 +
 arch/arm/mach-omap2/pdata-quirks.c            |  52 ---
 drivers/bluetooth/Kconfig                     |  11 -
 drivers/bluetooth/Makefile                    |   1 -
 drivers/bluetooth/btwilink.c                  | 337 ------------------
 7 files changed, 24 insertions(+), 401 deletions(-)
 delete mode 100644 drivers/bluetooth/btwilink.c

-- 
2.23.0
