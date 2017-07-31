From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 0/3]  tty: serial: 8250 introduce mctrl_gpio helpers
Date: Mon, 31 Jul 2017 09:13:20 +0200
Message-ID: <1501485203-13185-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

This patch series aims to reintroduce the  mctrl_gpio helpers for 8250
UARTs.

There are some UARTs that use GPIO signals as a wakeup-sourse.
The first patch addresses this issue and tries to destinguish GPIO usage
via searching for "wakeup-sourse" property. Though it must be decided whether
this property is secure to use for this purpose.

Changes v1 -> v2:
  - unlock mutex, if mctrl_gpio_init fails (suggested by Julia Lawall)
  - describe -ENOSYS return value choice (suggested by Andy Shevchenko) 

Yegor Yefremov (3):
  serial: mctrl_gpio: restrict MCTRL initialization
  tty/serial/8250: use mctrl_gpio helpers
  tty/serial/8250: add DT bindings description for mctrl_gpio helpers

 Documentation/devicetree/bindings/serial/8250.txt | 26 +++++++++++++++++
 drivers/tty/serial/8250/8250.h                    | 35 ++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_core.c               | 12 ++++++++
 drivers/tty/serial/8250/8250_omap.c               | 31 +++++++++++---------
 drivers/tty/serial/8250/8250_port.c               |  7 ++++-
 drivers/tty/serial/8250/Kconfig                   |  1 +
 drivers/tty/serial/serial_mctrl_gpio.c            |  4 +++
 include/linux/serial_8250.h                       |  1 +
 8 files changed, 102 insertions(+), 15 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
