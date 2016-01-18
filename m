From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 18 Jan 2016 08:16:14 -0800
Message-ID: <20160118161613.GC19432@atomide.com>
References: <20160115224839.GA19432@atomide.com>
 <569A1E32.1020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569A1E32.1020502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160116 02:41]:
> Hi,
> 
> On 16.01.2016 00:48, Tony Lindgren wrote:
> >Hi all,
> >
> >Looks like there's some issue with the USB gadgets and configfs.
> >
> >I'm seeing rmmod of the UDC driver cause a warning and then reboot
> >hangs the system. This happens at least with v4.4, and I've reproduced
> >it with dwc3 and musb so it seems to be generic.
> >
> 
> Having configfs is not needed, disabling usb gadgets (#
> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least poweroff hang
> issue on N900. Also, g_nokia is not a module in the config I use, so I guess
> the problem is not related whether gadgets are modular or not. Unfortunately
> I was not able to test reboot, as rootfs became corrupted after the first
> poweroff :( . So it looks like my theory that onenand corruption on N900 is
> because poweroff/reboot hangs is wrong.

Oh OK so this is the same reboot bug you mentioned earlier. And yes
this $subject bug should not be related to the n900 legacy userspace
onenand corruption you're seeing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
