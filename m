From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 09:18:46 -0700
Message-ID: <20130723161846.GD2486@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51EE9EC0.6060905-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Daniel
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 23, 2013 at 08:48:24PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 23 July 2013 08:07 PM, Alan Stern wrote:
> > On Tue, 23 Jul 2013, Tomasz Figa wrote:
> > 
> >> On Tuesday 23 of July 2013 09:29:32 Tomasz Figa wrote:
> >>> Hi Alan,
> > 
> > Thanks for helping to clarify the issues here.
> > 
> >>>> Okay.  Are PHYs _always_ platform devices?
> >>>
> >>> They can be i2c, spi or any other device types as well.
> > 
> > In those other cases, presumably there is no platform data associated
> > with the PHY since it isn't a platform device.  Then how does the
> > kernel know which controller is attached to the PHY?  Is this spelled
> > out in platform data associated with the PHY's i2c/spi/whatever parent?
> 
> Yes. I think we could use i2c_board_info for passing platform data.
> > 
> >>>>>> 	PHY.  Currently this information is represented by name or 
> >> ID
> >>>>>> 	strings embedded in platform data.
> >>>>>
> >>>>> right. It's embedded in the platform data of the controller.
> >>>>
> >>>> It must also be embedded in the PHY's platform data somehow.
> >>>> Otherwise, how would the kernel know which PHY to use?
> >>>
> >>> By using a PHY lookup as Stephen and I suggested in our previous
> >>> replies. Without any extra data in platform data. (I have even posted a
> >>> code example.)
> > 
> > I don't understand, because I don't know what "a PHY lookup" does.
> 
> It is how the PHY framework finds a PHY, when the controller (say USB)requests
> a PHY from the PHY framework.
> > 
> >>>> In this case, it doesn't matter where the platform_device structures
> >>>> are created or where the driver source code is.  Let's take a simple
> >>>> example.  Suppose the system design includes a PHY named "foo".  Then
> >>>> the board file could contain:
> >>>>
> >>>> struct phy_info { ... } phy_foo;
> >>>> EXPORT_SYMBOL_GPL(phy_foo);
> >>>>
> >>>> and a header file would contain:
> >>>>
> >>>> extern struct phy_info phy_foo;
> >>>>
> >>>> The PHY supplier could then call phy_create(&phy_foo), and the PHY
> >>>> client could call phy_find(&phy_foo).  Or something like that; make up
> >>>> your own structure tags and function names.
> >>>>
> >>>> It's still possible to have conflicts, but now two PHYs with the same
> >>>> name (or a misspelled name somewhere) will cause an error at link
> >>>> time.
> >>>
> >>> This is incorrect, sorry. First of all it's a layering violation - you
> >>> export random driver-specific symbols from one driver to another. Then
> > 
> > No, that's not what I said.  Neither the PHY driver nor the controller
> > driver exports anything to the other.  Instead, both drivers use data
> > exported by the board file.
> 
> I think instead we can use the same data while creating the platform data of
> the controller and the PHY.
> The PHY driver while creating the PHY (using PHY framework) will also pass the
> *data* it actually got from the platform data to the framework.
> The PHY user driver (USB), while requesting for the PHY (from the PHY
> framework) will pass the *data* it got from its platform data.
> The PHY framework can do a comparison of the *data* pointers it has and return
> the appropriate PHY to the controller.
> > 
> >>> imagine 4 SoCs - A, B, C, D. There are two PHY types PHY1 and PHY2 and
> >>> there are two types of consumer drivers (e.g. USB host controllers). Now
> >>> consider following mapping:
> >>>
> >>> SoC	PHY	consumer
> >>> A	PHY1	HOST1
> >>> B	PHY1	HOST2
> >>> C	PHY2	HOST1
> >>> D	PHY2	HOST2
> >>>
> >>> So we have to be able to use any of the PHYs with any of the host
> >>> drivers. This means you would have to export symbol with the same name
> >>> from both PHY drivers, which obviously would not work in this case,
> >>> because having both drivers enabled (in a multiplatform aware
> >>> configuration) would lead to linking conflict.
> > 
> > You're right; the scheme was too simple.  Instead, the board file must
> > export two types of data structures, one for PHYs and one for
> > controllers.  Like this:
> > 
> > struct phy_info {
> > 	/* Info for the controller attached to this PHY */
> > 	struct controller_info	*hinfo;
> > };
> > 
> > struct controller_info {
> > 	/* Info for the PHY which this controller is attached to */
> > 	struct phy_info		*pinfo;
> > };
> > 
> > The board file for SoC A would contain:
> > 
> > struct phy_info phy1 = {&host1);
> > EXPORT_SYMBOL(phy1);
> > struct controller_info host1 = {&phy1};
> > EXPORT_SYMBOL(host1);
> > 
> > The board file for SoC B would contain:
> > 
> > struct phy_info phy1 = {&host2);
> > EXPORT_SYMBOL(phy1);
> > struct controller_info host2 = {&phy1};
> > EXPORT_SYMBOL(host2);
> 
> I meant something like this
> struct phy_info {
> 	const char *name;
> };
> 
> struct phy_platform_data {
> 	.
> 	.
> 	struct phy_info *info;
> };
> 
> struct usb_controller_platform_data {
> 	.
> 	.
> 	struct phy_info *info;
> };
> 
> struct phy_info phy_info;
> 
> While creating the phy device
> 	struct phy_platform_data phy_data;
> 	phy_data.info = &info;
> 	platform_device_add_data(pdev, &phy_data, sizeof(*phy_data))
> 	platform_device_add();
> 
> While creating the controller device
> 	struct usb_controller_platform_data controller_data;
> 	controller_data.info = &info;
> 	platform_device_add_data(pdev, &controller_data, sizeof(*controller_data))
> 	platform_device_add();
> 
> Then modify PHY framework API phy create
> 	phy_create((struct device *dev, const struct phy_ops *ops,
>         void *priv)  {//API changed to take void pointer instead of label
> 		. //existing implementation
> 		.
> 		phy->priv = priv;
> 	}
> 
> 	struct phy *phy_get(struct device *dev, const char *string, void *priv) {
> //API changed to take an additional pointer
> 		phy_lookup(priv)
> 	}
> 
> 	static struct phy *phy_lookup(void *priv) {
> 		.
> 		.
> 		if (phy->priv==priv) //instead of string comparison, we'll use pointer
> 			return phy;
> 	}
> 
> PHY driver should be like
> 	phy_create((dev, ops, pdata->info);
> 
> The controller driver would do
> 	phy_get(dev, NULL, pdata->info);
> 
> Now the PHY framework will check for a match of *priv* pointer and return the PHY.
> 
> I think this should be possible?

Ick, no.  Why can't you just pass the pointer to the phy itself?  If you
had a "priv" pointer to search from, then you could have just passed the
original phy pointer in the first place, right?

The issue is that a string "name" is not going to scale at all, as it
requires hard-coded information that will change over time (as the
existing clock interface is already showing.)

Please just pass the real "phy" pointer around, that's what it is there
for.  Your "board binding" logic/code should be able to handle this, as
it somehow was going to do the same thing with a "name".

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
