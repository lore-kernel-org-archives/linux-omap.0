From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: omap5-uevm: Audio related fixes
Date: Wed, 23 Oct 2013 12:32:18 +0300
Message-ID: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

When the omap5-evm.dts file has been renamed to omap5-uevm.dts and the sEVM
support got deprecated in favor of uEVM (or Panda5) the content was not
validated.
The reset GPIO is different on uEVM compared to sEVM and uEVM does not have
support for dmic.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
  ARM: dts: omap5-uevm: Remove pinmux for dmic pins

 arch/arm/boot/dts/omap5-uevm.dts | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
