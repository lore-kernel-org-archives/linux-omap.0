From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: Add ti,secure-ram node to ocmcram1
 node
Date: Wed, 11 May 2016 08:09:13 -0500
Message-ID: <20160511130913.GS20461@borg.dal.design.ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
 <1462909782-14639-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462909782-14639-3-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2016 at 02:49:42PM -0500, Dave Gerlach wrote:
> Secure variants of DRA7xx and AM57xx SoCs may need to reserve a region
> of the SRAM for use by secure software. To account for this, add a child
> node to the ocmcram1 node that will act as a placeholder at the start
> of the SRAM for the reserved region of memory that may be required
> by secure services. The node is added with size 0 so that by default
> parts will have the full space available but the bootloader or board dts
> file is able to resize the node as needed depending on how much reserved
> space is needed, if any, so end users of the ocmcram1 region on HS parts
> must be aware that a smaller amount of SRAM than expected may be available.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Reviewed-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>

--
Andreas Dannenberg
Texas Instruments Inc
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
