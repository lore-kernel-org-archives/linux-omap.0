From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/3] USB MUSB patches for OMAP4
Date: Thu, 11 Mar 2010 17:25:11 +0530
Message-ID: <1268308511-21415-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Greg,

Here is a Version 2 of driver patches that enable MUSB
driver support for OMAP4.

Maulik Mankad(3)

[PATCH v2 1/3] USB: MUSB: Set transceiver interface type
[PATCH v2 2/3] USB: MUSB: Build MUSB driver for OMAP4
[PATCH v2 3/3] USB: MUSB: Add OMAP4 support in MUSB driver

This version is re-based on top of 2.6.34-rc1 + MUSB build fix
patches available at [1].

The [PATCH 2/3] address a comment from Sergei.

The patches are tested on OMAP4430 SDP for MUSB peripheral
mode.

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/for-next 

Thanks,
Maulik
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
