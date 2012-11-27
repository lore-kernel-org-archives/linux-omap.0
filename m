From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 11:37:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211271131130.1489-100000@iolanthe.rowland.org>
References: <50B40320.2020206@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B40320.2020206-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 27 Nov 2012, Andy Green wrote:

> > I don't know if such an approach would be sufficiently general for
> > future requirements, but it would solve the problem at hand.
> 
> We can get a notification about device creation and do things there. 
> But the cost of that is like the tuple suggestion, they'll only be able 
> to do a fixed thing like operate on regulators.

I'm not quite sure what you mean by that.  _Any_ function is capable of 
doing only a fixed thing.

> Actually the targeted device may have arbitrary associated assets like 
> generic GPIO to turn on a "flash" for built-in webcam controlled 
> out-of-band.  These also can be reached by known names.  And the driver 
> may wish to do things with them that are more complex than enable / 
> disable or follow logical lifecycle of the hub or whatever.

Let's worry about that when it arises.

> However when the guidance from Greg is that we can do nothing except 
> complain at hardware designers for some reason I failed to quite 
> identify, I fear we are moving deckchairs on the titanic.

Greg's advice was simply not to rely on pathnames in sysfs because they 
aren't fixed in stone.  That leaves plenty of other ways to approach 
this problem.

Basically, what you want is for something related to device A (the
regulator or the GPIO) to happen whenever device B (the ehci-omap.0
platform device) is bound to a driver.  The most straightforward way to
arrange this is for A's driver to have a callback that is invoked
whenever B is bound or unbound.  The most straightforward way to 
arrange _that_ is to allow each platform_device to have a list of 
callbacks.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
