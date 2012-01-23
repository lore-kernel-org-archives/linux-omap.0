From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 3/3] arm:omap:omap4: Hook-up am33xx support to existing prm code
Date: Mon, 23 Jan 2012 14:35:32 -0800
Message-ID: <877h0ikpxn.fsf@ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
	<1326017894-7632-4-git-send-email-hvaibhav@ti.com>
	<87zkdvpgz1.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8317AF316@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:55981 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753501Ab2AWWff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 17:35:35 -0500
Received: by mail-gy0-f172.google.com with SMTP id g16so1172502ghb.31
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 14:35:35 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317AF316@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Mon, 23 Jan 2012 08:53:58 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Wed, Jan 11, 2012 at 21:48:25, Hiremath, Vaibhav wrote:
>> On Tue, Jan 10, 2012 at 23:39:22, Hilman, Kevin wrote:
>> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> > 
>> > > AM33XX PRM module (L4_WK domain) will be treated as another seperate
>> > > partition in _prm_bases[] table.
>> > >
>> > > Also, since cpu_is_omap34xx check is true for am33xx family of
>> > > devices, we must check cpu_is_am33xx fisrt, in order to follow
>> > > omap4 execution path.
>> > 
>> > Can you remind me why cpu_is_omap34xx() is true for AM33xx family?
>> 
>> Yeah sure...
>> 
>> Kevin,
>> As mentioned before, the main idea behind bringing am33xx under omap34xx
>> was mainly due to "cortex-A8 family of devices".
>> 
>> It has been discussed and aligned long time back, so
>> please refer to the thread -
>> 
>> http://www.spinics.net/lists/linux-omap/msg41046.html
>> Multiple versions of -
>> http://www.spinics.net/lists/linux-omap/msg45505.html
>> 
>> Thanks,
>> Vaibhav
>> 
>> > These AM3xxx devices make my brain hurt.
>> > 
>> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> > > Cc: Kevin Hilman <khilman@ti.com>
>> > > Cc: Rajendra Nayak <rnayak@ti.com>
>> > 
>> > [...]
>> > 
>> > > diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
>> > > index 3d9894f..fcc4123 100644
>> > > --- a/arch/arm/mach-omap2/prminst44xx.c
>> > > +++ b/arch/arm/mach-omap2/prminst44xx.c
>> > > @@ -19,6 +19,7 @@
>> > >  #include "common.h"
>> > >
>> > >  #include "prm44xx.h"
>> > > +#include "prm33xx.h"
>> > >  #include "prminst44xx.h"
>> > >  #include "prm-regbits-44xx.h"
>> > >  #include "prcm44xx.h"
>> > > @@ -31,6 +32,7 @@ static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
>> > >  	[OMAP4430_CM2_PARTITION]		= 0,
>> > >  	[OMAP4430_SCRM_PARTITION]		= 0,
>> > >  	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
>> > > +	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
>> > >  };
>> > 
>> > I'm not crazy about just extending the "normal" OMAP4 table.  
>> 
>> If it is required then yes (with proper comment).
>> 
>> > That would
>> > imply that with each OMAP4 derivatve we keep extending this table.
>> > 
>> 
>> I would say anyway we will end up adding
>> Cpu_is_xxx everywhere as we add new table for derivatives.
>> 
>> > Instead, how about rename this to one to omap44xx_prm_bases[], then
>> > create a new one called am33xx_prm_bases[].  Then, at init time, assing
>> > _prm_bases to the right one based on cpu_is_.
>> > 
>> 
>> Just wanted to avoid cpu_is_xxxx check here. Will specific comment wouldn't
>> help here (I have clearly mentioned in patch description), may be in c file
>> it is required?
>> OR 
>> you want to be clearly separate table for code readability.
>> 
>
> Kevin,
>
> Any comments on this? Should I stick to what is implemented now?
>

cpu_is_* checks are acceptable at init time, and we use them often to
initialize SoC-dependent tables/arrays etc.

Kevin
