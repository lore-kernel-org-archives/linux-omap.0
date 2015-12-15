From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 15 Dec 2015 14:45:59 +0530
Message-ID: <1450170968-11282-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series is basically to deprecate using phy-omap-control and use
syscon APIs to program the control module registers.

Changes from v2:
No changes.

Changes from v1:
*) cleanup ti_pipe3_probe in multiple steps
*) other minor cleanups

Changes from [1] in PHY patches include
*) cleanup ti_pipe3_probe
*) have mask, power_on and power_off values in usb_phy_data for
   omap-usb2 phy

The patches have been pushed to
	git://git.ti.com/linux-phy/linux-phy.git syscon

[1] -> https://lkml.org/lkml/2015/6/23/189

All the testing was done both before applying the dt patches and after
applying the dt patches (dt patches will be posted shortly).

Logs with SYSCON DT

DRA72 EVM : http://pastebin.ubuntu.com/14025205/
DRA7 EVM  : http://pastebin.ubuntu.com/14025212/
AM43XX EVM: http://pastebin.ubuntu.com/14025222/
OMAP5 UEVM: http://pastebin.ubuntu.com/14025228/

Logs without SYSCON DT

DRA72 EVM : http://pastebin.ubuntu.com/14025233/
DRA7 EVM  : http://pastebin.ubuntu.com/14025238/
AM43XX EVM: http://pastebin.ubuntu.com/14025329/
OMAP5 UEVM: http://pastebin.ubuntu.com/14025248/

The config I used: http://pastebin.ubuntu.com/14025336/

Kishon Vijay Abraham I (9):
  phy: ti-pipe3: introduce local struct device* in probe
  phy: ti-pipe3: move clk initialization to a separate function
  phy: ti-pipe3: move sysctrl initialization to a separate function
  phy: ti-pipe3: move mem resource initialization to a separate
    function
  phy: ti-pipe3: use ti_pipe3_power_off to power off the PHY during
    probe
  phy: ti-pipe3: use *syscon* framework API to power on/off the PHY
  phy: ti-pipe3: use *syscon* framework API to set PCS value of the PHY
  phy: omap-usb2: use omap_usb_power_off to power off the PHY during
    probe
  phy: omap-usb2: use *syscon* framework API to power on/off the PHY

 Documentation/devicetree/bindings/phy/ti-phy.txt |   20 +-
 drivers/phy/phy-omap-usb2.c                      |   96 +++++--
 drivers/phy/phy-ti-pipe3.c                       |  304 ++++++++++++++++------
 include/linux/phy/omap_usb.h                     |   23 ++
 4 files changed, 340 insertions(+), 103 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
