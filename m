From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/7] Support TPS65217 PMIC interrupt in DT
Date: Fri, 21 Oct 2016 23:00:59 +0900
Message-ID: <20161021140106.21531-1-woogyom.kim@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

TPS65217 interrupt events include push button pressed/released, USB and AC 
voltage status change. AM335x bone based boards (like BB, BBB, BBG) have 
common PMIC interrupt pin (named NMI) of AM335x core.

This patchset support interrupts in device tree file.

Milo Kim (7):
  ARM: dts: tps65217: Specify the interrupt controller
  ARM: dts: tps65217: Add the charger device
  ARM: dts: tps65217: Add the power button device
  ARM: dts: am335x: Support the PMIC interrupt
  ARM: dts: am335x: Add the charger interrupt
  ARM: dts: am335x: Add the power button interrupt
  mfd: tps65217: Fix mismatched interrupt number

 arch/arm/boot/dts/am335x-bone-common.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/tps65217.dtsi           | 12 ++++++++++++
 include/linux/mfd/tps65217.h              |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
