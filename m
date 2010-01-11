From: "Weng, Wending" <WWeng@rheinmetall.ca>
Subject: PM: Device usb1 failed to suspend: error -16
Date: Mon, 11 Jan 2010 14:03:45 -0500
Message-ID: <54B31811B83D744D90BF0289EB447D4609978796D3@MAIL-MB1.oerlikon.ca>
References: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com>
 <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
 <4B4B6E55.9000406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.rheinmetall.ca ([207.61.105.111]:52105 "EHLO
	MAIL-ET.oerlikon.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751087Ab0AKTDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 14:03:50 -0500
In-Reply-To: <4B4B6E55.9000406@ti.com>
Content-Language: fr-FR
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi All,

	I tried to suspend the system, and got the following messages:

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
musb_bus_suspend 2261: trying to suspend as a_host while active
pm_op(): usb_dev_suspend+0x0/0x8 returns -16
PM: Device usb1 failed to suspend: error -16
PM: Some devices failed to suspend
Restarting tasks ... Segmentation fault
done.

I use linux-omap-2.6.git, should I use the branch linux-omap-pm? Thanks.

Wending Weng
Software Engineer at Rheinmetall
