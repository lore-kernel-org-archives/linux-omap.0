From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V3 0/3] mfd: palmas: add optional wakeup irq
Date: Thu, 18 Sep 2014 14:04:43 -0500
Message-ID: <1411067086-16613-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
V3 update for the previous series:
Changes in V3 (from review updates):
	- Allow driver to function even if wakeirq fails
	- Fix irq flags

V2: http://marc.info/?l=linux-kernel&m=140995041418575&w=2
v1: https://patchwork.kernel.org/patch/4743321/

Nishanth Menon (3):
  Documentation: dt-bindings: mfd: palmas: Fix example style of i2c
    peripheral
  Documentation: dt-bindings: mfd: palmas: document optional wakeup IRQ
  mfd: palmas: Add support for optional wakeup

 Documentation/devicetree/bindings/mfd/palmas.txt |   22 +++++++-
 drivers/mfd/palmas.c                             |   62 ++++++++++++++++++++++
 include/linux/mfd/palmas.h                       |    2 +
 3 files changed, 85 insertions(+), 1 deletion(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
