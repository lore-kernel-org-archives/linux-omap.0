From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in
 dra7xx_pcie_init_irq_domain()
Date: Mon, 14 Nov 2016 15:19:28 -0600
Message-ID: <20161114211928.GD9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
 <20161111213806.GI9868@bhelgaas-glaptop.roam.corp.google.com>
 <1d95b915-ddc0-b48f-270b-fffb60ecfe5e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1d95b915-ddc0-b48f-270b-fffb60ecfe5e-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, bharat.kumar.gogada-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

[+cc Shawn, Heiko, Michal, Soren, Bharat, Rob H, Frank, devicetree@vger]

On Sat, Nov 12, 2016 at 12:39:01PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 12 November 2016 03:08 AM, Bjorn Helgaas wrote:
> > On Mon, Oct 17, 2016 at 02:54:37PM +0000, Wei Yongjun wrote:
> >> From: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >>
> >> This node pointer is returned by of_get_next_child() with refcount
> >> incremented in this function. of_node_put() on it before exitting
> >> this function on error.
> >>
> >> This is detected by Coccinelle semantic patch.
> >>
> >> Signed-off-by: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > 
> > Kishon, this looks correct to me, so I applied it to pci/host-dra7xx for
> > v4.10.  Let me know if you have any issue with it.
> > 
> >> ---
> >>  drivers/pci/host/pci-dra7xx.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> >> index 9595fad..79297e9 100644
> >> --- a/drivers/pci/host/pci-dra7xx.c
> >> +++ b/drivers/pci/host/pci-dra7xx.c
> >> @@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> >>  					       &intx_domain_ops, pp);
> >>  	if (!pp->irq_domain) {
> >>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> >> +		of_node_put(pcie_intc_node);
> 
> I think of_node_put should be used for both the error case and non-error case.

Hmm, OK.  I don't know what the rules are.  Certainly if we made these
drivers modular, I don't think we'd want to leak these references
every time we unload/reload the module.  Should we do the put
immediately here, or in the module remove path, or ...?

Adding other driver and DT folks for comment.

I dropped these patches for now (dra7xx, rockchip, xilinx-nwl,
xilinx).
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
