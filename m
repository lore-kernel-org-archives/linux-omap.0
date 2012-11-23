From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Fri, 23 Nov 2012 11:27:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211231125350.1734-100000@iolanthe.rowland.org>
References: <20121123103817.GC29585@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121123103817.GC29585-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Nov 2012, Felipe Balbi wrote:

> > And maybe the same sort of scheme could be used for clocks, although I 
> > don't know how to do it in a generic way that will work on all 
> > platforms.
> 
> perhaps making use of pm_clk_add() and letting PM layer do the rest for
> us ? If that doesn't work then it means PM layer's clk handling could be
> improved, I suppose.

Is the clock framework sufficiently generic at this point that it can
be used by core code (like the PM layer)?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
