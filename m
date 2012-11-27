From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 15:10:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211271446430.1489-100000@iolanthe.rowland.org>
References: <50B51313.2060003@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43100 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755682Ab2K0UKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 15:10:20 -0500
In-Reply-To: <50B51313.2060003@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Wed, 28 Nov 2012, Andy Green wrote:

> OK.  So I try to sketch it out iteractively to try to get in sync:
> 
> device.h:
> 
> 	enum asset_event {
> 		AE_PROBED,
> 		AE_REMOVED
> 	};
> 
> 	struct device_asset {
> 		char *name; /* name of regulator, clock, etc */
> 		void *asset; /* regulator, clock, etc */
> 		int (*handler)(struct device *dev_owner, enum asset_event asset_event, 
> struct device_asset *asset);
> 	};

Another possibility is to have two handlers: one for pre-probe and the
other for post-remove.  Then of course asset_event wouldn't be needed.  
Linus tends to prefer this strategy -- separate functions for separate
events.  That's why struct dev_pm_ops has so many method pointers.

> 	struct device {
> 	...
> 		struct device_asset *assets;

Or a list instead of a NULL-terminated array.  It depends on whether
people will want to add or remove assets dynamically.  For now an array
would be fine.

> 	...
> 	};
> 
> 
> drivers/base/dd.c | really_probe():
> 
> ...
> 	struct device_asset *asset;
> ...
> 	asset = dev->assets;
> 	while (asset && asset->name) {

Maybe it would be better to test asset->handler.  Some assets might not 
need names.

> 		if (asset->handler(dev, AE_PROBED, asset)) {
> 			/* clean up and bail */
> 		}
> 		asset++;
> 	}
> 
> 	/* do probe */
> ...
> 
> 
> drivers/base/dd.c | __device_release_driver:  (is this really the best 
> place to oppose probe()?)

The right place is just after the remove method is called, so yes.

> ...
> 	struct device_asset *asset;
> ...
> 
> 	/* call device ->remove() */
> ...
> 	asset = dev->assets;
> 	while (asset && asset->name) {
> 		asset->handler(dev, AE_REMOVED, asset);
> 		asset++;
> 	}

It would be slightly safer to iterate in reverse order.

> ...
> 
> 
> board file:
> 
> 	static struct regulator myreg = {
> 		.name = "mydevice-regulator",
> 	};
> 
> 	static struct device_asset mydevice_assets[] = {
> 		{
> 			.name = "mydevice-regulator",
> 			.handler = regulator_default_asset_handler,
> 		},
> 		{ }
> 	};
> 
> 	static struct platform_device mydevice = {
> 	...
> 		.dev = {
> 			.assets = mydevice_assets,
> 		},
> 	...
> 	};
> 
> 
> regulator code:
> 
> int regulator_default_asset_handler(struct device *dev_owner, enum 
> asset_event asset_event, struct device_asset *asset)
> {
> 	struct regulator **reg = &asset->asset;
> 	int n;
> 
> 	switch (asset_event) {
> 	case AE_PROBED:
> 		*reg = regulator_get(dev_owner, asset->name);
> 		if (IS_ERR(*reg))
> 			return *reg;

PTR_ERR.

> 		n = regulator_enable(*reg);
> 		if (n < 0)
> 			regulator_put(*reg);
> 		return n;
> 
> 	case AE_REMOVED:
> 		regulator_put(*reg);
> 		break;
> 	}
> 
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(regulator_default_asset_handler);
> 
> 
> The subsystems that can expect to get used (clock...) might each want to 
> define a default handler like the one for regulator.  That'll be an end 
> to the code duplication issue.  The user can still do his own handler if 
> he wants.
> 
> I put a name field in so we can use regulator_get() nicely, we don't 
> need access to the object pointer or that it exists at boardfile-time 
> that way either.  But I can see it's arguable.

It hadn't occurred to me, but it seems like a good idea.

Yes, overall this is almost exactly what I had in mind.

> >> Throwing out the path stuff and limiting this to platform_device means
> >> you cannot bind to dynamically created objects like hub or anything
> >> downstream of a hub.  So Felipe's identification of the hub as the
> >> happening place to do this is out of luck.
> >
> > Greg pointed out that this could be useful for arbitrary devices, not
> > just platform devices, so it could be applied to dynamically created
> > objects.
> 
> Well that is cool, but to exploit that in the dynamic object case 
> arrangements for identifying the appropriate object has appeared are 
> needed.

For example, this scheme wouldn't lend itself easily to associating the
regulator with the particular root-hub port that the LAN95xx is
attached to.  I can't think of any reasonable way to do that other than
the approaches we have already considered.

>  We have a nice array of platform_devices nicely there in the 
> board file we can attach assets to like "pdev[1].dev.assets = xxx;" but 
> that's not there in dynamic device case.  Anyway this sounds like what 
> we're discussing can be well worth establishing and might lead to that 
> later.

Agreed.

Alan Stern

