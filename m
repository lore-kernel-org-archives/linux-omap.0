From: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 0/2] Watchdog: omap_wdt: Retrieve bootstatus via syscon
Date: Tue, 15 Nov 2016 09:44:01 +0100
Message-ID: <30190331.OfTuxcilGU@corpeters>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds device tree compatiblility to the watchdog status 
feature from the omap-wdt driver and adds support for that feature to
the am33xx.dti device-tree include.

It is my first patch so any comments/suggestions are welcome.

Cor Peters (2):
  Watchdog: omap_wdt: Retrieve bootstatus via syscon.
  ARM: am33xx.dtsi: Added syscon compatible prcm_dev device

 arch/arm/boot/dts/am33xx.dtsi |  6 ++++++
 drivers/watchdog/omap_wdt.c   | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
