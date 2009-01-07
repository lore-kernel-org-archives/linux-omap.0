From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Backlight driver for omap3evm
Date: Wed, 7 Jan 2009 20:52:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB7E0701@dbde02.ent.ti.com>
References: <1231340151-16790-1-git-send-email-premi@ti.com>
 <1231340830.5331.22.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbZAGPWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 10:22:14 -0500
In-Reply-To: <1231340830.5331.22.camel@dax.rpnet.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Richard Purdie [mailto:rpurdie@rpsys.net] 
> Sent: Wednesday, January 07, 2009 8:37 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Backlight driver for omap3evm
> 
> On Wed, 2009-01-07 at 20:25 +0530, Sanjeev Premi wrote:
> > This patch implements the backlight driver for OMAP3EVM.
> > The mechanism for backlight control is reused from the existing 
> > controls in lcd_omap3evm.c.
> 
> Please see the reply to the email you sent me offlist. What 
> happens when you run this driver on something that isn't an omap3evm?

The driver implementation depends upon CONFIG_MACH_OMAP3EVM.

> 
> The problem is that this bit:
> 
> omap_backlight_dev = platform_device_alloc(OMAPBL_DEVNAME, -1);
> 

Ah, this bit can be moved to board specific file in "mach-omap2" directory.

> should be done in the platform code for the board, not in the 
> general driver. If you do that, you should be able to reuse 
> most of the generic-bl device code.

I tried so, but wasn't able to get the Kconfig dependencies right to get 'generic-bl' into my build. Hence, removed the code that I believed to be generic (since yesterday's mail) and created the patch.

Will give another try.

> 
> Regards,
> 
> Richard
> 
> 
> 