From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] pixcir_i2c_ts: Add optional wakeup irq support
Date: Mon, 20 Jul 2015 10:20:12 +0530
Message-ID: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Frodo Lai <frodo.lai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On am437x-gp-evm, pixcir_i2c_tsc can wake-up system from low power
state via pinctrl and IO daisy chain mechanism. This patch series add
support for such optional wake up interrupt to be handled via recently
introduced generic wake irq handling framework.

Tested on am437x-gp-evm, with some out of tree patches to support
suspend/resume on am437x.


Vignesh R (2):
  input: touchscreen: pixcir_i2c_ts: Add support for optional wakeup
    interrupt
  ARM: dts: AM437x-gp-evm: Add wakeup interrupt source for
    pixcir_i2c_tsc

 arch/arm/boot/dts/am437x-gp-evm.dts       |  4 ++++
 drivers/input/touchscreen/pixcir_i2c_ts.c | 17 +++++++++++++----
 include/linux/input/pixcir_ts.h           |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.4.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
