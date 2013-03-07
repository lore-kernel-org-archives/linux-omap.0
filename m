From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Thu, 7 Mar 2013 11:35:59 +0200
Message-ID: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3CGJgZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 04:36:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi folks,

inspired by Paul's DWC2 patchset which added usb_otg_state_string()
(a copy of otg_state_string()) I have now renamed otg_state_string()
to usb_otg_state_string(), moved it to usb-common, then moved all
phy drivers to drivers/usb/phy/ and completely deleted the otg directory.

We're also removing CONFIG_USB_OTG_UTILS since that has lots its
meaning long ago.

I have compiled all patches with allyes, allno and allmod configs,
but please make sure to test on your platforms to make sure we're
not leaking any more problems to mainline.

Felipe Balbi (10):
  usb: otg: prefix otg_state_string with usb_
  usb: otg: move usb_otg_state_string to usb-common.c
  usb: phy: convert EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
  usb: phy: move all PHY drivers to drivers/usb/phy/
  usb: phy: make it a menuconfig
  usb: power: pda_power: check against CONFIG_USB_PHY
  usb: gadget: mv_udc_core: check against CONFIG_USB_PHY
  usb: ehci: marvel: check against CONFIG_USB_PHY
  usb: ehci: tegra: check against CONFIG_USB_PHY
  usb: phy: remove CONFIG_USB_OTG_UTILS

 drivers/Makefile                         |   2 +-
 drivers/power/pda_power.c                |  14 +--
 drivers/usb/Kconfig                      |   2 -
 drivers/usb/Makefile                     |   2 -
 drivers/usb/gadget/mv_udc_core.c         |   2 +-
 drivers/usb/host/ehci-mv.c               |   4 +-
 drivers/usb/host/ehci-tegra.c            |   6 +-
 drivers/usb/musb/am35x.c                 |   8 +-
 drivers/usb/musb/blackfin.c              |   6 +-
 drivers/usb/musb/da8xx.c                 |   8 +-
 drivers/usb/musb/davinci.c               |   4 +-
 drivers/usb/musb/musb_core.c             |  39 ++++----
 drivers/usb/musb/musb_dsps.c             |   8 +-
 drivers/usb/musb/musb_gadget.c           |   8 +-
 drivers/usb/musb/musb_host.c             |   2 +-
 drivers/usb/musb/musb_virthub.c          |   4 +-
 drivers/usb/musb/omap2430.c              |   6 +-
 drivers/usb/musb/tusb6010.c              |  14 +--
 drivers/usb/otg/Kconfig                  | 141 --------------------------
 drivers/usb/otg/Makefile                 |  24 -----
 drivers/usb/otg/otg.c                    |  47 ---------
 drivers/usb/phy/Kconfig                  | 166 ++++++++++++++++++++++++++-----
 drivers/usb/phy/Makefile                 |  26 ++++-
 drivers/usb/{otg => phy}/ab8500-usb.c    |   0
 drivers/usb/{otg => phy}/fsl_otg.c       |   2 +-
 drivers/usb/{otg => phy}/fsl_otg.h       |   0
 drivers/usb/{otg => phy}/gpio_vbus.c     |   0
 drivers/usb/{otg => phy}/isp1301_omap.c  |   6 +-
 drivers/usb/{otg => phy}/msm_otg.c       |   0
 drivers/usb/{otg => phy}/mv_otg.c        |   0
 drivers/usb/{otg => phy}/mv_otg.h        |   0
 drivers/usb/{otg => phy}/mxs-phy.c       |   0
 drivers/usb/{otg => phy}/nop-usb-xceiv.c |   0
 drivers/usb/{otg => phy}/otg_fsm.c       |   2 +-
 drivers/usb/{otg => phy}/otg_fsm.h       |   0
 drivers/usb/phy/phy.c                    |  20 ++--
 drivers/usb/{otg => phy}/twl4030-usb.c   |   0
 drivers/usb/{otg => phy}/twl6030-usb.c   |   0
 drivers/usb/{otg => phy}/ulpi.c          |   0
 drivers/usb/{otg => phy}/ulpi_viewport.c |   0
 drivers/usb/usb-common.c                 |  26 +++++
 include/linux/usb/otg.h                  |   9 +-
 include/linux/usb/phy.h                  |   2 +-
 43 files changed, 274 insertions(+), 336 deletions(-)
 delete mode 100644 drivers/usb/otg/Kconfig
 delete mode 100644 drivers/usb/otg/Makefile
 delete mode 100644 drivers/usb/otg/otg.c
 rename drivers/usb/{otg => phy}/ab8500-usb.c (100%)
 rename drivers/usb/{otg => phy}/fsl_otg.c (99%)
 rename drivers/usb/{otg => phy}/fsl_otg.h (100%)
 rename drivers/usb/{otg => phy}/gpio_vbus.c (100%)
 rename drivers/usb/{otg => phy}/isp1301_omap.c (99%)
 rename drivers/usb/{otg => phy}/msm_otg.c (100%)
 rename drivers/usb/{otg => phy}/mv_otg.c (100%)
 rename drivers/usb/{otg => phy}/mv_otg.h (100%)
 rename drivers/usb/{otg => phy}/mxs-phy.c (100%)
 rename drivers/usb/{otg => phy}/nop-usb-xceiv.c (100%)
 rename drivers/usb/{otg => phy}/otg_fsm.c (99%)
 rename drivers/usb/{otg => phy}/otg_fsm.h (100%)
 rename drivers/usb/{otg => phy}/twl4030-usb.c (100%)
 rename drivers/usb/{otg => phy}/twl6030-usb.c (100%)
 rename drivers/usb/{otg => phy}/ulpi.c (100%)
 rename drivers/usb/{otg => phy}/ulpi_viewport.c (100%)

-- 
1.8.1.rc1.5.g7e0651a

