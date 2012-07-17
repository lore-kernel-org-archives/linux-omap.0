From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 7/8] ARM: OMAP: clockdomain: add support for
 preventing autodep delete
Date: Tue, 17 Jul 2012 17:56:11 +0300
Message-ID: <1342536971.4672.82.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-8-git-send-email-t-kristo@ti.com>
	 <5003F453.9020903@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab2GQO4S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 10:56:18 -0400
In-Reply-To: <5003F453.9020903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 2012-07-16 at 16:30 +0530, Rajendra Nayak wrote:
> Hi Tero,
> 
> On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> > Some clockdomains bug out if their autodeps are deleted before idle.
> > This happens namely with OMAP3 PER domain, it will bug out if it
> > doesn't have wakedeps enabled when it enters off-mode. This patch
> > adds support for new flag 'CLKDM_NO_AUTODEP_DISABLE' which does this.
> 
> I had one more thought on how we could handle this (without adding a new
> flag :-))
> How about marking OMAP3 PER with a CLKDM_NO_AUTODEPS (already existing
> flag) and setting a sleep/wakeup dependency of OMAP3 PER with MPU and
> IVA one time sometime during late PM init. Because thats what we intent
> to do, which is have a sleep/wakeup dependency set *always* and never
> try to remove it, right?

I did some extra investigation on this, sorry for the delay. What is
enough, is to just add a wakedep from wkup_clkdm to per_clkdm, as the
wakedeps have usecounting so once this is done, the autodep handling
can't remove the wakedep.

Anyway, it also looks like this fix is no longer needed with the latest
kernel, something has changed with the gpio code / or latencies and it
doesn't crash anymore. Thus, it looks like patches 7 & 8 can be dropped
from this set for now. This is the behavior with beagleboard at least,
if someone can verify this with some other omap3 hw that would be nice.

The underlying issue still remains, we have errata i582 which doesn't
have any workarounds in the kernel yet. We should probably resurrect
something like this:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38834.html

... or just pull the part which adds the dynamic wakedep add / remove
for the per domain when attempting per OFF.

-Tero


> 
> regards,
> Rajendra
> 
> >
> > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > ---
> >   arch/arm/mach-omap2/clockdomain.c |    3 +++
> >   arch/arm/mach-omap2/clockdomain.h |    4 ++++
> >   2 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> > index 7f5423e..56cef58 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -201,6 +201,9 @@ void _clkdm_del_autodeps(struct clockdomain *clkdm)
> >   	if (!autodeps || clkdm->flags&  CLKDM_NO_AUTODEPS)
> >   		return;
> >
> > +	if (clkdm->flags&  CLKDM_NO_AUTODEP_DISABLE)
> > +		return;
> > +
> >   	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
> >   		if (IS_ERR(autodep->clkdm.ptr))
> >   			continue;
> > diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> > index 373399a..1fc5314 100644
> > --- a/arch/arm/mach-omap2/clockdomain.h
> > +++ b/arch/arm/mach-omap2/clockdomain.h
> > @@ -31,12 +31,16 @@
> >    *
> >    * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
> >    *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
> > + * CLKDM_NO_AUTODEP_DISABLE: Prevent clockdomain code from deleting autodeps.
> > + *     Needed for PER domain on omap3, as it will bug out with off-mode if
> > + *     wakedeps are removed.
> >    */
> >   #define CLKDM_CAN_FORCE_SLEEP			(1<<  0)
> >   #define CLKDM_CAN_FORCE_WAKEUP			(1<<  1)
> >   #define CLKDM_CAN_ENABLE_AUTO			(1<<  2)
> >   #define CLKDM_CAN_DISABLE_AUTO			(1<<  3)
> >   #define CLKDM_NO_AUTODEPS			(1<<  4)
> > +#define CLKDM_NO_AUTODEP_DISABLE		(1<<  5)
> >
> >   #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
> >   #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
> 


