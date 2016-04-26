From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Tue, 26 Apr 2016 09:49:19 -0700
Message-ID: <20160426164918.GA5995@atomide.com>
References: <Pine.LNX.4.44L0.1604261102000.2038-100000@iolanthe.rowland.org>
 <571F9AD4.8010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571F9AD4.8010900-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160426 09:46]:
> 
> 
> On 26.04.2016 18:03, Alan Stern wrote:
> >On Tue, 26 Apr 2016, Felipe Balbi wrote:
> >
> >>>Is there a reason why a process (pnatd in this particular case) doesn't
> >>>get killed on reboot?
> >>
> >>there might be, and that's probably the bug we're trying to figure
> >>out. But so far, no idea.
> >
> >One possible reason is that the process is in an uninterruptible wait
> >inside the kernel, waiting for something that isn't going to happen.
> 
> The process waits in poll(&fds, 1u, -1), where fds contains only the fd of
> /dev/ttyGS2. Nothing suspicious I can see here.

I think the easy way to reproduce this is to start getty or minicom
on /dev/ttyG* and disconnect the USB cable.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
