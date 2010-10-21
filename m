From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
Date: Thu, 21 Oct 2010 10:31:54 -0700
Message-ID: <87mxq71mgl.fsf@deeprootsystems.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com>
	<877hhkv2wb.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
	<87tyknmpm5.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF83@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57523 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab0JURb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 13:31:57 -0400
Received: by pwj3 with SMTP id 3so49506pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 10:31:57 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF2DAF83@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Thu, 21 Oct 2010 15:43:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Friday, October 15, 2010 9:10 PM
>> To: Shilimkar, Santosh
>> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org; Paul Walmsley; Cousson, Benoit
>> Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
>> 
>> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>> 
>> >> -----Original Message-----
>> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >> Sent: Friday, October 15, 2010 3:44 AM
>> >> To: Nayak, Rajendra
>> >> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Cousson, Benoit; Shilimkar,
>> >> Santosh
>> >> Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module
>> >> context is lost
>> >>
>> >> Rajendra Nayak <rnayak@ti.com> writes:
>> >>
>> >> > Do not skip the sysc programming in the hmwod framework based
>> >> > on the cached value alone, since at times the module might have lost
>> >> > context (due to the Powerdomain in which the module belongs
>> >> > transitions to either Open Switch RET or OFF).
>> >>
>> >> Shouldn't the driver for each IP be responsible for restoring it's
>> >> register contents after context loss, including it's SYSC?
>> >>
>> >> Seems to me that if SYSC is lost, it means the driver's save/restore
>> >> is buggy.
>> >
>> > I am glad you asked this question. I had a same argument with Benoit
>> > that driver anyway does context save restore for other registers and
>> > it can do SYSC as well.
>> >
>> > But Benoit's point was that "sysconfig is a part of the PRCM located
>> > in the IP, but this is purely TI implementation specific. The same
>> > IP in another platform will not have this sysconfig entry. That's why
>> > its important to hide them from the driver "
>> 
>> OK, but this patch still doesn't address the real problem.  Namely, that
>> *somebody* needs to save/restore the SYSC reg for the IP.
>
> Hi Kevin,
>
> What the patch does is reprogram's the sysc value (from the cache)
> whenever its lost. So its infact saved in the cache and restored when 
> needed. 
>
>> 
>> Otherwise, all this patch does is refresh the _sysc_cache with
>> completely unknown contents.  It also somewhat defeats the purpose of
>> having a cache.  If you're going to read SYSC in order to determine
>> whether or not you can avoid a write, you might as well just blindly
>> write.
>
> I thought of this and dismissed it thinking I would end up with a read/or/write
> and instead a read always to avoid write is better.
> But now looking back again, it does make sense to still keep the cache to avoid
> a read (since a read has significantly more latency than write) and do a blind write
> always. Does that make sense?

Makes sense to me.

Kevin

