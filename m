From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: dwc3: add Fujitsu Specific Glue layer
Date: Mon, 05 Jan 2015 16:28:34 +0100
Message-ID: <3428284.QtTr113xXr@wuerfel>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com> <1456155.YPH2fYoGgF@wuerfel> <20150103012128.GA11373@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150103012128.GA11373@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-oma
List-Id: linux-omap@vger.kernel.org

On Friday 02 January 2015 19:21:28 Felipe Balbi wrote:
> 
> On Tue, Dec 30, 2014 at 11:12:51AM +0100, Arnd Bergmann wrote:
> > On Monday 29 December 2014 01:52:04 Sneeker Yeh wrote:
> > > > > +static int dwc3_mb86s70_remove_child(struct device *dev, void *unused)
> > > > > +{
> > > > > +     struct platform_device *pdev = to_platform_device(dev);
> > > > > +
> > > > > +     of_device_unregister(pdev);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static u64 dwc3_mb86s70_dma_mask = DMA_BIT_MASK(32);
> > > >
> > > > why ? Use dma_coerce_mask_and_coherent().
> > > >
> > > 
> > > okay.
> > 
> > Actually that is still wrong: we use dma_coerce_mask_and_coherent() to
> > annotate drivers that have traditionally been forcing their own dma mask
> > by some other means and that need to be changed to something proper (after
> > finding out why they did it in the first place).
> > 
> > Since this is about a child device, the correct interface is to use
> > platform_device_register_full().
> 
> no, that's wrong. He's essentially fixing the default set by OF core,
> which is always 32-bits anyway, so this can actually be removed. Your
> suggestion would just make it worse.

Ah, so this was for a device that gets probed from DT? Yes, then no
change is needed here at all.

Note that I'm working on a patch set to change the DT initialization to
be a little smarter about the mask. Specifically any device whose parent
has a smaller dma-ranges window than 4GB needs to start out with the
smaller mask, and the dma_set_mask function that is called to allow 64-bit
DMA on a device will check if the bus can actually support it.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
