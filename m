From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/4] OMAP USB patches
Date: Tue,  2 Feb 2010 17:08:11 +0530
Message-ID: <1265110691-26473-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Here is the 4 patch series based on top of 2.6.33-rc6.

Maulik Mankad (4):
[PATCH 1/4] USB : Add empty functions in otg.h
[PATCH 2/4] ARM : OMAP : Remove #ifdef from board-omap3evm.c
[PATCH 3/4] ARM : OMAP: MUSB : Pass board specific data using a structure
[PATCH 4/4] ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file

The patches are compile tested and do not report 
any checkpatch warnings.

Thanks,
Maulik
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
