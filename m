From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 0/6] ARM: OMAP2+: dts: cm-t335: initial support
Date: Tue, 24 Nov 2015 16:02:07 +0200
Message-ID: <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add basic support for CompuLab cm-t335 module based on AM335X SoC.

CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
The module is built around the Texas Instruments Sitara AM3352/4
system-on-chip.

The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
Ethernet, CAN bus.

[v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions ]
Ilya Ledvich (6):
  ARM: OMAP2+: dts: cm-t335: add initial support
  ARM: OMAP2+: dts: cm-t335: add basic support for I2C
  ARM: OMAP2+: dts: cm-t335: add support for NAND flash
  ARM: OMAP2+: dts: cm-t335: add support for MMC
  ARM: OMAP2+: dts: cm-t335: add support for network device
  ARM: OMAP2+: dts: cm-t335: add support for PWM backlight

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               | 348 +++++++++++++++++++++
 3 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
