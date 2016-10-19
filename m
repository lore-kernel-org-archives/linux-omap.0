From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] gpio: davinci: Add k2g support
Date: Wed, 19 Oct 2016 11:03:54 +0530
Message-ID: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

k2g has two instances of gpio controller. The gpio controller
is bit identical to the one used in da-vinci. The da-vinci gpio
driver was written keeping in mind about only one instance of
gpio controller. The patch series enhances the driver to support
multiple instances.

k2g has 2 instances of gpio controller with 144 pins each.
Totally 9 banks with 16 pins each totalling to 144 pins per
controller instance. GPIO1 instance has GPIO:68 to GPIO:143
marked as reserved hence we have a total of 144(bank0) and 68
(bank1) GPIOs. 

Grygorii Strashko (1):
  gpio: davinci: irq support for multiple gpio controllers

Keerthy (3):
  gpio: davinci: Remove gpio2regs function to accommodate      multi
    instances
  gpio: davinci: Store both irqs into the controller
  gpio: davinci: Add a separate compatible for k2g

Lokesh Vutla (1):
  drivers: gpio: Add support for multiple IPs

 .../devicetree/bindings/gpio/gpio-davinci.txt      |   2 +-
 drivers/gpio/gpio-davinci.c                        | 115 ++++++++++++++-------
 include/linux/platform_data/gpio-davinci.h         |   3 +
 3 files changed, 84 insertions(+), 36 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
