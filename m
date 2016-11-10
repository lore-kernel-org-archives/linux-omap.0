From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Thu, 10 Nov 2016 10:50:33 -0700
Message-ID: <20161110175033.GD27724@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <7547144.tJtJXeDM1m@avalon>
 <20161110150152.GA27724@atomide.com>
 <2615056.HmWtlhPO5J@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2615056.HmWtlhPO5J@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161110 10:18]:
> I'll try to give it a go, but right now I'm stuck with a different MUSB 
> problem :-) I'm trying to boot my panda board over the SMSC95xx ethernet, and 
> have switched gadget support from being compiled in to being compiled as a 
> module. I then get
> 
> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle while active
> 
> printed in a loop at boot time. I've traced musb->is_active being set to 1 in 
> musb_start() with 
> 
> musb->port_mode = MUSB_PORT_MODE_DUAL_ROLE
> musb->xceiv->otg->state = OTG_STATE_A_IDLE
> devctl = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_VBUS
> 
> I can disable gadget support completely which will I believe fix the problem, 
> but that's just a workaround. Help would be appreciated.

Do you have the ID pin grounded or how do you get to the
A_IDLE state? I'm pretty much only testing with loadable
modules as in omap2plus_defconfig, I don't think I've seen
this issue..

Maybe check the changes in your .config against just plain
omap2plus_defconfig? Are you trying to force host only mode?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
