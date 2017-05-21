From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v5 0/3] More fixes for twl4030 charger
Date: Sun, 21 May 2017 12:38:15 +0200
Message-ID: <cover.1495363097.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Changes V5:
* reworked max_current removal patch (comments by Sebastian Reichel)
* resubmit missing madc connection for AC power detection
* resubmit patch for irq allocation and -EPROBE_DEFER
* rebased on 4.12-rc1

Changes V4:
* resent commit (original one did contain material not upstream)

2017-04-14 21:29:39: 2017-04-14 20:26:00: Changes V3:
* worked in comments by Sebsatian Reichel
* clarifications of some commit messages
* rebased on v4.11rc-6

It took a while (18 months) until we propose an updated patch for upstream...

2015-11-02 12:27:39: Changes V2:
* worked in comments by Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
* added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)

V1:
4.3-rc1 introduced a new charger driver for the twl4030. This patch set fixes some
issues.

While making twl4030 changes from 4.3 operable we have found some issues
during testing on GTA04 and OpenPandora.

H. Nikolaus Schaller (2):
  drivers:power:twl4030-charger: remove nonstandard max_current sysfs
    attribute
  drivers:power:twl4030-charger: add deferred probing for phy and iio

Marek Belisko (1):
  ARM: dts: twl4030: Add missing madc reference for bci subnode

 .../ABI/testing/sysfs-class-power-twl4030          |  17 ----
 arch/arm/boot/dts/twl4030.dtsi                     |   2 +
 drivers/power/supply/twl4030_charger.c             | 100 +++++----------------
 3 files changed, 24 insertions(+), 95 deletions(-)

-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
