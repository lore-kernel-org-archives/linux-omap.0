From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] omap: Fix broken address translation for pbias
Date: Thu, 3 Sep 2015 16:57:49 +0530
Message-ID: <1441279673-28105-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: t-kristo-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

pbias device stopped having memory resource after
"ARM: dts: <platform>: add minimal l4 bus layout with control module
support" got merged. This results in platform_get_resource returning
-EINVAL in pbias driver. This is because address translation fails
while trying to convert the address to resource which happens
during the device creation process during boot up.

Even though after [1], reg property in pbias dt node is un-used,
it might be an issue if we plan to use it at a later point of time.

Patch series is created on top of [1].

[1] -> https://lkml.org/lkml/2015/9/3/51

Verified the address in omap4 panda, omap5 uevm and dra72 boards.

Kishon Vijay Abraham I (4):
  ARM: dts: omap24xx: fix address translation for pbias
  ARM: dts: omap4: fix address translation for pbias
  ARM: dts: omap5: fix address translation for pbias
  ARM: dts: dra7: fix address translation for pbias

 arch/arm/boot/dts/dra7.dtsi     |    1 +
 arch/arm/boot/dts/omap2430.dtsi |    1 +
 arch/arm/boot/dts/omap4.dtsi    |    1 +
 arch/arm/boot/dts/omap5.dtsi    |    1 +
 4 files changed, 4 insertions(+)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
