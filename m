From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] ARM: dts: dra72-evm: NAND and USB support
Date: Tue, 21 Oct 2014 13:41:16 +0300
Message-ID: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

These patches add NAND and USB support for DRA72-evm.
Patches are for v3.19 and based on v3.18-rc1.

I've tested that NAND and USB host works fine on DRA72-evm.

I couldn't get USB gadget mode to work. It doesn't work on DRA7-evm either.
There seems to be some issue at the driver level. The dts entries are correct though.

cheers,
-roger

George Cherian (1):
  ARM: dts: dra72-evm: Enable USB support for dra72-evm.

Roger Quadros (3):
  ARM: dts: dra72-evm: Add NAND support
  ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi
  ARM: dts: dra72-evm: Add regulator information to USB2 PHYs

 arch/arm/boot/dts/dra7.dtsi     |  20 ------
 arch/arm/boot/dts/dra72-evm.dts | 147 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi   |  22 ++++++
 3 files changed, 169 insertions(+), 20 deletions(-)

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
