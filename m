From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv3 0/5] tsc2005 DT binding
Date: Sat, 26 Apr 2014 01:56:14 +0200
Message-ID: <1398470179-20880-1-git-send-email-sre@kernel.org>
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
code will be removed in the near future (3.16?) and the driver
can be simplified once that has happened.

Changes since v2 [0]:
 * rename "ti,x-plate-resistance" to "ti,x-plate-ohms", so that
   the same property name is used for tsc2005 and tsc2007
 * document "x-size" and "y-size" as deprecated form of
   touchscreen-size-x and touchscreen-size-y
 * add documentation for "touchscreen-inverted-x" and
   "touchscreen-inverted-y" to the common touchscreen binding
   and mark "x-invert" and "y-invert" as deprecated.
 * add units to the property descriptions in the common
   touchscreen binding Documentation
 * document "moving-threshold" as deprecated form of
   "touchscreen-fuzz-x" and "touchscreen-fuzz-y" combination
 * document "contact-threshold" as deprecated form of
   "touchscreen-fuzz-pressure"

[0] https://lkml.org/lkml/2014/4/5/103

-- Sebastian

Sebastian Reichel (5):
  Input: add common DT binding for touchscreens
  Input: tsc2005: use dev_err for error messages
  Input: tsc2005: convert driver to use devm_*
  Input: tsc2005: add DT support
  Documentation: dt: Document TSC2005 DT binding

 .../bindings/input/touchscreen/touchscreen.txt     |  27 +++++
 .../bindings/input/touchscreen/tsc2005.txt         |  39 +++++++
 drivers/input/input.c                              |  34 ++++++
 drivers/input/touchscreen/tsc2005.c                | 130 ++++++++++++++-------
 include/linux/input.h                              |   8 ++
 5 files changed, 197 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt

-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
