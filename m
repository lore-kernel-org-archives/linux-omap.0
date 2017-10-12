From: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Subject: [Patch 0/6] ARM: dts/hwmod: Add CAL and VPE nodes
Date: Thu, 12 Oct 2017 14:27:13 -0500
Message-ID: <20171012192719.15193-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series adds the needed HWMOD and DTSI nodes
for the CAL and VPE modules.
We also document the VPE DT bindings.

Benoit Parrot (6):
  ARM: dts: DRA72: Add CAL dtsi node
  ARM: DRA7: hwmod: Add CAL nodes
  ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP only
  dt-bindings: media: ti-vpe: Document VPE driver
  ARM: DRA7: hwmod: Add VPE nodes
  ARM: dts: dra7: Add VPE dtsi node

 Documentation/devicetree/bindings/media/ti-vpe.txt | 41 ++++++++++
 arch/arm/boot/dts/dra7.dtsi                        | 26 +++++++
 arch/arm/boot/dts/dra72x.dtsi                      | 31 ++++++++
 arch/arm/mach-omap2/clockdomains7xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 87 ++++++++++++++++++++++
 5 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt

-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
