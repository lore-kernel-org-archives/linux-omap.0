From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 20:54:20 +0300
Message-ID: <20101020175420.GC3431@legolas.emea.dhcp.ti.com>
References: <4CBD9FD5.506@nokia.com>
 <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
 <4CBE9E69.6060803@nokia.com>
 <AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
 <4CBEB312.7060400@nokia.com>
 <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
 <20101020125407.GE2433@legolas.emea.dhcp.ti.com>
 <AANLkTi=+6bC=JALdCDKW_BS-jnNk3zFPuWuBT+aY=Utx@mail.gmail.com>
 <20101020151527.GF2883@legolas.emea.dhcp.ti.com>
 <AANLkTim-QeP0hfSVGUd-tHWso9HQv25TwapBBZ1KPD3=@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim-QeP0hfSVGUd-tHWso9HQv25TwapBBZ1KPD3=@mail.gmail.com>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Oct 20, 2010 at 11:22:17AM -0500, Felipe Contreras wrote:
>Users would not need to care... if they enable USB and USB_GADGET, it
>will be selected automatically for OMAP3, which is what users would
>expect.

wouldn't a user expect USB to be enabled if the board _has_ a USB
connector ?

>I was talking more about developers.
>
>How should the help be fixed?
>"Select y if you are using an OMAP3 system that has TWL4030"

If you have the TWL4030 family of PMIC chips and want to use USB, you
probably need this. If unsure, say Y.

>1) Do you think all the OMAP3 boards should add that?

why not ?

>2) What if you don't want to use USB?

what if you don't want to use USB and we use your choice of:

default y if ARCH_OMAP3 ??

what's the big difference ? The default will be "USB enabled" and if you
don't want, just drop it. The thing is that in most cases we want to
support what is wired on the board. RX51 has a USB micro-B connector, so
by default we want USB peripheral enabled and host disabled. If a user
(or developer for that matter) wants to play with the unsupported host
mode on RX51, he will enable that part by himself and pray for it to
work. If, on the other hand, a camera developer doesn't need USB at all
and decides to save a few bytes on the binary, he will make sure to
disable it.

The thing is that there's no way to make everybody happy, so we stick to
what the board is wired to do.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
