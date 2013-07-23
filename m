From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 19:48:11 +0200
Message-ID: <19656720.FrnhefyPXl@amdc1227>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <1446965.6APW5ZgLBW@amdc1227> <20130723173710.GB28284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20130723173710.GB28284-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Daniel
List-Id: linux-omap@vger.kernel.org

On Tuesday 23 of July 2013 10:37:11 Greg KH wrote:
> On Tue, Jul 23, 2013 at 06:50:29PM +0200, Tomasz Figa wrote:
> > > Ick, no.  Why can't you just pass the pointer to the phy itself?  If
> > > you
> > > had a "priv" pointer to search from, then you could have just passed
> > > the
> > > original phy pointer in the first place, right?
> > 
> > IMHO it would be better if you provided some code example, but let's
> > try to check if I understood you correctly.
> 
> It's not my code that I want to have added, so I don't have to write
> examples, I just get to complain about the existing stuff :)

Still, I think that some small code snippets illustrating the idea are 
really helpful.

> > 8><--------------------------------------------------------------------
> > ----
> > 
> > [Board file]
> > 
> > static struct phy my_phy;
> > 
> > static struct platform_device phy_pdev = {
> > 
> > 	/* ... */
> > 	.platform_data = &my_phy;
> > 	/* ... */
> > 
> > };
> > 
> > static struct platform_device phy_pdev = {
> > 
> > 	/* ... */
> > 	.platform_data = &my_phy;
> > 	/* ... */
> > 
> > };
> > 
> > [Provider driver]
> > 
> > struct phy *phy = pdev->dev.platform_data;
> > 
> > ret = phy_create(phy);
> > 
> > [Consumer driver]
> > 
> > struct phy *phy = pdev->dev.platform_data;
> > 
> > ret = phy_get(&pdev->dev, phy);
> > 
> > -----------------------------------------------------------------------
> > -><8
> > 
> > Is this what you mean?
> 
> No.  Well, kind of.  What's wrong with using the platform data structure
> unique to the board to have the pointer?
> 
> For example (just randomly picking one), the ata-pxa driver would change
> include/linux/platform_data/ata-pxa.h to have a phy pointer in it:
> 
> struct phy;
> 
> struct  pata_pxa_pdata {
> 	/* PXA DMA DREQ<0:2> pin */
> 	uint32_t	dma_dreq;
> 	/* Register shift */
> 	uint32_t	reg_shift;
> 	/* IRQ flags */
> 	uint32_t	irq_flags;
> 	/* PHY */
> 	struct phy	*phy;
> };
> 
> Then, when you create the platform, set the phy* pointer with a call to
> phy_create().  Then you can use that pointer wherever that plaform data
> is available (i.e. whereever platform_data is at).

Hmm? So, do you suggest to call phy_create() from board file? What phy_ops 
struct and other hardware parameters would it take?

> > > The issue is that a string "name" is not going to scale at all, as it
> > > requires hard-coded information that will change over time (as the
> > > existing clock interface is already showing.)
> > 
> > I fully agree that a simple, single string will not scale even in some,
> > not so uncommon cases, but there is already a lot of existing lookup
> > solutions over the kernel and so there is no point in introducing
> > another one.
> I'm trying to get _rid_ of lookup "solutions" and just use a real
> pointer, as you should.  I'll go tackle those other ones after this one
> is taken care of, to show how the others should be handled as well.

There was a reason for introducing lookup solutions. The reason was that in 
board file there is no way to get a pointer to something that is going to be 
created much later in time. We don't do time travel ;-).

> > > Please just pass the real "phy" pointer around, that's what it is
> > > there
> > > for.  Your "board binding" logic/code should be able to handle this,
> > > as
> > > it somehow was going to do the same thing with a "name".
> > 
> > It's technically correct, but quality of this solution isn't really
> > nice, because it's a layering violation (at least if I understood what
> > you mean). This is because you need to have full definition of struct
> > phy in board file and a structure that is used as private data in PHY
> > core comes from platform code.
> 
> No, just a pointer, you don't need the "full" structure until you get to
> some .c code that actually manipulates the phy itself, for all other
> places, you are just dealing with a pointer and a structure you never
> reference.
> 
> Does that make more sense?

Well, to the point that I think I now understood your suggestion. 
Unfortunately the suggestion alone isn't really something that can be done, 
considering how driver core and generic frameworks work.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
