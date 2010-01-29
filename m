From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/2] Get rid of ifdef in board file
Date: Fri, 29 Jan 2010 17:05:05 +0530
Message-ID: <1264764905-16647-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Here is the Version 4 of the 2 patch series based 
on top of Felipe's for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Maulik Mankad (2):
[PATCH 1/2] USB : Add empty functions in otg.h
[PATCH 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c

The Version 4 of the patch set fixes the build break 
issue with Version 3 at [2]

[2] http://patchwork.kernel.org/patch/70950/

Patch 2/2 depends on Patch 1/2. 

The patches are compile tested and do not report
any checkpatch warnings.

Thanks,
Maulik

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
