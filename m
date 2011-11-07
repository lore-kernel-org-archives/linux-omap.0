From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] BUILD FIX:hwspinlock: do not return any value from void
 funtion
Date: Mon, 7 Nov 2011 13:40:01 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8023A6D@DBDE01.ent.ti.com>
References: <1320670686-29286-1-git-send-email-hvaibhav@ti.com>
 <4EB7D80D.2080108@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691Ab1KGNkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 08:40:14 -0500
In-Reply-To: <4EB7D80D.2080108@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "ohad@wizery.com" <ohad@wizery.com>


> -----Original Message-----
> From: Igor Grinberg [mailto:grinberg@compulab.co.il]
> Sent: Monday, November 07, 2011 6:37 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; ohad@wizery.com
> Subject: Re: [PATCH] BUILD FIX:hwspinlock: do not return any value from
> void funtion
> 
> Hi Vaibhav,
> 
> On 11/07/11 14:58, Vaibhav Hiremath wrote:
> > Fixes below compilation error -
> >
> >   CC      arch/arm/mach-omap2/hwspinlock.o
> >   cc1: warnings being treated as errors
> >   In file included from arch/arm/mach-omap2/hwspinlock.c:22:0:
> >   include/linux/hwspinlock.h: In function '__hwspin_unlock':
> >   include/linux/hwspinlock.h:121:2: error: 'return' with a value, in
> function
> >   returning void
> >   make[1]: *** [arch/arm/mach-omap2/hwspinlock.o] Error 1
> >   make: *** [arch/arm/mach-omap2] Error 2
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  include/linux/hwspinlock.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> > index 08a2fee..192710a 100644
> > --- a/include/linux/hwspinlock.h
> > +++ b/include/linux/hwspinlock.h
> > @@ -118,7 +118,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
> >  static inline
> >  void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long
> *flags)
> >  {
> > -	return 0;
> > +	return;
> 
> Isn't it better to just remove this line?
> 
[Hiremath, Vaibhav] Yeup, we can do that... Submitting it again.

Thanks,
Vaibhav

> >  }
> >
> >  static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
> 
> 
> --
> Regards,
> Igor.
