From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/22] OMAP USB Host cleanup
Date: Wed, 28 Nov 2012 16:48:48 +0200
Message-ID: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset addresses the following

- Avoid addressing clocks one by one by name and use a for loop + bunch
  of cleanups.
- Get number of channels/ports dynamically either from revision register
  or from platform data. Avoids getting clocks that are not present.
- Add OMAP5 and HSIC mode (Not tested)

changes in v2:
- Clocks are allocated dynamically based on number of ports available
on the platform
- Reduced console spam if non critical clocks are not found on the platform.
- Get rid of cpu_is_.. macros from USB host driver.

cheers,
-roger

--

Roger Quadros (22):
  mfd: omap-usb-tll: Avoid creating copy of platform data
  mfd: omap-usb-tll: Fix channel count detection
  mfd: omap-usb-tll: Use devm_kzalloc/ioremap and clean up error path
  mfd: omap-usb-tll: Clean up clock handling
  mfd: omap-usb-tll: introduce and use mode_needs_tll()
  mfd: omap-usb-tll: Check for missing platform data in probe
  mfd: omap-usb-tll: Fix error message
  mfd: omap-usb-tll: serialize access to TLL device
  mfd: omap-usb-tll: Add OMAP5 revision and HSIC support
  mfd: omap_usb_host: Avoid creating copy of platform_data
  mfd: omap-usb-host: Use devm_kzalloc() and devm_request_and_ioremap()
  mfd: omap-usb-host: know about number of ports from revision register
  mfd: omap-usb-host: override number of ports from platform data
  mfd: omap-usb-host: cleanup clock management code
  ARM: OMAP2+: clock data: Merge utmi_px_gfclk into
    usb_host_hs_utmi_px_clk
  mfd: omap-usb-host: Manage HSIC clocks for HSIC mode
  mfd: omap-usb-host: Get rid of unnecessary spinlock
  mfd: omap-usb-host: get rid of cpu_is_omap..() macros
  mfd: omap-usb-host: clean up omap_usbhs_init()
  USB: ehci-omap: Don't free gpios that we didn't request
  ARM: OMAP2+: clock data: get rid of unused USB host clock aliases
  mfd: omap-usb-host: Don't spam console on clk_set_parent failure

 arch/arm/mach-omap2/clock3xxx_data.c  |   13 -
 arch/arm/mach-omap2/clock44xx_data.c  |   30 +--
 arch/arm/mach-omap2/usb-host.c        |    5 +
 arch/arm/plat-omap/include/plat/usb.h |    5 +
 drivers/mfd/omap-usb-host.c           |  467 +++++++++++++++++++--------------
 drivers/mfd/omap-usb-tll.c            |  244 ++++++++++--------
 drivers/usb/host/ehci-omap.c          |    8 -
 7 files changed, 421 insertions(+), 351 deletions(-)

-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
