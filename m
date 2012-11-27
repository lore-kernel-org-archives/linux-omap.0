From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 13:09:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211271253230.1489-100000@iolanthe.rowland.org>
References: <50B4FBE9.5080301@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B4FBE9.5080301-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 28 Nov 2012, Andy Green wrote:

> > Greg's advice was simply not to rely on pathnames in sysfs because they
> > aren't fixed in stone.  That leaves plenty of other ways to approach
> > this problem.
> 
> It's sage advice, but there is zero code provided in my patches that 
> "relies on pathnames in sysfs".

In your 1/5 patch, _device_path_generate() concatenates device name
strings, starting from a device root and separating elements with '/'
characters.  Isn't that the same as a sysfs pathname?

> > Basically, what you want is for something related to device A (the
> > regulator or the GPIO) to happen whenever device B (the ehci-omap.0
> > platform device) is bound to a driver.  The most straightforward way to
> > arrange this is for A's driver to have a callback that is invoked
> > whenever B is bound or unbound.  The most straightforward way to
> > arrange _that_ is to allow each platform_device to have a list of
> > callbacks.
> 
> Sorry I didn't really understand this proposal yet.  You want "A", the 
> regulator, driver to grow a callback function that gets called when the 
> targeted platform_device ("B", ehci-omap.0) probe happens.  Could you 
> expand what the callback prototype or new members in the struct might 
> look like?  It's your tuple thing or we pass it an opaque pointer that 
> is the struct regulator * or suchlike?

Well, it won't be exactly the same as the tuple thing because no 
strings will be involved, but it would be similar.  The callback would 
receive an opaque pointer (presumably to the regulator) and a device 
pointer (the B device).

> Throwing out the path stuff and limiting this to platform_device means 
> you cannot bind to dynamically created objects like hub or anything 
> downstream of a hub.  So Felipe's identification of the hub as the 
> happening place to do this is out of luck.

Greg pointed out that this could be useful for arbitrary devices, not
just platform devices, so it could be applied to dynamically created
objects.

As for what Felipe said...  He suggested doing this when the hub driver 
binds to the controller's root hub.  The root hub is created when the 
controller's driver registers the new USB bus.  This happens as part of 
the driver's probe routine.  So what I have been talking about is very 
similar (in terms of when it happens) to what Felipe wanted.

Besides, Felipe wasn't thinking in the most general terms.  (In fact,
at first he confused the root hub with the LAN95xx's hub.)  There's no
reason to restrict this sort of thing to USB hubs (or to regulators,
for that matter).  The driver core is the right place for it.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
