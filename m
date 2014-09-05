From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v6 0/3]  Add ST dwc3 glue layer driver
Date: Fri,  5 Sep 2014 16:36:29 +0100
Message-ID: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series adds support for the ST glue logic which wraps the DWC3 controller
on STiH407 SoC family chipsets.

Changes since v5
 - Use of_platform_depopulate

Changes since v4
 - Fix bug with setting bits in usb control register
 - Remove superflous '\n'
 - Change default Kconfig to make default same as other platforms
 - Update dt doc example so that both usb2 and usb3 phys are using generic drivers/phy instead of drivers/usb/phy
 - Reconfigure ST glue logic regs in resume callback

Changes since v3
 - Various formating nits

Changes since v2
 - Use dr_mode for host/device static configuration
 - Manage shared reset signal to usbss to avoid hang if probing before usb3 phy
 - Remove DT checks and make driver depend on OF
 - Change some #define to use BIT macro
 - Make some comments clearer
 - Use kerneldoc for struct documentation
 - Remove udelay
 - Let DT create platform_devices, and remove legacy alloc
 - Change some logging levels to dev_dbg
 - Various whitespace and formatting cleanup
 - Use SIMPLE_DEV_PM_OPS()
 - Add const to of_device struct
 - Reorder header files alphabetically
 - Use devm_ioremap_resource instead of devm_request_and_ioremap
 - Remove of_match_ptr()

Changes since v1
 - Fix Kconfig mistake

Peter Griffin (3):
  usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
  usb: dwc3: dwc3-st: Add st-dwc3 devicetree bindings documentation
  MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture

 Documentation/devicetree/bindings/usb/dwc3-st.txt |  68 ++++
 MAINTAINERS                                       |   1 +
 drivers/usb/dwc3/Kconfig                          |   9 +
 drivers/usb/dwc3/Makefile                         |   1 +
 drivers/usb/dwc3/dwc3-st.c                        | 377 ++++++++++++++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
 create mode 100644 drivers/usb/dwc3/dwc3-st.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
