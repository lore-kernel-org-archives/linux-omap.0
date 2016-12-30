From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] Add TI iodelay driver using #pinctrl-cells
Date: Fri, 30 Dec 2016 10:37:30 -0800
Message-ID: <20161230183732.5595-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a respin of Nishanth's iodelay driver that I've updated to
use #pinctrl-cells and generic pinctrl group and function code.

Gary, note that this one has an iterator function that you may
be able to use too, and hopefully we can simplify things further
eventually by introducing a generic iterator.

Note that these patches are against the current pinctrl devel
branch at commit b61d1546906d ("pinctrl: single: Use generic
pinmux helpers for managing functions").

Regards,

Tony

Nishanth Menon (1):
  pinctrl: Introduce TI IOdelay configuration driver

Tony Lindgren (1):
  pinctrl: core: Make dt_free_map optional

 .../devicetree/bindings/pinctrl/ti,iodelay.txt     |  47 +
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/core.c                             |   3 -
 drivers/pinctrl/devicetree.c                       |   3 +-
 drivers/pinctrl/ti/Kconfig                         |  10 +
 drivers/pinctrl/ti/Makefile                        |   1 +
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 945 +++++++++++++++++++++
 8 files changed, 1007 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,iodelay.txt
 create mode 100644 drivers/pinctrl/ti/Kconfig
 create mode 100644 drivers/pinctrl/ti/Makefile
 create mode 100644 drivers/pinctrl/ti/pinctrl-ti-iodelay.c

-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
