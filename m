From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra7: Add OCMCRAM nodes
Date: Fri, 10 Jun 2016 03:43:17 -0700
Message-ID: <20160610104316.GU22406@atomide.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462909782-14639-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [160510 12:52]:
> Hi,
> This series adds ocmcram nodes to use the mmio-sram driver to dra7.dtsi
> for use by all dra7xx and am57xx platforms. Not all ocmcram regions are
> present on every SoC variant so all possible nodes are added to the parent
> dtsi with the optional nodes marked "disabled". Board dts files that are
> known to have silicon supporting them can then enable them as needed.
> 
> Patch two adds a "dummy" reserved region in the ocmcram1 node that acts
> as a placeholder for the region that is needed by secure software running
> on secure variants of the SoC. It is left as size zero with the intention
> that either:
> 
> - The bootloader will step in and adjust the size based on what the
>   secure software that is in use requires.
> - A board dts with specific requirements will override the node with
>   appropriate size.
> 
> The SRAM bindings in use are described in this patch [1] that is part of a
> series that adds SRAM regions for OMAP3 platforms.

Applying these two into omap-for-v4.8/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
