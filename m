From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP: hmwod: Update the sysc_cache in case module
 context is lost
Date: Thu, 21 Oct 2010 15:43:41 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF83@dbde02.ent.ti.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com>
	<877hhkv2wb.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
 <87tyknmpm5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56879 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab0JUKNw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 06:13:52 -0400
In-Reply-To: <87tyknmpm5.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, October 15, 2010 9:10 PM
> To: Shilimkar, Santosh
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org; Paul Walmsley; Cousson, Benoit
> Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
> 
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Friday, October 15, 2010 3:44 AM
> >> To: Nayak, Rajendra
> >> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Cousson, Benoit; Shilimkar,
> >> Santosh
> >> Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module
> >> context is lost
> >>
> >> Rajendra Nayak <rnayak@ti.com> writes:
> >>
> >> > Do not skip the sysc programming in the hmwod framework based
> >> > on the cached value alone, since at times the module might have lost
> >> > context (due to the Powerdomain in which the module belongs
> >> > transitions to either Open Switch RET or OFF).
> >>
> >> Shouldn't the driver for each IP be responsible for restoring it's
> >> register contents after context loss, including it's SYSC?
> >>
> >> Seems to me that if SYSC is lost, it means the driver's save/restore
> >> is buggy.
> >
> > I am glad you asked this question. I had a same argument with Benoit
> > that driver anyway does context save restore for other registers and
> > it can do SYSC as well.
> >
> > But Benoit's point was that "sysconfig is a part of the PRCM located
> > in the IP, but this is purely TI implementation specific. The same
> > IP in another platform will not have this sysconfig entry. That's why
> > its important to hide them from the driver "
> 
> OK, but this patch still doesn't address the real problem.  Namely, that
> *somebody* needs to save/restore the SYSC reg for the IP.

Hi Kevin,

What the patch does is reprogram's the sysc value (from the cache)
whenever its lost. So its infact saved in the cache and restored when 
needed. 

> 
> Otherwise, all this patch does is refresh the _sysc_cache with
> completely unknown contents.  It also somewhat defeats the purpose of
> having a cache.  If you're going to read SYSC in order to determine
> whether or not you can avoid a write, you might as well just blindly
> write.

I thought of this and dismissed it thinking I would end up with a read/or/write
and instead a read always to avoid write is better.
But now looking back again, it does make sense to still keep the cache to avoid
a read (since a read has significantly more latency than write) and do a blind write
always. Does that make sense?

Regards,
Rajendra

> 
> One option to fix the save/restore would be that TI specific context
> save/restore could be done in the device layer by adding some additional
> save/restore do the functions calling omap_device_[idle|enable].
> 
> IOW, most devices just call omap_device directly by doing something like:
> 
> struct omap_device_pm_latency omap_wdt_latency[] = {
> 	[0] = {
> 		.deactivate_func = omap_device_idle_hwmods,
> 		.activate_func   = omap_device_enable_hwmods,
> 		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> 	},
> };
> 
> 
> But these [de]activate functions can be anything, and could be made into
> functions that do some additional save/restore and then call
> omap_device_*
> 
> Kevin

