From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv4 4/8] ARM: OMAP3: add manual control for mpu / core pwrdm usecounting
Date: Fri, 07 Sep 2012 14:48:29 -0700
Message-ID: <87y5kljyhe.fsf@deeprootsystems.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	<1342189185-5306-5-git-send-email-t-kristo@ti.com>
	<878ve5j8se.fsf@ti.com> <1343637607.9847.13.camel@sokoban>
	<CAORVsuUDo7VB3FnbQWJo=zowrviNDNbPM4DtqQMNrYAmOOat4w@mail.gmail.com>
	<1347010239.10702.94.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43398 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2IGVsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 17:48:31 -0400
Received: by pbbrr13 with SMTP id rr13so209902pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 14:48:31 -0700 (PDT)
In-Reply-To: <1347010239.10702.94.camel@sokoban> (Tero Kristo's message of
	"Fri, 7 Sep 2012 12:30:39 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Mon, 2012-08-06 at 12:14 +0200, Jean Pihet wrote:
>> Hi Tero,
>> 
>> On Mon, Jul 30, 2012 at 10:40 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> > On Fri, 2012-07-27 at 12:36 -0700, Kevin Hilman wrote:
>> >> Tero Kristo <t-kristo@ti.com> writes:
>> >>
>> >> > mpu / core powerdomain usecounts are now statically increased
>> >> > by 1 during MPU activity. This allows the domains to reflect
>> >> > actual usage, and will allow the usecount to reach 0 just before
>> >> > all CPUs are ready to idle. Proper powerdomain usecounts are
>> >> > propageted to voltagedomain level also, and will allow vc
>> >> > callbacks to be triggered at right point of time.
>> >> >
>> >> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> >> > Cc: Paul Walmsley <paul@pwsan.com>
>> >> > Cc: Kevin Hilman <khilman@ti.com>
>> >>
>> >> IMO, the idea is fine, but I'm not crazy about the implementation in
>> >> powerdomain.c, which is meant for pwrdm generic code.   In particular,
>> >> I'm not crazy about the pwrdm lookups in powerdomain.c.
>> >>
>> >> Since pm<soc>.c already has references to mpu_pwrdm and core_pwrdm, why
>> >> not just add the pwrdm_clkdm_enable/disable calls directly in pm<soc>.c
>> >
>> > I think this was how the patch was in some earlier rev but I thought I'd
>> > try to be more clever with this. :) I can revert the implementation back
>> > to this.
>> Furthermore after the changes in pre/post transitions [1], some more
>> checks will be needed to identify the transitions on the mpu and core
>> power domains.
>> 
>> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=e055548953355b6e69c56f9e54388845b29b4e97
>> 
>> Regards,
>> Jean
>
> Hi Kevin,
>
> What is the latest status regarding this one, seeing the patch mentioned
> got reverted due to problems? Should I do some changes for this or not?

No, using latest minline should be fine.

> I can look at moving the code away from the generic powerdomain.c at
> least, but is there anything else?

Nothing else I can think of (but my vacation has purged my brain of most
of the details here, so I may be forgetting something.)

Kevin
