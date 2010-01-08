From: "Maulik" <x0082077-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 0/2] ARM : OMAP patches
Date: Fri, 8 Jan 2010 11:22:19 +0530
Message-ID: <001601ca9026$bf673710$808918ac@apr.dhcp.ti.com>
References: <1262265701-17550-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262265701-17550-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Felipe,

Do you have any comments on Version 3 of this patch series as per the below
link.

http://marc.info/?l=linux-usb&m=126226571531540&w=2
 
This series applies cleanly on top of your for-tony branch.

Also note that the series depends on the 2 patch series as below.
[PATCH 1/2] USB : Add empty functions in otg.h 
[PATCH 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c

http://marc.info/?l=linux-usb&m=126268112828212&w=2

Regards,
Maulik

-----Original Message-----
From: Maulik Mankad [mailto:x0082077-l0cyMroinI0@public.gmane.org] 
Sent: Thursday, December 31, 2009 6:52 PM
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Maulik Mankad; Tony Lindgren; Felipe Balbi;
Greg Kroah-Hartman
Subject: [PATCH v3 0/2] ARM : OMAP patches

Hi,

Felipe,

Here is the Version 3 of the 2 patch series based on top of 
your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Please note that this series depends on the patches 
that remove if-def's from code found at [2].

[2] http://marc.info/?l=linux-omap&m=126226514430984&w=2

Maulik Mankad (2):
ARM : OMAP: MUSB : Pass board specific data using a structure.
ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file

The patches are compile tested and do not report
any checkpatch warnings.

The patch set addresses comments received for Version 2.

Thanks,
Maulik


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
