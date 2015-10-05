From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] DRA7 Timer12 Support
Date: Mon, 5 Oct 2015 18:28:20 -0500
Message-ID: <1444087704-1429-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This is a revised version of the DRA7 Timer12 support patch series [1].
The series mainly is respun to fix a build issue caused by Patch1 [2]
with omap1_defconfig due to the absence of Common Clock framework for
OMAP1.

Only Patch 1 is modified from the previous series. I have also revised
the check slightly to fix another issue seen when requesting Timer12
on OMAP3, as that is a fixed clock and does return back with a parent
count of 1.

Series baselined on v4.3-rc3 just like the original series, and tested
on all generations (AMx3x, OMAP4, OMAP5 and DRA7) except OMAP1 and OMAP2
generations. 

regards
Suman

[1] http://marc.info/?l=linux-omap&m=144372799601354&w=2
[2] https://patchwork.kernel.org/patch/7311021/

Suman Anna (4):
  ARM: OMAP: dmtimer: check for fixed timers during config
  ARM: OMAP2+: timer: Remove secure timer for DRA7xx HS devices
  ARM: dts: DRA7: Add timer12 node
  ARM: DRA7: hwmod: Add data for GPTimer 12

 arch/arm/boot/dts/dra7.dtsi               | 10 +++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 36 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/timer.c               |  6 +++---
 arch/arm/plat-omap/dmtimer.c              |  7 ++++++
 4 files changed, 54 insertions(+), 5 deletions(-)

-- 
2.6.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
