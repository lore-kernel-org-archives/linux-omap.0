From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH 0/3] ARM: dts: Enable suspend configuration
Date: Thu, 11 Aug 2016 10:57:47 +0530
Message-ID: <1470893270-5042-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now that https://lkml.org/lkml/2016/8/10/243 series is in. 
Here is the set of Device Tree patches which were dependent on
the driver patches.

These are boot tested on am437x-gp-evm.

Keerthy (1):
  ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6
    enable during suspend

Tero Kristo (2):
  ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff
    mode
  ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff
    mode

 arch/arm/boot/dts/am437x-gp-evm.dts | 13 +++++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
