From: Olof Johansson <olof@lixom.net>
Subject: Re: Latest additional build warnings
Date: Sat, 9 Feb 2013 20:22:00 -0800
Message-ID: <CAOesGMjQEJesfDqSHoV727=pTHjQ4CE+La2QWikG0r4gZ9iSjA@mail.gmail.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
	<20130209114918.GJ17852@n2100.arm.linux.org.uk>
	<20130210030032.GC4801@atomide.com>
	<CAOesGMgvEVsB7OWs43EWjgsR8af2_RZS9Dod3PURu6Tvdi4QJw@mail.gmail.com>
	<20130210032234.GE4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:50036 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761051Ab3BJEWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 23:22:03 -0500
Received: by mail-we0-f172.google.com with SMTP id x10so4108360wey.3
        for <linux-omap@vger.kernel.org>; Sat, 09 Feb 2013 20:22:01 -0800 (PST)
In-Reply-To: <20130210032234.GE4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 9, 2013 at 7:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Olof Johansson <olof@lixom.net> [130209 19:08]:
>> On Sat, Feb 9, 2013 at 7:00 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130209 03:53]:
>> >> On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
>> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
>> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
>> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
>> >> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
>> >>
>> >> I'm still seeing the above in the build of Friday's merge.  I'm also
>> >> seeing additional warnings in the randconfig similar to the above for
>> >> arch/arm/mach-omap2/omap-iommu.c.
>> >
>> > Thanks for letting me know about the omap-iommu.c one. Looks like
>> > there's also one patch for drm.c.
>> >
>> > Olof, if you did not yet apply the hwspinlock.c warning fix, I'll
>> > just do a branch with all three of them for you.
>>
>> I haven't (must have missed it), so please just send a branch.
>
> OK will do. Probably you started fixing up the bad Reported-by
> line in my patch and then got disrupted :)
>
> Found one more after some grepping, after the following patch they
> should be all fixed up. Pull request coming shortly.

Oh wait -- I got confused there for a bit (this came in right as I had
to step out for a while).

I definitely picked up the hwspinlock patch, and it's there in my
local for-next. Looks like I missed pushing it out though. That
explains why Russell didn't see the fix. :(


So, the hwspinlock patch is already applied. The soc.h one is not, and
I'm not sure what the third one is?


-Olof
