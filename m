From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Thu, 29 Nov 2012 12:57:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211291247130.1535-100000@iolanthe.rowland.org>
References: <50B6F8CF.8020304@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B6F8CF.8020304-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 29 Nov 2012, Andy Green wrote:

> However I think what you're saying about binding to hub power is good. 
> The hub ports are not devices, but it would be possible to bind an asset 
> array to them and make the pre- and post- code functions.

In the 3.6 kernel, hub ports are not devices.  In 3.7 they are -- that 
is, each hub port has its own struct device.

> I think it will be possible to address objections around the "pathiness" 
> by being able to seed the path match with a platform_device pointer 
> (there exists in the board file time a platform_device for ehci-omap.0 
> ...) and just matching the remainder on a single usb device's name, like 
> "*-1.1-1".

Can you think of a way to do this without checking for a match every 
time a new device is registered?  For instance, in this case it would 
be preferable to do this match only for descendants of ehci-omap.0.  To 
match the port device, the string would have to be something like 
"*-0:1.0/port2".

In fact, if the match were anchored at the end of the string, we 
wouldn't need the wildcard at all -- at least, not in this case.  The 
string could simply be "-0:1.0/port2".  But that's only if the match is 
restricted to devices below ehci-omap.0.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
