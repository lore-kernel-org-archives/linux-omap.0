From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 00/37] cbus patches
Date: Thu, 8 Apr 2010 02:23:11 -0700
Message-ID: <20100408092310.GB14005@atomide.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59136 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0DHJXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 05:23:08 -0400
Content-Disposition: inline
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* felipe.balbi@nokia.com <felipe.balbi@nokia.com> [100407 09:05]:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Hi all,
> 
> I still have to test these patches, but I fell like it's
> time to get some comments.
> 
> There's still a big TODO for the whole cbus drivers:
> 
> . cleanup all tahvo drivers
> . instantiate platform_device on board-files
> . pass platform_data to retu/tahvo and their children from board-files
> . move retu-headset to jack abstraction layer (??)
> . move retu-user.c to platform_driver
> . move tahvo and retu to generic-irq
> . move tahvo and retu to mfd
> . move tahvo and retu to threaded irq (??)
> . move all children drivers to proper locations
> . move cbus.c to a common location (drivers/misc ??)
> . allow any arch to use cbus.c by passing correct gpio numbers
> . get it all into mainline.
> 
> anyways, these patches were lightly boot tested on n810 and
> compile tested with n770_defconfig.
> 
> patches also available on cbus branch of git://gitorious.org/usb/usb.git

Great, let's make sure these work for 770 and N8x0 and then
merge. One step closer to getting rid of the last remaining
legacy branch..

Tony
