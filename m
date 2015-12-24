From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 0/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Date: Thu, 24 Dec 2015 17:35:32 +0200
Message-ID: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add DT support for WLS1271 SPI driver.
Add power operation function to the WLS1271 SPI driver.

Uri Mashiach (3):
  wlcore/wl12xx: spi: add power operation function
  wlcore/wl12xx: spi: add device tree support
  wlcore/wl12xx: spi: add wifi support to cm-t335

 .../bindings/net/wireless/ti,wlcore,spi.txt        | 34 ++++++++
 arch/arm/boot/dts/am335x-cm-t335.dts               | 57 +++++++++++++-
 drivers/net/wireless/ti/wlcore/spi.c               | 92 +++++++++++++++++++++-
 3 files changed, 178 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
