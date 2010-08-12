From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 0/7] OMAP: hwmod: Full data set for OMAP4430 ES1 & ES2
Date: Wed, 11 Aug 2010 17:34:36 -0700
Message-ID: <877hjwzn1f.fsf@deeprootsystems.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
	<878w4fk3d2.fsf@deeprootsystems.com> <4C62B78A.8060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64969 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424Ab0HLAel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 20:34:41 -0400
Received: by ywh1 with SMTP id 1so205086ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 17:34:40 -0700 (PDT)
In-Reply-To: <4C62B78A.8060907@ti.com> (Benoit Cousson's message of "Wed, 11
	Aug 2010 16:45:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 8/9/2010 9:11 PM, Kevin Hilman wrote:
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>>> Hi Kevin&  Paul,
>>>
>>> Here is the OMAP4430 ES1&  ES2 hwmod data v3 series.
>>>
>>> Please note that there is no difference between the ES1&  ES2 wrt hwmod.
>>>
>>> This series is re-organised in order to allow initial submission for upstream
>>> with minimal interconnect data set + mpu.
>>>
>>> Further data will be sent along with the driver once adapted to hwmod.
>>> A first patch is done for the TIMER IP as an example.
>>>
>>> Patches are based on lo/for-next + for-next-fixes + pm-wip/hwmods-reset
>>> + pm-wip/hwmods-debugfs and are available here:
>>> git://dev.omapzoom.org/pub/scm/swarch/linux-omap-adv.git pm-wip/hwmods-omap4
>>>
>>> Tested on OMAP4430 ES1.0 GP device using PAB board.
>>
>> This is looking good to me.  Of course, as you noted we need to
>> understand the root cause of need for those temporary patches before
>> merging.
>>
>> To facilitate broader testing with the other hwmod conversions in
>> progress, and to test with runtime PM, I've updated my
>> pm-wip/hwmods-omap4 branch now includes your series (and its
>> dependencies.)
>
> Cool, thanks.
>
> Maybe we should reshuffle the branch in order to allow people to start
> stacking the OMAP4 hwmod data in small pieces on top of the initial
> data.

Yes, it is time for that.

> What about these branches:
>
> -> pm-wip/hwmods-omap4-full that contains the original full data that
> people will split but that nobody should use as a base.
>
> bbd5866 OMAP: hwmod: Temporary prevent reset during _setup for I2Cs
> c47ddf5 OMAP: hwmod: Temporary prevent reset during _setup for GPIOs
> 4d2fbb8 OMAP4: hwmod: Add remaining hwmods data for OMAP4430 ES1 & ES2
> a9a8f22 OMAP4: hwmod: Add TIMER data for OMAP4430 ES1 & ES2

OK, done.

> -> pm-wip/hwmods-omap4-base to base all driver hwmod migration
> including the OMAP4 data part

OK, done, but I kept the name pm-wip/hwmods-omap4 since that's what
people are already using for a base.

> b8eccd4 OMAP: omap_hwmod: remove locking from hwmod_for_each iterators

fyi... there's an updated version of this locking patch in my pm-wip/hwmods
branch, based on top of your for-next-fixes branch, and included as part
of pm-wip/hwmods-omap4.

> fedcdf6 PM: allow runtime PM get/put from interrupts-disabled context
> a55908c OMAP1: PM: add simple runtime PM layer to manage clocks
> be46d49 OMAP: bus-level PM: enable use of runtime PM API for...
> 1ebda92 OMAP: PM: initial runtime PM core support

This is still pm-wip/runtime (but included in pm-wip/hwmods-omap4)

> 2cb85f7 USB: Remove omap_cfg_reg for 2430

This s still pm-backports (but included in pm-wip/hwmods-omap4)

> -> pm-wip/hwmods-omap4
>
> 71a4efa OMAP4: pm: Change l3_main to l3_main_1 during bus device init
> 1cf660c OMAP4: clock: Fix clock names and align with hwmod names
> 517cead OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2

I just left this as your for-next-fixes branch and merged it into
my pm-wip/hwmods-omap4.

Kevin
