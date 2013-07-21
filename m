From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Sat, 20 Jul 2013 22:32:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307202223430.8250-100000@netrider.rowland.org>
References: <20130720220006.GA7977@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130720220006.GA7977-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, 20 Jul 2013, Greg KH wrote:

> > >>That should be passed using platform data.
> > >
> > >Ick, don't pass strings around, pass pointers.  If you have platform
> > >data you can get to, then put the pointer there, don't use a "name".
> > 
> > I don't think I understood you here :-s We wont have phy pointer
> > when we create the device for the controller no?(it'll be done in
> > board file). Probably I'm missing something.
> 
> Why will you not have that pointer?  You can't rely on the "name" as the
> device id will not match up, so you should be able to rely on the
> pointer being in the structure that the board sets up, right?
> 
> Don't use names, especially as ids can, and will, change, that is going
> to cause big problems.  Use pointers, this is C, we are supposed to be
> doing that :)

Kishon, I think what Greg means is this:  The name you are using must
be stored somewhere in a data structure constructed by the board file,
right?  Or at least, associated with some data structure somehow.  
Otherwise the platform code wouldn't know which PHY hardware
corresponded to a particular name.

Greg's suggestion is that you store the address of that data structure 
in the platform data instead of storing the name string.  Have the 
consumer pass the data structure's address when it calls phy_create, 
instead of passing the name.  Then you don't have to worry about two 
PHYs accidentally ending up with the same name or any other similar 
problems.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
