From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] Get rid of ifdef in board file
Date: Tue,  5 Jan 2010 14:14:42 +0530
Message-ID: <1262681082-5540-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Here is the Version 3 of the 2 patch series based 
on top of your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Maulik Mankad (2):
[PATCH 1/2] USB : Add empty functions in otg.h
[PATCH 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c

The Version 3 of the patch set fixes the comments 
received for Version 2.

Felipe, Greg, Tony

Note that Patch 1 needs to go through Greg (USB) and 
Patch 2 through Tony (OMAP). 

Patch 2/2 depends on Patch 1/2. 

The patches are compile tested and do not report
any checkpatch warnings.

Thanks,
Maulik

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
