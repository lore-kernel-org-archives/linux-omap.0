From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 20:57:04 +0200
Message-ID: <20080320185703.GB4772@kedavra.cpe.vivax.com.br>
References: <5DF83221BE20114E9C331F665ACBC0800477C16D@dbde01.ent.ti.com> <8657b483f1b99c61a4d5d142a5af48ba@felipebalbi.com> <5DF83221BE20114E9C331F665ACBC0800477C178@dbde01.ent.ti.com> <8763vhpbh4.fsf@paris.hilman.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40657 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbYCTSzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 14:55:04 -0400
Content-Disposition: inline
In-Reply-To: <8763vhpbh4.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Felipe Balbi <me@felipebalbi.com>, Linux omap <linux-omap@vger.kernel.org>

On Thu, Mar 20, 2008 at 10:11:03AM -0700, Kevin Hilman wrote:
> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
> 
> > Felipe
> >
> >>Sent: Thursday, March 20, 2008 6:09 PM
> >>To: Pandita, Vikram
> >>Cc: Kevin Hilman; Linux omap
> >>Subject: RE: OMAP3430: MUSB host and hot-plugging
> >>
> >>
> >>> If you can provide us the procedure to enable hot-plugging for MUSB on
> >>> OMAP3430, we will look into this issue.
> >>
> >>As far as musb driver is concerned it should be just a mater of
> >>building it with otg support. But as of now, I cannot get id
> >>pin status to musb using twl4030.
> >>
> >>Maybe we still have some missing pieces on linux-omap, which I'm
> >>researching on that.
> >
> >
> >  I meant if you could pass on how you have written the hot plugging
> > function/agent for MUSB.  I have not tried hot-plugging on omap.
> 
> There's no additional code.  You can reproduce this with current OMAP
> git, and default omap_3430sdp_defconfig, which enables MUSB in OTG
> mode.
> 
> Here's what I do:
> 
> - plug in cable (mini-A to A-female)
> - boot
> - after booting, plug in USB storage device.
>   on my userland, hotplug does its thing, and the usb/scsi storage modules
>   are loaded, and I can then access /dev/sda* 
> - unplug USB key.
>   kernel msgs show the disconnect happens etc.
> 
> - replug USB key --- nothing happens

Same here. Although if you unplug and replug right away, it'll work.
That's because musb was still waiting in a_wait_bcon state and I didn't
let it fall into b_idle.

That's why I'm suspecting on twl4030_phy_{suspend,resume}() routines.
After reading twl4030's docs I couldn't find anything suspicious on the
code but I'll dig more tomorrow and after the holidays.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
