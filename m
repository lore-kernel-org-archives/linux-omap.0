From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
Date: Thu,  9 Oct 2014 21:06:22 +0200
Message-ID: <1412881594-25678-1-git-send-email-johan@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series fixes a few issues with the omap rtc-driver, cleans up a bit
and finally adds support for the PMIC control feature found in some
revisions of this RTC IP block.

Ultimately, this allows for powering off the Beaglebone and waking it up
again on RTC alarms.

I noticed yesterday that Lokesh Vutla recently posted some patches to
add regulator support to this driver. [1] While that series has some
issues that needs to be addressed, I still think it could be a good idea
to rebase my pmic_power_en patch on top of it as it adds some long
overdue device abstraction. That would be needed anyway in order to
support the new power-off infrastructure that's in the pipe in a clean
way. [2]

So my suggestion is to merge the first seven patches, rebase Lokesh
series on top of that, and then I rebase my final five patches on top
of that in turn. Hopefully, the new power-off handler call chain will
have stabilised by then.

Johan

[1] http://www.spinics.net/lists/devicetree/msg50869.html
[2] https://lkml.org/lkml/2014/10/7/30


Johan Hovold (12):
  rtc: omap: fix clock-source configuration
  rtc: omap: fix missing wakealarm attribute
  rtc: omap: fix class-device registration
  rtc: omap: remove unused register-base define
  rtc: omap: remove redundant debug message
  rtc: omap: use dev_info and dev_dbg
  rtc: omap: silence bogus power-up reset message at probe
  rtc: omap: restore irq state after reading TC registers
  rtc: omap: add support for pmic_power_en
  rtc: omap: enable wake-up from power off
  ARM: dts: am33xx: update rtc node compatible property
  ARM: dts: am335x-bone-common: enable power off and rtc wake up

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |   9 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   4 +
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +-
 drivers/rtc/rtc-omap.c                             | 202 ++++++++++++++++-----
 4 files changed, 173 insertions(+), 44 deletions(-)

-- 
2.0.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
