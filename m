From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 0/5] ARM: dts: omap: Fix some DTC warnings
Date: Fri,  1 Apr 2016 16:20:17 -0400
Message-ID: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony

DTC reports a lot of warnings on omap DTS due a mismatch between unit
names and reg properties in different device nodes. This series tries
to fix at least some of them, but there are still a lot remaining.

Best regards,
Javier


Javier Martinez Canillas (5):
  ARM: dts: omap: add missing unit name to pbias regulator nodes
  ARM: dts: n8x0: remove unneeded unit name for i2c node
  ARM: dts: omap3: add missing unit name to PMU node
  ARM: dts: omap: remove unneeded unit name for sound nodes
  ARM: dts: omap: add missing unit names to bandgap nodes

 arch/arm/boot/dts/am437x-gp-evm.dts         | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts        | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts     | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts   | 2 +-
 arch/arm/boot/dts/dra7-evm.dts              | 2 +-
 arch/arm/boot/dts/dra7.dtsi                 | 2 +-
 arch/arm/boot/dts/dra72-evm.dts             | 2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 arch/arm/boot/dts/omap2430.dtsi             | 2 +-
 arch/arm/boot/dts/omap3.dtsi                | 4 ++--
 arch/arm/boot/dts/omap34xx.dtsi             | 2 +-
 arch/arm/boot/dts/omap36xx.dtsi             | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi   | 2 +-
 arch/arm/boot/dts/omap4.dtsi                | 2 +-
 arch/arm/boot/dts/omap443x.dtsi             | 2 +-
 arch/arm/boot/dts/omap4460.dtsi             | 2 +-
 arch/arm/boot/dts/omap5.dtsi                | 2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
