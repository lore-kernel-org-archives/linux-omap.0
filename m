From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Enabling MUSB support
Date: Thu, 28 Aug 2008 12:07:19 +0300
Message-ID: <20080828090719.GG7354@gandalf.research.nokia.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46534 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYH1JHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 05:07:34 -0400
Content-Disposition: inline
In-Reply-To: <200808272354.28531.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Wed, Aug 27, 2008 at 11:54:28PM -0700, David Brownell wrote:
> On Wednesday 27 August 2008, Felipe Balbi wrote:
> > I tried musb on omap2420 (with tusb), omap3430 and omap3530
> > (beagle board) and all of them are working.
> 
> I tried it on Beagle and found that OTG mode wanted to oops
> while binding the gadget driver ... static config.  That's
> with current GIT.  Peripheral-only had the same issue ISTR.
> 
> Host mode seemed to come up partially.  There seem to be
> issues with control-OUT transfers, which caused problems
> trying to use the Ethernet adapter I was hooking up.

that's new to me, I'm using musb on omap3-based boards on daily basis
and I never had a problem, I'll check what I can do with my beagle today
and see if I can reproduce it.

-- 
balbi
