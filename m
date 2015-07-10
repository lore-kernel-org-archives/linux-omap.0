From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] Add missing #iommu-cells on IOMMU nodes
Date: Fri, 10 Jul 2015 12:28:54 -0500
Message-ID: <1436549336-33456-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This series adds the #iommu-cells property to the existing
IOMMU nodes on OMAP4 & OMAP5. It was already fixed for OMAP3
in commit 2055088b5e17 ("ARM: dts: omap3: Add #iommu-cells to
isp and iva iommu").

OMAP4 and OMAP5 do not yet have users for these IOMMUs (remoteproc
nodes), so the warning as seen with the fix added for OMAP3 is not
seen yet, but will as soon as a user is added.

Patches based on 4.2-rc1.

regards
Suman

Suman Anna (2):
  ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
  ARM: dts: OMAP5: Add #iommu-cells property to IOMMUs

 arch/arm/boot/dts/omap4.dtsi | 2 ++
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
