From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/4] Motorola Droid 4: Add WL1285C support
Date: Wed,  3 May 2017 16:22:22 +0200
Message-ID: <20170503142226.32380-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>, Kalle Valo <kvalo@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

Motorola Droid 4 uses a WL1285C, as visible on iFixit [0]. This
fixes the DT file to use correct compatible for the wifi node
and adds the bluetooth node.

[0] https://www.ifixit.com/Teardown/Motorola+Droid+4+Teardown/7759#s31961

Changes to PATCHv1:
 - use proper compatible value for bluetooth / shared transport
 - add patches fixing wlcore compatible for Droid 4

-- Sebastian

Sebastian Reichel (4):
  wlcore: add wl1285 compatible
  ARM: dts: omap4-droid4: Use wl1285 for wifi compatible
  Bluetooth: hci_ll: Add compatible values for more WL chips
  ARM: dts: omap4-droid4: Add bluetooth

 .../devicetree/bindings/net/ti,wilink-st.txt       |  6 ++++++
 .../devicetree/bindings/net/wireless/ti,wlcore.txt |  1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 22 +++++++++++++++++++++-
 drivers/bluetooth/hci_ll.c                         |  8 ++++++++
 drivers/net/wireless/ti/wlcore/sdio.c              |  1 +
 drivers/net/wireless/ti/wlcore/spi.c               |  1 +
 6 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.11.0
