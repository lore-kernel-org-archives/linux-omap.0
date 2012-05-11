From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around __omap2_set_globals
Date: Fri, 11 May 2012 14:54:51 -0700
Message-ID: <87k40itmc4.fsf@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-4-git-send-email-hvaibhav@ti.com>
	<87397ajo32.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA1BF14@DBDE01.ent.ti.com>
	<8762c3ww9w.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA220A3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56884 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758710Ab2EKVyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 17:54:55 -0400
Received: by pbbrp12 with SMTP id rp12so6767982pbb.1
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 14:54:53 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA220A3@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Fri, 11 May 2012 06:09:58 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Fri, May 11, 2012 at 03:09:39, Hilman, Kevin wrote:
>> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
>> 
>> > On Wed, May 09, 2012 at 04:08:09, Hilman, Kevin wrote:
>> >> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> >> 
>> >> > The function __omap2_set_globals() can be common across all
>> >> > platforms/architectures, even in case of omap4, internally it
>> >> > calls same set of functions as in __omap2_set_globals() function
>> >> > (except for sdrc).
>> >> 
>> >> OK so far.
>> >> 
>> >> > This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
>> >> > so that we can reuse same function across omap2/3/4...
>> >> 
>> >> But what happens when a single kernel is built that has support for an
>> >> SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?
>> >> 
>> >
>> > As such Nothing...I looking into this direction while implementing.
>> >
>> > In that case, sdrc.c file will be compiled in and execution will jump to
>> > omap2_set_globals_sdrc(). But inside this function, we are already checking 
>> > whether the omap2_globals->sdrc and omap2_globals->sms for NULL and then use 
>> > it.
>> >
>> > And function omap2_sdrc_init() is also depends on machine, so in case of
>> > Am33xx, it won't get into sdrc execution at all. And in case of omap4, it 
>> > will.
>> 
>> Then why bother with the #ifdef at all?
>> 
>> If it already safe to call on all SoCs, just get rid of the #ifdef all
>> together.
>> 
>
> Kevin,
>
> sdrc.o target gets built only as "omap-2-3-common", this will not get built 
> for omap4, am33xx, ti81xx, etc...

OK, I see what you mean now.  I was confusing because this patch doesn't
touch sdrc.c, or the Makefile for sdrc.c.

> So in order to avoid build break, you have to have some mechanism, and
> that's where we need to create config option dependent on platform.

That being the case, for readability sake, I suggest you change the
Makefile to use the new config option for sdrc.c as well.

Kevin
