From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] DRA72/DRA74: Add 2 lane support
Date: Thu, 7 Jan 2016 11:41:26 -0600
Message-ID: <20160107174126.GB14105@localhost>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452077393-25880-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

[+cc Richard]

Hi Kishon,

On Wed, Jan 06, 2016 at 04:19:51PM +0530, Kishon Vijay Abraham I wrote:
> Add driver modifications in pci-dra7xx to get x2 mode working in
> DRA72 and DRA74. Certain modifications is needed in PHY driver also
> which will be sent as a separate series.
> 
> Certain board modifications has to be done in order to test
> x2 mode in dra72-evm.
> 
> These patches were created on pci next.
> 
> Changes from RFC:
> *) .b1co_mode_sel_mask is now set with the correct value.
> *) cleanup the patch
> 
> Kishon Vijay Abraham I (2):
>   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
>   pci: host: pci-dra7xx: Enable x2 mode support
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 +-
>  drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
>  2 files changed, 97 insertions(+), 15 deletions(-)

Apparently dra7xx in mainline doesn't work [1].  Until that's
resolved, I'm going to ignore dra7xx patches.

Bjorn

[1] http://lkml.kernel.org/r/20160106214518.GA6106-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
