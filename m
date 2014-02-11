From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Tue, 11 Feb 2014 10:21:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1402111017440.1209-100000@iolanthe.rowland.org>
References: <7h38jq8nk9.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7h38jq8nk9.fsf-4poPxKt068f/PtFMR13I2A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Feb 2014, Kevin Hilman wrote:

> > The issue started I think with the following patch getting merged:
> > ehci-platform: Add support for clks and phy passed through devicetree
> > some version of http://www.spinics.net/lists/linux-usb/msg101061.html
> > introduced { .compatible = "usb-ehci", },
> 
> This is what I was getting at: an understanding of what caused the
> failue in the first place.
> 
> > Now, in the build we have two drivers which dts claims compatibility
> > with, but only 1 driver actually works (drivers/usb/host/ehci-omap.c)
> > for the platform. Thinking that way, in fact, the current
> > compatibility even matches drivers/usb/host/ehci-ppc-of.c which
> > obviously wont work either.
> 
> Right, so I agree that it makes sense to remove a compatible string
> where there is no compatability, but a couple other things should happen
> here.
> 
> 1) changelog should describe why this compatible string is in the omap
> dtsi files in first place.
> 
> 2) investigation into the patch that introduced this change to double
> check it's not introducing other breakage as well.

Oddly enough, it was Roger who introduced this incorrect compatibility 
string in commit f17c89948dcd6 (ARM: dts: OMAP4: Add HS USB Host IP 
nodes).  There is no explanation in the commit log of why the string is 
there.

We better remove it from all the files where it doesn't belong.  Of
course, this won't help existing hardware.  It will still be necessary 
to change the compatibility string used for the generic platform 
drivers.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
