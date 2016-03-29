From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: [PATCH 0/5] Amazon Kindle Fire (first generation) codename kc1 support series
Date: Tue, 29 Mar 2016 21:28:21 +0200
Message-ID: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds basic support for the Amazon Kindle Fire (first generation)
codename kc1. A few features such as serial, i2c, the internal eMMC, USB gadget
and power button leds.

It requires some TWL-related patches to work properly, in particular:
* pwm: twl: Reliably disable TWL6030 PWMs
* mfd: Add TWL6030 power driver, with minimal support for power off

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
