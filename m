From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2]  ARM: AM437X: Add rtc clock handling
Date: Thu, 13 Aug 2015 12:37:46 +0530
Message-ID: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The series is applicable for all am437x series of processors.
It adds clock handling support. Boot tested on am437x-gp-evm.

Keerthy (2):
  ARM: dts: AM437x: Add the internal and external clock nodes for rtc
  rtc: omap: Add external clock enabling support

 arch/arm/boot/dts/am4372.dtsi        |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts  | 13 +++++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts |  9 ++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts  |  9 ++++++++
 drivers/rtc/rtc-omap.c               | 44 ++++++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
