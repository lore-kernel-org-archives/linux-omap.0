From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Enabling MUSB support
Date: Fri, 29 Aug 2008 10:11:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
 <20080827133825.GC7354@gandalf.research.nokia.com>
 <200808272354.28531.david-b@pacbell.net>
 <20080828090719.GG7354@gandalf.research.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
 <20080828102842.GK7354@gandalf.research.nokia.com>
 <20080828112032.GL7354@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53212 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYH2ElP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 00:41:15 -0400
In-Reply-To: <20080828112032.GL7354@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


I tested MUSB controller on OMAP35xx EVM (omap3_evm_defconfig) for g_ether gadget and it works fine with Windows XP. I am using v2.6.26-omap2 tag.

Regards,
Ajay

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
Sent: Thursday, August 28, 2008 4:51 PM
To: Felipe Balbi
Cc: Gadiyar, Anand; ext David Brownell; ext Ashwin Bihari; linux-omap@vger.kernel.org
Subject: Re: Enabling MUSB support

On Thu, Aug 28, 2008 at 01:28:42PM +0300, Felipe Balbi wrote:
> On Thu, Aug 28, 2008 at 03:49:17PM +0530, ext Gadiyar, Anand wrote:
> > There's another issue we noticed today with the SDP and beagleboard.
> > 
> > MUSB in peripheral or OTG mode with g_ether causes a Windows PC to
> > throw a blue-screen-of-death upon connect. g_file_storage/g_zero did
> > not seem to have this problem. Regression, as 2.6.26 was working just fine.
> > 
> > Will look into it when I can find the time - a bisect should catch the bug.
> 
> would be worth trying other gadget controller to rule out the gadget
> driver. If another controller doesn't give blue-screen-of-death it means
> it's musb problem, otherwise, it's g_ether issue.

it also happens with tusb6010 on n810. It'd be nice if someone with a
different controller could try this out.

Anyone with omap_udc-based board ? h2 ? h3 ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

