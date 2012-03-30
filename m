From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 0/3] ARM: OMAP2+: Add powerdomain & PRM support for
 AM33XX device
Date: Fri, 30 Mar 2012 07:13:57 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831840CD6@DBDE01.ent.ti.com>
References: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
 <87limjl1xf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab2C3HOJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 03:14:09 -0400
In-Reply-To: <87limjl1xf.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Thu, Mar 29, 2012 at 23:33:40, Hilman, Kevin wrote:
> Hi Vaibhav,
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > After going round-n-round on how to add support for AM33XX family
> > of device into kernel, especially for PRM and CM support, we have
> > decided to handle it separately; as AM33XX-PRCM module is different
> > than OMAP3 and OMAP4 architecture.
> >
> > The difference becomes very interesting/weird when it comes to
> > the consistency for register offsets in PRM address space and
> > bit-field offsets inside PRM registers,
> > So along with Powerdomain data and PRM api's required for AM33XX
> > device, this patch series adds,
> >
> >  - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
> >  - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
> >  - Logicretstate and mem_on/ret/pwrst/retst mask to "struct powerdomain"
> >
> >
> > Testing: This patch series has been boot tested on AM37xEVM and AM335x
> >          based BeagleBone community board.
> >
> > THANKS TO PAUL HERE...for helping and concluding on this, soon I will
> > have similar patch for CM support, then clock-tree and hwmod will follow...
> >
> > Changes from V1 & V2:
> > 	- Rolled back to my original approach, where AM33xx device was
> > 	  handled separately (RFC version).
> 
> My apologies for causing the run around.  
> 
> This approach (without the prminst layer) is indeed a better approach.
> 
> Thanks for your patience (and persistence.)
> 
> I went to give this a test on my BeagleBone, but it doesn't apply to
> mainline.  What upstream commit is this supposed to apply onto.  

I and using, linux-omap/master and/or linux-omap/cleanup branches as a 
baseline for sending the patches.


> I tried it on v3.3, but patch 3 fails with a conflict in io.c.
> 

My bad. I did not include (or resend) voltage domain patch (had submitted 
last time itself). 
I will resend the all patch-series again including voltage domain addition 
patch. Just for reference, the series will follow the sequence -

voltagedomains 
powerdomains 
clockdomains
clock
hwmod


> Looking at your am335x-staging branch, it seems that it depends on
> previous changes to io.c made in:
> 
>         arm:omap:am33xx: Add AM335XEVM machine support
> 
> That patch appears to need an update for mainline as well.
>

Can you please clarify on this? I use v3.3 to check on this, and it is
Getting applied without any issues for me.

I believe you are using V5 version of this patch series, also you can pick this patch from (created to give pull request to Tony)
https://github.com/hvaibhav/am335x-linux/tree/am335x-baseport-for-tony


Log:
==============
commit 812e168a9584e180c12588ca2b0233e96461e997
Author: Afzal Mohammed <afzal@ti.com>
Date:   Tue Aug 9 14:29:41 2011 +0530

    arm:omap:am33xx: Add AM335XEVM machine support

    This patch adds minimal support for AM335X EVM.
    The approach taken here is to add AM335X EVM support
    to AM3517EVM, considering the fact that with device tree
    developement we will get rid of board-*.c.

    Signed-off-by: Afzal Mohammed <afzal@ti.com>
    Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
    [Changed ti816x_init_irq=>ti81xx_init_irq, due to recent acceptance of patches]
    Reviewed-by: Kevin Hilman <khilman@ti.com>

commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 18 16:15:34 2012 -0700

    Linux 3.3


 
> Kevin
> 

