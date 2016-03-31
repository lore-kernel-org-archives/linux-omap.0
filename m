From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Thu, 31 Mar 2016 13:00:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603311255560.1516-100000@iolanthe.rowland.org>
References: <56FD512C.2070108@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FD512C.2070108-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 31 Mar 2016, Ivaylo Dimitrov wrote:

> > This isn't supposed to cause any problems.  The two instances should
> > never run at the same time, because they belong to different configs.
> >
> 
> The problem seems to be that fsg driver creates a thread for every 
> fsg_bind() call, which overwrites common->thread_task without first 
> checking if a thread is already created. I don't know the idea behind - 
> should it have only one thread for all instances, or there should be a 
> thread per instance, but anyway the current implementation looks wrong.

You've put your finger on the problem.

Michal, I'm not sure how you intended to handle this.  We only need to
have one thread per interface (even if there's more than one LUN), but
if there are multiple mass-storage interfaces in one configuration then
you might want to have multiple threads.  Of course, then you would
have to handle cases where one config has one mass-storage interface
and another config has two...

It's your decision, but clearly the driver needs to be fixed.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
