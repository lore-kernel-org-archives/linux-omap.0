From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Device usb1 failed to suspend: error -16
Date: Tue, 12 Jan 2010 17:10:32 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A3987E0@dbde02.ent.ti.com>
References: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com>
 <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
 <4B4B6E55.9000406@ti.com>
 <54B31811B83D744D90BF0289EB447D4609978796D3@MAIL-MB1.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab0ALLkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 06:40:40 -0500
In-Reply-To: <54B31811B83D744D90BF0289EB447D4609978796D3@MAIL-MB1.oerlikon.ca>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Weng, Wending
> Sent: Tuesday, January 12, 2010 12:34 AM
> To: linux-omap
> Subject: PM: Device usb1 failed to suspend: error -16
> 
> Hi All,
> 
> 	I tried to suspend the system, and got the following messages:
> 
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> musb_bus_suspend 2261: trying to suspend as a_host while active
> pm_op(): usb_dev_suspend+0x0/0x8 returns -16
> PM: Device usb1 failed to suspend: error -16
> PM: Some devices failed to suspend

You need to apply MUSB and EHCI patches to fix this.

MUSB PM patch is already submitted (at [1]) and is in queue.
I plan to submit OMAP EHCI PM patch after some cleanups.

[1] http://marc.info/?l=linux-usb&m=126200057420865&w=2

-Ajay
> Restarting tasks ... Segmentation fault
> done.
> 
> I use linux-omap-2.6.git, should I use the branch linux-omap-pm? Thanks.
> 
> Wending Weng
> Software Engineer at Rheinmetall
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
