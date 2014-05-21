From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv4 0/4] tsc2005 DT binding
Date: Wed, 21 May 2014 19:36:10 +0200
Message-ID: <1400693774-21306-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds device tree support for the tsc2005 touchscreen
controller, which is currently only used by the Nokia N900
board.

The patch does not update the reset pin handling for platform
data based probe to avoid merge conflicts. The n900 platform
code will be removed in the near future (3.17?) and the driver
can be simplified once that has happened.

Changes since v3 [0]:
 * Move common touchscreen DT handling code into its own file
 * Add regulator support to tsc2005 driver
 * Added N900 DTS patch for completeness. It should go via
   Tony's Tree of course.

[0] https://lkml.org/lkml/2014/4/25/694

-- Sebastian

Sebastian Reichel (4):
  Input: add common DT binding for touchscreens
  Input: tsc2005: add DT support
  Documentation: dt: Document TSC2005 DT binding
  DTS: ARM: OMAP3-N900: Add tsc2005 support

 .../bindings/input/touchscreen/touchscreen.txt     |  27 +++++
 .../bindings/input/touchscreen/tsc2005.txt         |  42 +++++++
 arch/arm/boot/dts/omap3-n900.dts                   |  17 ++-
 drivers/input/touchscreen/Kconfig                  |   4 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/of_touchscreen.c         |  44 ++++++++
 drivers/input/touchscreen/tsc2005.c                | 122 +++++++++++++++++----
 include/linux/input/touchscreen.h                  |  22 ++++
 8 files changed, 258 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
 create mode 100644 drivers/input/touchscreen/of_touchscreen.c
 create mode 100644 include/linux/input/touchscreen.h

-- 
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
