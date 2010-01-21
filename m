From: Sergey Lapin <slapinid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: MUSB crash on OMAP3 board with second load of gadget
Date: Thu, 21 Jan 2010 14:26:49 +0300
Message-ID: <48239d391001210326y25986d59hd10d390ef9c8ddea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi! I have crashes in MUSB code when working with USB gadget drivers.
Kernel version: linux-omap master d8ebff302ff819587377b123e900e501e4135d86
To reproduce: (USB device cable should be attached).

dd if=/dev/zero of=/tmp/disk bs=1k count=1024
mkdosfs -F 32 /tmp/disk
insmod g_mass_storage  file=/tmp/disk stall=0

Wait till disk is mounted on host, then

rmmod g_mass_storage
insmod g_mass_storage  file=/tmp/disk stall=0

And here we get Oops in include/linux/list.h line 93,
list_del function, which leads us to drivers/usb/musb/musb_gadget.c,
function void musb_g_giveback(
        struct musb_ep          *ep,
        struct usb_request      *request,
        int                     status),
just at the beginning of function.

if we add
pr_debug("list.prev = %p\n", request->list.prev);
pr_debug("list.next = %p\n", request->list.next);

and we see

list.prev = 6b6b6b6b
list.next = 6b6b6b6b

And these are NOT values set during list deletion.

Any ideas where to debug from here? If I just do return from that
function in case
of list.prev = 6b6b6b6b, then there's no crash, but there's no working
USB either.
if I just ignore list_del, I have crash later, where it seems to
execute bad code
from address 0x6b6b6b6a. Please, help!

Thanks a lot,
S.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
