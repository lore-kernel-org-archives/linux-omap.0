From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC 0/2] [media] si4713 DT binding
Date: Sun,  6 Apr 2014 13:52:03 +0200
Message-ID: <1396785125-8759-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Dinesh Ram <Dinesh.Ram-vJEk5272eHo@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This is an RFC patch adding DT support to the si4713 radio transmitter i2c
driver. The changes can be summarized as follows:

 * Move regulator information back into the driver. The regulators needed are
   documented in the chip and have nothing to do with boarddata. Instead
   devm_regulator_get_optional and errors are handled quite loosely now.
   Maybe the USB driver should provide dummy regulators.
 * GPIO handling is updated to gpiod consumer interface, resulting in a driver
   cleanup and easy DT handling
 * The driver is updated to use managed resources wherever possible

So much about the nice stuff. But there is also

 * Instantiation of the platform device from the i2c (sub-)device. Since DT
   is not supposed to contain linuxisms the device is a simple i2c node
   resulting in the i2c probe function being called. Thus registering the main
   v4l device must happen from there.

Tested:
 * Compilation on torvalds/linux.git:master
 * Booting in DT mode
 * Some simply driver queries using v4l2-ctl

Not tested:
 * The USB driver, since I do not own the USB dongle
 * The legacy platform code (only DT boot has been tested).
   (The legacy platform code is supposed to removed in the near future anyways)

-- Sebastian

Sebastian Reichel (2):
  [media] si4713: add Device Tree support
  [media] Ad DT binding documentation for si4713

 Documentation/devicetree/bindings/media/si4713.txt |  30 ++++
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  67 ++++-----
 drivers/media/radio/si4713/radio-platform-si4713.c |  28 +---
 drivers/media/radio/si4713/si4713.c                | 166 +++++++++++++--------
 drivers/media/radio/si4713/si4713.h                |  15 +-
 include/media/radio-si4713.h                       |  30 ----
 include/media/si4713.h                             |   4 +-
 7 files changed, 183 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/si4713.txt
 delete mode 100644 include/media/radio-si4713.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
