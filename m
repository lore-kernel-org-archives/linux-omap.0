From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Enabling MUSB support
Date: Fri, 29 Aug 2008 10:20:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C418C223@dbde02.ent.ti.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
 <20080827133825.GC7354@gandalf.research.nokia.com>
 <200808272354.28531.david-b@pacbell.net>
 <20080828090719.GG7354@gandalf.research.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
 <20080828102842.GK7354@gandalf.research.nokia.com>
 <20080828112032.GL7354@gandalf.research.nokia.com>
 <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51696 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYH2Eu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 00:50:29 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I tested MUSB controller on OMAP35xx EVM 
> (omap3_evm_defconfig) for g_ether gadget and it works fine 
> with Windows XP. I am using v2.6.26-omap2 tag.
> 
> Regards,
> Ajay

2.6.26-omap2 did not have the problem. 2.6.27-rc3 does.

The MUSB code hasn't changed in this time. But the gadget code did.
I am unable to use bisect for this as I can't compile for OMAP3 in
the commits in between. But I did find a pair of good-bad commits.

baee1ca8e61aa9df034e1706052a0eefc193f688 is bad
509f205d619490294dc2b2d7c25b987f2e9c2789 is good

Diff between the trees at these point shows musb code is identical.
But gadget framework has completely changed. Since those commits
trickled down from upstream, I can't catch the bad one without
manually sifting through and applying them,

I won't be able to look into this for a while. g_file_storage works
just fine though. So maybe it's just in the gadget framework.

If someone can verify that this fails on other device controllers as
well, then let's loop in linux-usb. Or should we do that right away?

- Anand


> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Thursday, August 28, 2008 4:51 PM
> To: Felipe Balbi
> Cc: Gadiyar, Anand; ext David Brownell; ext Ashwin Bihari; 
> linux-omap@vger.kernel.org
> Subject: Re: Enabling MUSB support
> 
> On Thu, Aug 28, 2008 at 01:28:42PM +0300, Felipe Balbi wrote:
> > On Thu, Aug 28, 2008 at 03:49:17PM +0530, ext Gadiyar, Anand wrote:
> > > There's another issue we noticed today with the SDP and beagleboard.
> > > 
> > > MUSB in peripheral or OTG mode with g_ether causes a Windows PC to
> > > throw a blue-screen-of-death upon connect. g_file_storage/g_zero did
> > > not seem to have this problem. Regression, as 2.6.26 was working just fine.
> > > 
> > > Will look into it when I can find the time - a bisect should catch the bug.
> > 
> > would be worth trying other gadget controller to rule out the gadget
> > driver. If another controller doesn't give blue-screen-of-death it means
> > it's musb problem, otherwise, it's g_ether issue.
> 
> it also happens with tusb6010 on n810. It'd be nice if someone with a
> different controller could try this out.
> 
> Anyone with omap_udc-based board ? h2 ? h3 ?
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 