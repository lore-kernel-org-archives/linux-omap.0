From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: twl4030-usb.c
Date: Wed, 21 Jan 2009 13:32:07 +0200
Message-ID: <20090121113207.GA9233@scadufax.research.nokia.com>
References: <1232536259.6515.351.camel@ubuntu>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59985 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703AbZAULnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 06:43:40 -0500
Content-Disposition: inline
In-Reply-To: <1232536259.6515.351.camel@ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Jan 21, 2009 at 01:10:59PM +0200, ext Kalle Jokiniemi wrote:
> 
> The twl4030-usb.c seems to have moved from /drivers/usb/otg back
> to /drivers/i2c/chips after the recent mainline merge. Felipe, any plans
> to put it back to drivers/usb/otg?
> 
> I have a patch for twl4030-usb enabling regulator switching, so I'm just
> wondering against what tree should I post the patch. And to which list?

how about you git pull ?? For me it appears under drivers/usb/otg:

HEAD: commit 45e5c5ffd32ade5a21a5e87b4040072590ec3ae1

~/workspace/linux-omap-2.6$ ls drivers/usb/otg/
gpio_vbus.c  isp1301_omap.c  Kconfig  Makefile  otg.c  twl4030-usb.c

-- 
balbi
