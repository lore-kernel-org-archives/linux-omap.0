From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] DRA7 Timer extended support
Date: Tue, 5 Apr 2016 16:44:08 -0500
Message-ID: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Following series includes couple of patches to add the missing
Timer12 and enable Timers 13 through 16 by default, and a timer
errata fix on DRA7 platforms.  The Timer errata is documented in
the public AM572x Silicon Errata document [1].

Patches 2 and 3 were reposted versions of the two patches left
out from the DRA7 Timer12 Support series [1] from last year.
Only difference is in Patch 2 where the node is not marked
as disabled anymore compared to the previous version [3]

Patches baselined on 4.6-rc2.

regards
Suman

[1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
[2] http://marc.info/?l=linux-omap&m=144408774017569&w=2
[3] https://patchwork.kernel.org/patch/7332221/

Keerthy (1):
  ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Suman Anna (3):
  ARM: dts: DRA7: Enable Timers 13 through 16
  ARM: dts: DRA7: Add timer12 node
  ARM: DRA7: hwmod: Add data for GPTimer 12

 arch/arm/boot/dts/dra7.dtsi                | 13 +++++++----
 arch/arm/mach-omap2/clockdomains7xx_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 36 ++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
