From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv2 0/4] lis3lv02d: update DT binding for use with Nokia N900
Date: Sat, 21 Mar 2015 21:19:01 +0100
Message-ID: <1426969145-4478-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

The lis302 has already a DT binding described in [0],
which descibes misc. hardware properties. The current
binding does not support all values needed to convert
the Nokia N900's platform data to DT, though.

This patchset introduces support for describing inverted
axis, configuration of second wakeup unit and wakeup
threshold support.

The series is based on top of v4.0-rc1 and has been
tested on my Nokia N900.

[0] Documentation/devicetree/bindings/misc/lis302.txt

-- Sebastian

Sebastian Reichel (4):
  lis3lv02d: DT: use s32 to support negative values
  lis3lv02d: DT: add wakeup unit 2 and wakeup threshold
  Documentation: DT: lis302: update wakeup binding
  DTS: ARM: OMAP3-N900: Add lis3lv02d support

 Documentation/devicetree/bindings/misc/lis302.txt |  9 +++-
 arch/arm/boot/dts/omap3-n900.dts                  | 52 +++++++++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d.c                | 56 +++++++++++++++--------
 3 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
