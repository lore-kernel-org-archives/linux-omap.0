From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Fri, 13 Apr 2012 10:36:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39575 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab2DMKgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 06:36:16 -0400
In-Reply-To: <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 12, 2012 at 13:56:06, Paul Walmsley wrote:
> Hello Vaibhav,
> 
> On Fri, 30 Mar 2012, Vaibhav Hiremath wrote:
> 
> > After some healthy discussion, now we have come to the conclusion and
> > decided to handle AM33XX PRM/CM part separately; as AM33XX-PRCM module is
> > different than OMAP3 and OMAP4 architecture.
> 
> Have been reviewing these patch sets here.  Are these associated with any 
> board file?  I had to hand-apply several patch sets due to some 
> differences in mach-omap2/io.c.  Upon looking more closely, and looking at 
> your GitHub branch:
> 
> https://github.com/hvaibhav/am335x-linux/tree/am335x-prm-cm
> 
> it seems that internally you've been modifying the AM3517 EVM board file 
> to test the BeagleBone?  But due to the init_early changes, this is 
> presumably not going to work if we want to keep the AM3517EVM working -- 
> is this your understanding as well?
> 

Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
These patches have been reviewed and accepted in the list, only thing is
they couldn't make it to upstream during v3.4 merge window.

I believe Tony is going to push them for v3.5 now.

> I'm kind of wondering how we're to test these...
>

I maintain multiple branches along with one superset branch in
my gitorious tree, for example, currently I have,

Individual features branches:
----------------------------
32ksync-timer-cleanup : 32k timer cleanup
am335x-baseport-for-tony : baseport patches (reviewed & accepted)
am335x-prm-cm-hwmod : prm/cm/hwmod patches

superset branch:
---------------
am335x-upstream-staging: 

I merge all feature branches into this superset branch and one additional
Patch, required to get beaglebone to boot.

> ...
> 
> BTW, the branch that I'm experimenting with is at 
> git://git.pwsan.com/linux-2.6 -- branch name 'am33xx_support_3.5' -- I am 
> still reviewing the patches there.
> 

Thanks Paul, really appreciate your help here. I will take a look at this 
and let you know. Also, please let me know if you have any comments in the 
patch.

I really want to target for v3.5 merge window, and atleast get all basic 
prm/cm/clock/hwmod things upstream.


Thanks,
Vaibhav

> 
> - Paul
> 

