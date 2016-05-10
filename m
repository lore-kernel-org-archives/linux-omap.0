From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: dra7: Add OCMCRAM nodes
Date: Tue, 10 May 2016 14:49:40 -0500
Message-ID: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This series adds ocmcram nodes to use the mmio-sram driver to dra7.dtsi
for use by all dra7xx and am57xx platforms. Not all ocmcram regions are
present on every SoC variant so all possible nodes are added to the parent
dtsi with the optional nodes marked "disabled". Board dts files that are
known to have silicon supporting them can then enable them as needed.

Patch two adds a "dummy" reserved region in the ocmcram1 node that acts
as a placeholder for the region that is needed by secure software running
on secure variants of the SoC. It is left as size zero with the intention
that either:

- The bootloader will step in and adjust the size based on what the
  secure software that is in use requires.
- A board dts with specific requirements will override the node with
  appropriate size.

The SRAM bindings in use are described in this patch [1] that is part of a
series that adds SRAM regions for OMAP3 platforms.

Regards,
Dave

[1] http://marc.info/?l=linux-omap&m=146283061230440&w=2

Dave Gerlach (2):
  ARM: dts: dra7: Add ocmcram nodes
  ARM: dts: dra7: Add ti,secure-ram node to ocmcram1 node

 arch/arm/boot/dts/dra7.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
