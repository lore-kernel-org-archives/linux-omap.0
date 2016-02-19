From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] arm: am43xx: Register rtc hwmod
Date: Fri, 19 Feb 2016 10:08:53 +0530
Message-ID: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch adds rtc hwmod. This is present on gp and sk evm and not on
epos evm. Hence adding it selectively using a seprate list.

Boot tested on AM437X-GP-EVM and AM437X-SK-EVM and checked
for rtc ticking on AM437X-GP-EVM.

Keerthy (2):
  ARM: dts: am43x-epos-evm: Add the am438 compatible string
  ARM: AM43XX: HWMOD: Add rtc hwmod

 Documentation/devicetree/bindings/arm/omap/omap.txt |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts                |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c          | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
