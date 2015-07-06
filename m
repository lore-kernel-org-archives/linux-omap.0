From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/7] tty: 8250: omap: workaround for IP errata and a bug fix
Date: Mon, 6 Jul 2015 15:17:50 +0530
Message-ID: <cover.1436174801.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series works around "Advisory 21" as documented in
AM437x SoC errata[1]. AM335x and DRA7x also suffer from
the same errata and chip design team is in the process
of updating the errata documents of those devices as well.

Patch 1/7 fixes a related bug but can be applied independently.

Series applies to v4.2-rc1

[1] http://www.ti.com/lit/er/sprz408b/sprz408b.pdf

Sekhar Nori (7):
  tty: serial: 8250: omap: fix kernel crash in suspend-to-ram
  Documentation: DT: omap_serial: document missing compatible
  tty: 8250: omap: introduce function to update mdr1
  tty: 8250: omap eliminate use of of_machine_is_compatible()
  tty: 8250: workaround errata on disabling UART after using DMA
  tty: 8250: omap: workaround module disable errata on dra7x SoCs
  ARM: dts: dra7: workaround UART module disable errata

 .../devicetree/bindings/serial/omap_serial.txt     |   3 +
 arch/arm/boot/dts/am33xx.dtsi                      |  12 +--
 arch/arm/boot/dts/dra7.dtsi                        |  20 ++--
 drivers/tty/serial/8250/8250_omap.c                | 110 ++++++++++++++++-----
 4 files changed, 103 insertions(+), 42 deletions(-)

-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
