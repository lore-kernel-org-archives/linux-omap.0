From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/4] usb: musb/dwc3: add driver for control module
Date: Fri, 25 Jan 2013 07:49:47 +0530
Message-ID: <1359080391-5120-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added a new driver for the usb part of control module. This has an API
to power on the USB2 phy and an API to write to the mailbox depending on
whether MUSB has to act in host mode or in device mode.
Also added an API to power on usb3 phy (omap5).

Writing to control module registers for doing the above task which was
previously done in omap glue and in omap-usb2 phy is removed.

Changes from v2:
* removed "ti,has_mailbox" and added "ti,type" to differentiate whether the
  control module has usb mailbox or usb3 phy power. omap4 has usb mailbox 
  in control module to notify events to the musb core and omap5 has usb3
  phy power register to power on usb3 phy.

* Added an API to power on USB3 PHY needed for OMAP5.

Changes from v1:
* renamed get_omap_control_dev to omap_get_control_dev

* created and exported a single API (omap_control_usb_set_mode) to change
  the usb mode

* Before writing to the otghs_control regster, the value from
  otghs_control regster is read and only the appropriate bits are set.

* In omap_init_control_usb, the indentation is now reduced as per Felipe's
  suggestion.

Changes from RFC:
* Used "#if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)" instead of 
  "#if (defined(CONFIG_OMAP_CONTROL_USB) || \
				defined(CONFIG_OMAP_CONTROL_USB_MODULE))"

* return "-EADDRNOTAVAIL" if devm_request_and_ioremap fails.

* Removed the dt data from this patch series (I'll send that as a separate
series).

* added "ctrl_module" binding to usb otg glue and usb phy in the Documentaion.
  This binding is not planned to be used until an actual requirement for
  it arises.

This series was developed on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv

I've kept this patch series and all the patch series to follow in a single branch
git://gitorious.org/linux-usb/linux-usb.git omap5-with-palmas
(changes up to 23b4dfa2ab7052569cd88acc6383c4b1a8e8a482)

Did basic enumeration testing in omap4 panda, omap3 beagle and omap5 evm.

Kishon Vijay Abraham I (4):
  drivers: usb: phy: add a new driver for usb part of control module
  ARM: OMAP: devices: create device for usb part of control module
  ARM: OMAP2: MUSB: Specify omap4 has mailbox
  drivers: usb: start using the control module driver

 Documentation/devicetree/bindings/usb/omap-usb.txt |   34 ++-
 Documentation/devicetree/bindings/usb/usb-phy.txt  |   12 +-
 arch/arm/mach-omap2/devices.c                      |   45 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 -
 arch/arm/mach-omap2/usb-musb.c                     |    3 +
 drivers/usb/musb/Kconfig                           |    1 +
 drivers/usb/musb/omap2430.c                        |   68 ++---
 drivers/usb/musb/omap2430.h                        |    9 -
 drivers/usb/phy/Kconfig                            |   11 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/omap-control-usb.c                 |  295 ++++++++++++++++++++
 drivers/usb/phy/omap-usb2.c                        |   41 +--
 include/linux/usb/musb.h                           |    2 +
 include/linux/usb/omap_control_usb.h               |   92 ++++++
 include/linux/usb/omap_usb.h                       |    4 +-
 15 files changed, 522 insertions(+), 109 deletions(-)
 create mode 100644 drivers/usb/phy/omap-control-usb.c
 create mode 100644 include/linux/usb/omap_control_usb.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
