From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5 v14] omap: usb: host: Runtime PM preparation for EHCI and OHCI drivers
Date: Tue, 11 Oct 2011 13:18:08 +0530
Message-ID: <1318319288-20122-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The Hwmod structures for ehci and ohci drivers are implemented for
EHCI and OHCI drivers of OMAP3 and OMAP4.
The ehci and ohci drivers does not use the APIs of the usbhs
core driver; the runtime pm APIs are used for clock
enable/disable.

TODO:
 - Adding mux-information to Hwmods.
 - Aggressive Clock Management around USB bus suspend/resume.
 - Remote Wakeup support implementation using IO-ring Wakeup
   on EHCI/OHCI pads via PRCM IRQ chain handler.

In Version 14:
        - for omap3 and omap4,
		Masters are added for the TLL hwmod
	- for omap3, 
		OCPIF_SWSUP_IDLE option is removed for interface clocks

In version 13:
       - for omap3, the ehci 120mhz clock is conditional enabled
         if ehci is selected for atleast one port in the omap platform.
       - the hardware erratas information is added.
       - the patches are split in to two series
               i) The hwmod and preparation for run time pm of ehci and
                       ohci drivers ( this series)
               ii) The Runtime pm support for ehci and ohci drivers.
         Since the patches are split , both the series are SHOULD be
         applied to make the ehci and ohci drivers are functional with
         runtime pm support.

In version 12:
 - The ehci, ohci and usb_host_hs hwmods combined as a single hwmod
   usb_host_hs.
 - for omap3
       the usbhost_ick and and usbtll_ick clocks are changed as interface
       clocks. The usbtll_fck, usbhost_48m_fck clocks are changed as main
       clocks and the 120mhz functional clock is changed to optional clock
 - the usbhs mfd driver enable/disable this optional clock in
   runtime_resume and runtime_suspend callbacks of pm_runtime_get_sync
   and pm_runtime_put_sync APIs.


Benoit Cousson (1):
  arm: omap: usb: ehci and ohci hwmod structures for omap4

Keshava Munegowda (4):
  arm: omap: usb: ehci and ohci hwmod structures for omap3
  arm: omap: usb: register hwmods of usbhs
  arm: omap: usb: device name change for the clk names of usbhs
  omap: usb: host: Replace usbhs core driver APIs by Runtime pm APIs

 arch/arm/mach-omap2/clock3xxx_data.c       |   26 ++--
 arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  230 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  220 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb-host.c             |  100 ++++--------
 arch/arm/plat-omap/include/plat/usb.h      |    3 -
 drivers/mfd/omap-usb-host.c                |    2 +-
 drivers/usb/host/ehci-omap.c               |   17 +--
 drivers/usb/host/ohci-omap3.c              |   18 +--
 9 files changed, 515 insertions(+), 111 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
