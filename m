From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: MUSB crash on OMAP3 board with second load of gadget
Date: Thu, 21 Jan 2010 14:28:39 +0200
Message-ID: <20100121122839.GB26015@nokia.com>
References: <48239d391001210326y25986d59hd10d390ef9c8ddea@mail.gmail.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48239d391001210326y25986d59hd10d390ef9c8ddea-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Sergey Lapin <slapinid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 21, 2010 at 12:26:49PM +0100, ext Sergey Lapin wrote:
>Hi! I have crashes in MUSB code when working with USB gadget drivers.
>Kernel version: linux-omap master d8ebff302ff819587377b123e900e501e4135d86
>To reproduce: (USB device cable should be attached).
>
>dd if=/dev/zero of=/tmp/disk bs=1k count=1024
>mkdosfs -F 32 /tmp/disk
>insmod g_mass_storage  file=/tmp/disk stall=0
>
>Wait till disk is mounted on host, then
>
>rmmod g_mass_storage
>insmod g_mass_storage  file=/tmp/disk stall=0
>
>And here we get Oops in include/linux/list.h line 93,

I guess it's the list corruption bug, right ?

I've seen that, but couldn't get it to reproduce. Now that you said, 
I'll try to find a fix for it.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
