From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] ARM: dts: omap: add dt data for MUSB
Date: Fri, 18 Jan 2013 15:21:13 +0530
Message-ID: <1358502676-27193-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds dt data to get MUSB working in omap4 and omap3.
Long time back a patch series with the same title was sent but only
a part of it got merged. The rest of it wasn't merged because of
adding omap control usb data to glue and usb phy.

Now there exists a separate driver for control usb and hence added a
separate dt node for control usb.

This series was developed on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
+ "usb: musb: add driver for control module" patch series

Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.

Kishon Vijay Abraham I (3):
  ARM: dts: omap: Add omap control usb data
  ARM: dts: omap: Add omap-usb2 dt data
  ARM: dts: omap: Add usb_otg and glue data

 Documentation/devicetree/bindings/usb/omap-usb.txt |    2 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    6 +++++
 arch/arm/boot/dts/omap3-evm.dts                    |    6 +++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |    6 +++++
 arch/arm/boot/dts/omap3.dtsi                       |   12 ++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |    6 +++++
 arch/arm/boot/dts/omap4-sdp.dts                    |    6 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   25 ++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi                     |    2 +-
 9 files changed, 70 insertions(+), 1 deletion(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
