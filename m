From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: MUSB Error Handling
Date: Fri, 3 Nov 2017 15:37:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1711031531580.1743-100000@iolanthe.rowland.org>
References: <CAHCN7x+ojzXUtHNOJT4bQbpCfXQpNPEx1imS54rbfZw7DXC3jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHCN7x+ojzXUtHNOJT4bQbpCfXQpNPEx1imS54rbfZw7DXC3jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 3 Nov 2017, Adam Ford wrote:

> One other similar question.  I apologize for my ignorance. It appears
> as if the MUSB support suspending and resume in host mode.  If we can
> predict that the noise will generate, we're hoping to suspend the USB
> before the noise even, then resume the USB after the noise event in
> hopes that the USB doesn't disconnect and re-connect again.
> 
> Can someone point me to the right place for the documentation on how
> to suspend only the USB?  I know how to make the whole system suspend.

In general, you can't do it unless the devices on the USB bus are all
idle and suspended.

For information on runtime suspend, see 
Documentation/driver-api/pm/devices.rst and 
Documentation/driver-api/usb/power-management.rst.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
