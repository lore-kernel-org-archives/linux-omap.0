From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Thu, 8 Mar 2012 16:39:57 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83180D786@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317E6763@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1203020337330.15424@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60326 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269Ab2CHQkG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 11:40:06 -0500
In-Reply-To: <alpine.DEB.2.00.1203020337330.15424@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

On Fri, Mar 02, 2012 at 16:16:47, Paul Walmsley wrote:
> Hi
> 
> On Fri, 2 Mar 2012, Hiremath, Vaibhav wrote:
> 
> > Paul,
> > Thanks for your review comments, can we also align on the approach, 
> > Whether to merge am33xx powerdomain with omap4 (same direction we are now)
> > OR
> > Have separate implementation (my original approach).
> 
> Could you please take a look at the "am335x_prcm_devel_3.4" branch on 
> git://git.pwsan.com/linux-2.6 and let me know what you think?
> 
> It is still rough, incomplete, and compile-tested only; and the patch 
> commit messages have to be updated and revised; but I think it is a 
> slightly better approach.
> 

Paul,

Sorry for delayed response, was bit stuck with some baseport thing.


I have reviewed the changes from your above branch. And as I mentioned 
before, it looks closer to my earlier approach + some good and important 
changes/cleanups.

> A significant change is that the prminst code changes have been removed.  
> That is only needed when PRM registers are spread across multiple PRCM IP 
> blocks.  

Make sense actually...I don't know, why didn't thought about this before...

> This does not appear to be the case with AM33xx?  So the 
> implementation has been modified to create a prm33xx.c file instead.  
> This avoids an extra, unnecessary layer of indirection for PRM accesses.
> 
> This, along with the other differences between OMAP4 and this chip, means 
> that a separate powerdomain33xx.c file had to be created.
> 
> The powerdomains33xx_data.c file is still missing the bitmask position 
> data, but the structure members are there.
> 

Yeah, I understand, I think without this it won't be usefule. I will also get this done in next (aligned) changes.

> Feel free to combine, rework, or merge this series with what you are 
> working on if you feel that it is a good approach.  Otherwise, let's 
> discuss.
> 

Thanks, Thanks a lot for your time/support/review, as always its helpful.


Thanks,
Vaibhav

> 
> - Paul
> 

