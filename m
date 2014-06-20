From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 04/18] PCI: designware: use untranslated address while programming ATU
Date: Fri, 20 Jun 2014 18:18:23 +0200
Message-ID: <5173253.SQfLkZY3Wx@wuerfel>
References: <1401345500-20188-1-git-send-email-kishon@ti.com> <1401345500-20188-5-git-send-email-kishon@ti.com> <53A1571B.7080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A1571B.7080806-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Mohit Kumar <mohit.kumar-qxv4g6HH51o@public.gmane.org>, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Andrew Murray <Andrew.Murray-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 June 2014 14:38:43 Kishon Vijay Abraham I wrote:
> On Thursday 29 May 2014 12:08 PM, Kishon Vijay Abraham I wrote:
> > 
> > Here the CPU address for configuration space is 0x20013000 and the controller
> > address for configuration space is 0x13000. The controller address should be
> > used while programming the ATU (in order for translation to happen properly in
> > DRA7xx).
> 
> I've fixed this up with what you suggested in the v1 of the series. Do you
> think this is fine?

Hi Kishon,

Yes, I think this will work and do the right thing in all cases. I'm not
completely sure if the change should be generalized into the range
parser or better kept in the pcie-designware driver as you do it here:

> > @@ -406,6 +413,12 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >               pp->config.cfg1_size = resource_size(cfg_res)/2;
> >               pp->cfg0_base = cfg_res->start;
> >               pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
> > +
> > +             /* Find the untranslated configuration space address */
> > +             index = of_property_match_string(np, "reg-names", "config");
> > +             addrp = of_get_address(np, index, false, false);
> > +             pp->cfg0_mod_addr = of_read_number(addrp, ns);
> > +             pp->cfg1_mod_addr = pp->cfg0_mod_addr + pp->config.cfg0_size;

I think I've recently seen some objections to hand-parsing standard
properties in driver code.

> >       } else {
> >               dev_err(pp->dev, "missing *config* reg space\n");
> >       }
> > @@ -431,12 +444,20 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >                       pp->config.io_size = resource_size(&pp->io);
> >                       pp->config.io_bus_addr = range.pci_addr;
> >                       pp->io_base = range.cpu_addr;
> > +
> > +                     /* Find the untranslated IO space address */
> > +                     pp->io_mod_addr = of_read_number(parser.range -
> > +                                                      parser.np + na, ns);
> >               }

So the of_read_number() call could be moved into of_pci_range_to_resource(),
with another field added to struct of_pci_range to carry the address on
the parent bus. Any other thoughts on this? Maybe Rob Herring or Andrew
Murray have a strong opinion on this.


	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
