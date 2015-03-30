From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/7] dmaengine: of_dma: Support for DMA routers
Date: Mon, 30 Mar 2015 22:50:23 +0530
Message-ID: <20150330172023.GH7192@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-2-git-send-email-peter.ujfalusi@ti.com>
 <20150326105018.GJ32683@intel.com>
 <5513F77A.4030005@ti.com>
 <20150326153221.GM32683@intel.com>
 <55154C39.3030602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55154C39.3030602-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 27, 2015 at 02:25:29PM +0200, Peter Ujfalusi wrote:
> On 03/26/2015 05:32 PM, Vinod Koul wrote:
> >> I have added the DT binding document since this series adds support for
> >> routers for platforms booting with DT:
> >>
> >> Documentation/devicetree/bindings/dma/dma.txt | 28 ++++++++
> > I meant the update to Documnetation/dmanegine/ for routers :)
> 
> I see. In what form you think we should have the documentation? Is it adequate
> to lift and adjust the text from the DT binding document here? Should we have
> a separate file for the router description?
> My concern was and this is why I did not wrote anything under here is that the
> code I add is only covers the DT boot case and I'm not planning to add legacy
> support. The ACPI binding can be done in a similar fashion as the DT so you
> would have a translator driver with ACPI API.
Not the binding part but more of a guideline on how to go about solving the
DMA router design for drivers

-- 
~Vinod

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
