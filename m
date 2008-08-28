From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Enabling MUSB support
Date: Thu, 28 Aug 2008 15:49:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
 <20080827133825.GC7354@gandalf.research.nokia.com>
 <200808272354.28531.david-b@pacbell.net>
 <20080828090719.GG7354@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54333 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbYH1KTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 06:19:37 -0400
In-Reply-To: <20080828090719.GG7354@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext David Brownell <david-b@pacbell.net>
Cc: ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On Wed, Aug 27, 2008 at 11:54:28PM -0700, David Brownell wrote:
> > On Wednesday 27 August 2008, Felipe Balbi wrote:
> > > I tried musb on omap2420 (with tusb), omap3430 and omap3530
> > > (beagle board) and all of them are working.
> > 
> > I tried it on Beagle and found that OTG mode wanted to oops
> > while binding the gadget driver ... static config.  That's
> > with current GIT.  Peripheral-only had the same issue ISTR.
> > 
> > Host mode seemed to come up partially.  There seem to be
> > issues with control-OUT transfers, which caused problems
> > trying to use the Ethernet adapter I was hooking up.
> 
> that's new to me, I'm using musb on omap3-based boards on daily basis
> and I never had a problem, I'll check what I can do with my 
> beagle today
> and see if I can reproduce it.
> 
> -- 
> balbi


There's another issue we noticed today with the SDP and beagleboard.

MUSB in peripheral or OTG mode with g_ether causes a Windows PC to
throw a blue-screen-of-death upon connect. g_file_storage/g_zero did
not seem to have this problem. Regression, as 2.6.26 was working just fine.

Will look into it when I can find the time - a bisect should catch the bug.

-Anand