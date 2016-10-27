From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] ARM: dts: am33xx: Add clock info to rtc nodes
Date: Thu, 27 Oct 2016 11:18:05 +0530
Message-ID: <1477547288-5041-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The series adds the clock info to rtc node.

Boot tested and checked for rtc ticking on am335x-boneblack, am335x-bone
am437x-gp-evm.

Keerthy (3):
  ARM: dts: AM335X-bone-common: Add the internal and external clock
    nodes for rtc
  ARM: dts: AM335X-evm: Add the internal and external clock nodes for
    rtc
  ARM: dts: AM335X-evmsk: Add the internal and external clock nodes for
    rtc

 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 arch/arm/boot/dts/am335x-evm.dts          | 5 +++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 5 +++++
 arch/arm/boot/dts/am33xx.dtsi             | 2 ++
 4 files changed, 17 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
