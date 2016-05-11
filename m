From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: dra7: Add ocmcram nodes
Date: Wed, 11 May 2016 08:07:41 -0500
Message-ID: <20160511130741.GR20461@borg.dal.design.ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
 <1462909782-14639-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462909782-14639-2-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2016 at 02:49:41PM -0500, Dave Gerlach wrote:
> Add all ocmcram nodes to dra7.dtsi using the generic mmio-sram driver.
> DRA7xx and AM57xx families of SoCs can contain three ocmcram regions of
> SRAM, one of 512kb and also an optional two additional of 1Mb each. Mark
> the two additional 1MB regions of SRAM as disabled as only ocmcmram1 is
> on all variants of the SoCs, then depending on which specific variant
> is in use the ocmcram2 and ocmcram3 nodes can be enabled in the board
> dts file if the data manual for that part number indicates the ocmcram
> region is available.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Reviewed-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>


Regards,

--
Andreas Dannenberg
Texas Instruments Inc

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
