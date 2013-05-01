From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Removing vestiges of CONFIG_USB_SUSPEND
Date: Wed, 1 May 2013 11:22:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305011115090.1380-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe and Kevin:

While removing the remaining usages of USB_SUSPEND (things that I
missed in the original patch), I noticed that
arch/arm/configs/omap2plus_defconfig does not enable PM_RUNTIME -- even
though it currently does enable USB_SUSPEND, which depends on
PM_RUNTIME.  Was this an oversight?

In a little while I will submit a patch which removes USB_SUSPEND from
that file.  You or someone else may want to write a separate patch to
enable PM_RUNTIME.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
