From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv3 0/2] PWM Vibrator driver
Date: Fri,  5 May 2017 11:28:21 +0200
Message-ID: <20170505092823.26009-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The Motorola Droid 4 has a vibrator, that is connected
to two GPIOs. Motorola's stock kernel names them vib_en
and vib_dir, which probably stand for vibrator_enable
and vibrator_direction. In their stock kernel both GPIOs
are toggled using a hrtimer and a custom vibrator "misc"
device is provided to userspace.

Thankfully the hardware designers the used GPIOs can
also be used from OMAP's dmtimers, so that they can
be driven as PWM output instead saving some CPU cycles
(and code).

The driver is loosely based on an old patch from Dmitry,
that I found in the internet(tm) [0]. Note, that I did
not check the generic vibrator stuff. I just kept it in
the driver, since it's probably what other people expect
from a pwm-vibra driver :)

Also I wrote a small tool to test the vibrator running
at different strength levels, since fftest(1) used a
fixed one.

[0] https://lkml.org/lkml/2012/4/10/41
[1] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

-- Sebastian

Sebastian Reichel (2):
  Input: pwm-vibra: new driver
  ARM: dts: omap4-droid4: Add vibrator

 .../devicetree/bindings/input/pwm-vibrator.txt     |  60 ++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  38 +++
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pwm-vibra.c                     | 343 +++++++++++++++++++++
 5 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 drivers/input/misc/pwm-vibra.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
