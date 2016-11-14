From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] PCI: dra7xx: Add support to force RC to work in GEN1
 mode
Date: Mon, 14 Nov 2016 15:24:00 -0600
Message-ID: <20161114212400.GA19092@bhelgaas-glaptop.roam.corp.google.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
 <1476190715-16884-4-git-send-email-kishon@ti.com>
 <20161111211528.GF9868@bhelgaas-glaptop.roam.corp.google.com>
 <8ecc1325-365d-bdec-d435-729e0ea49d20@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8ecc1325-365d-bdec-d435-729e0ea49d20-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

[+cc Shawn]

On Sat, Nov 12, 2016 at 12:40:10PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 12 November 2016 02:45 AM, Bjorn Helgaas wrote:
> > Hi Kishon,
> > 
> > On Tue, Oct 11, 2016 at 06:28:34PM +0530, Kishon Vijay Abraham I wrote:
> >> PCIe in AM57x/DRA7x devices is by default
> >> configured to work in GEN2 mode.  However there
> >> may be situations when working in GEN1 mode is
> >> desired. One example is limitation i925 (PCIe GEN2
> >> mode not supported at junction temperatures < 0C).
> >>
> >> Add support to force Root Complex to work in GEN1
> >> mode if so desired, but don't force GEN1 mode on
> >> any board just yet.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
> >>  drivers/pci/host/pci-dra7xx.c                    |   27 ++++++++++++++++++++++
> >>  2 files changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> index 60e2516..a3d6ca3 100644
> >> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> @@ -25,6 +25,7 @@ PCIe Designware Controller
> >>  
> >>  Optional Property:
> >>   - gpios : Should be added if a gpio line is required to drive PERST# line
> >> + - ti,pcie-is-gen1 : Force the PCIe controller to work in GEN1 (2.5 GT/s).
> > 
> > Can we use "max-link-speed" so it's similar to imx6?
> 
> yeah, maybe we should make it a generic PCI property?

I forgot that Shawn has already done this!  I had already merged those
patches on pci/host-rockchip, but I moved them to pci/host since
they're not Rockchip-specific.  Can you take a look at that and see if
you can do what you need based on that pci/host branch?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
