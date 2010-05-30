From: Marco Stornelli <marco.stornelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: omap udc driver problem with beagle board
Date: Sun, 30 May 2010 11:53:49 +0200
Message-ID: <4C0235AD.70008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Embedded <linux-embedded-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

I'm using the kernel 2.6.34 with the beagle board rev. c4. I have got
some problems with the ethernet gadget to use nfs over usb. The problem
is with the usb. When the g_ether driver register itself, the omap udc
driver returns ENODEV because the kernel didn't call the probe for
this driver. Looking at the code, it seems the problem is in board
specific management of the usb. There isn't the registration of the
platform device to match the omap udc platform driver. It should be done
in the omap_usb_init() but in case of beagle board this function is
never called, so omap udc driver cannot work. Is it a regression? Is
there any workaround?

Thanks.

Regards,

Marco
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
