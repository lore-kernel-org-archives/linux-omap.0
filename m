From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH v4 0/4] ARM: dts: use syscon property instead of ctrl-module
Date: Mon, 21 Dec 2015 14:43:17 +0530
Message-ID: <1450689201-16973-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series is basically to deprecate using ctrl-module property and use
corresponding syscon properties to program the control module registers.

Changes from v3:
*) Renamed 'tisyscon@1c24' node to 'scm_conf@1c24'

Changes from v2:
No changes.

Changes from v1:
*) Squashed the patches that replaces "ctrl-module" with
   "syscon-phy-power"
*) Added "syscon-phy-power" for SATA dt node in OMAP5 which was missed
   earlier
*) removed _ARM: dts: omap4: Use "syscon-otghs" instead of "ctrl-module"
   in USB node_. It will be done later.

Changes from [1] in PHY patches include
*) cleanup ti_pipe3_probe
*) have mask, power_on and power_off values in usb_phy_data for
   omap-usb2 phy

This series should be merged only after [2]
Kishon Vijay Abraham I (4):
  ARM: dts: dra7: Add dt node for the sycon pcie
  ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY
    node
  ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2
    PHY2
  ARM: dts: <am4372/dra7/omap5>: Use "syscon-phy-power" instead of
    "ctrl-module"

 arch/arm/boot/dts/am4372.dtsi |   16 ++-------
 arch/arm/boot/dts/dra7.dtsi   |   75 ++++++++++++-----------------------------
 arch/arm/boot/dts/omap5.dtsi  |   26 ++------------
 3 files changed, 26 insertions(+), 91 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
