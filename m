From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 2/2] OMAP4: PRCM: Fix usage of prm/cm accessor api's for OMAP4
Date: Wed, 25 Aug 2010 11:16:16 -0700
Message-ID: <87aaoah827.fsf@deeprootsystems.com>
References: <1281452576-5705-1-git-send-email-rnayak@ti.com>
	<1281452576-5705-2-git-send-email-rnayak@ti.com>
	<1281452576-5705-3-git-send-email-rnayak@ti.com>
	<87mxsbn10l.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003B39A3ED5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41094 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab0HYSQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 14:16:19 -0400
Received: by pzk9 with SMTP id 9so300059pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 11:16:18 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B39A3ED5@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Wed, 25 Aug 2010 14:26:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Wednesday, August 25, 2010 3:10 AM
>> To: Nayak, Rajendra
>> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit
>> Subject: Re: [RFC][PATCH 2/2] OMAP4: PRCM: Fix usage of prm/cm accessor api's for
>> OMAP4
>> 
>> Rajendra Nayak <rnayak@ti.com> writes:
>> 
>> > OMAP's have always had PRCM split into PRM for power and reset
>> > management and CM for clock management.
>> > In OMAP4 the split (physically) is not very straight forward and
>> > there are instances of clock management control registers in PRM
>> > and vice versa.
>> > However it still makes sense, even on OMAP4 to logically split
>> > PRCM into PRM and CM for better understanding and to avoid adding
>> > additonal complexity in higher level frameworks which rely on the
>> > accessor api;s to do the low level register accesses.
>> >
>> > Hence this patch makes sure that any clock management code can
>> > use the cm_read/write* accessor apis (without knowing the physical split)
>> > and power and reset management code can use prm_read/write*
>> > accessor api;s.
>> >
>> > To do this the submodule offsets within PRM/CM1 and CM2 have additonal
>> > info embedded in them specifying what base address to use while
>> > trying to access registers in the given submodule.
>> >
>> > The 16 bit signed submodule offset is defined for OMAP4 as
>> > <Bit 15>	| <Bit 14:13> 		| <Bit 12:0>
>> > <Sign bit>	| <base identifier>	| <submodule offset from base>
>> >
>> > For older OMAP's the base identifier is always set to 0.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>> > Cc: Benoit Cousson <b-cousson@ti.com>
>> 
>> I'm OK with this approach, but I don't like the extra overhead added for
>> every PRCM access on OMAP2/3.
>> 
>> What if you keep the original functions and add new functions for OMAP4,
>> and use function pointers init'd at runtime (based on the existence of
>> prcm_mpu_base)

> I actually have a series to split the powerdomain f/w into platform
> specific and platform independent functions. With that I should be
> able to get rid of this single function (for prm) for omap2/3 and
> omap4 and have separate functions. I can do a similar split for
> clockdomain framework and do the same for the cm functions.  I will
> post the powerdomain split patches soon for review.

OK.

> Do you think it still makes sense to have this function pointer approach in the interim?

No, it sounds like your split-up approach is better all around.

Kevin
