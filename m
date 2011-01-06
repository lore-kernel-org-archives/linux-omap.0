From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Thu, 6 Jan 2011 19:28:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248201A37@dbde02.ent.ti.com>
References: <1294260576-20237-1-git-send-email-nm@ti.com>
	<1294260576-20237-3-git-send-email-nm@ti.com> <874o9nvskt.fsf@ti.com>
 <4D25B482.3080709@ti.com>
 <579AA000-EB86-4DD3-B3B7-29F7A72E0415@beagleboard.org>
 <4D25C745.7060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46759 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab1AFN7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:59:13 -0500
In-Reply-To: <4D25C745.7060600@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@beagleboard.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, January 06, 2011 7:15 PM
> To: Koen Kooi
> Cc: Hilman, Kevin; l-o; l-a; Tony
> Subject: Re: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
> 
> Koen Kooi had written, on 01/06/2011 07:00 AM, the following:
> > Op 6 jan 2011, om 13:24 heeft Nishanth Menon het volgende 
> geschreven:
> > 
> >> Kevin Hilman wrote, on 01/05/2011 05:28 PM:
> >>> Nishanth Menon<nm@ti.com>  writes:
> >>>
> >>>> Beagle XM uses 3730 and the board design allows enabling 
> 800MHz and 1GHz
> >>>> OPPs. However, We need Smart reflex class 1.5 and ABB to 
> enable 1GHz safely.
> >>>> For the moment, we tweak the default table to allow for 
> 800Mhz OPP usage.
> >>> Isn't this common to any board using 3730 (or 3630?)
> >> no it is not. only certain boards are capable of higher 
> frequencies - there is a procedure called PDN analysis and 
> vmin search that needs to be performed to guarentee this.
> > 
> > What about the "new" 3530s that can run at 720MHz? Those 
> have been speed binned and given a different SKU. I'm using 
> the attached 4 patches (Tony master + beagle patches _+ dvfs: 
> http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=ko
> en/beagle-next) on my beagle C4 and overo tide to get 720MHz. 
> They don't really work:
> for 3530, keep in mind that not *all* boards can support 
> 720MHz (esp the 
> old 3430 boards, like my poor SDP3430).
> since we consider 3530 as 3430 as well, add a default disabled 720MHz 
> OPP in the 3430 table and enable it:
> a) if this has anything to do with board behavior (which, 
> unlike 36xx, I 
> dont think is the case for 35xx), enable similar to this patch on the 
> required boards on a need basis (e.g. based on board rev)
> b) if this is a silicon behavior, then, you should modify the 
> omap3_opp_init to ensure that for the right silicon this is enabled 
> (e.g. only for 3530 rev X onwards or something similar) - but 
> you will 
> need some way to detect it in s/w (not through bootargs please!)

Nishanth,

Some of the patches generic that Koen attached are based on my
submissions. As part of migration to 2.6.37, I am in process of
validating them on internal integration tree. Will post them
soon... may be end of tomorrow.

I will be testing them on OMAP3EVM.

~sanjeev

[snip]...[snip]
