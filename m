From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 00/12] extcon: Replace the deprecated extcon API
Date: Wed, 30 Nov 2016 14:57:28 +0900
Message-ID: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

This patches just replace the deprecated extcon API without any change
of extcon operation and use the resource-managed function for
extcon_register_notifier().

The new extcon API instead of deprecated API.
- extcon_set_cable_state_() -> extcon_set_state_sync();
- extcon_get_cable_state_() -> extcon_get_state();

The each patch has not any dependency among patches. So, each maintainer
could pick up each patch without any problem.

Chanwoo Choi (12):
  phy: rcar-gen3-usb2: Replace the deprecated extcon API
  phy: sun4i-usb: Replace the deprecated extcon API
  power_supply: axp288_charger: Replace the extcon API
  power_supply: qcom_smbb: Replace the deprecated extcon API
  usb: chipdata: Replace the extcon API
  usb: dwc3: omap: Replace the extcon API
  usb: sunxi: Uses the resource-managed extcon API when registering extcon notifier
  usb: phy: msm: Replace the extcon API
  usb: phy: omap-otg: Replace the extcon API
  usb: phy: qcom-8x16-usb: Replace the extcon API
  usb: phy: tahvo: Replace the deprecated extcon API
  usb: renesas_usbhs: Replace the deprecated extcon API

 drivers/phy/phy-rcar-gen3-usb2.c      |  8 +++---
 drivers/phy/phy-sun4i-usb.c           |  4 +--
 drivers/power/supply/axp288_charger.c | 51 +++++++++--------------------------
 drivers/power/supply/qcom_smbb.c      |  2 +-
 drivers/usb/chipidea/core.c           | 30 +++++----------------
 drivers/usb/dwc3/dwc3-omap.c          | 20 +++++---------
 drivers/usb/musb/sunxi.c              | 12 +++------
 drivers/usb/phy/phy-msm-usb.c         | 33 ++++++++---------------
 drivers/usb/phy/phy-omap-otg.c        | 24 +++++------------
 drivers/usb/phy/phy-qcom-8x16-usb.c   | 13 +++------
 drivers/usb/phy/phy-tahvo.c           | 10 +++----
 drivers/usb/renesas_usbhs/common.c    |  2 +-
 12 files changed, 63 insertions(+), 146 deletions(-)

-- 
1.9.1
