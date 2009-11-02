From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 02 Nov 2009 09:10:52 -0800
Message-ID: <87bpjklun7.fsf@deeprootsystems.com>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
	<1257150370.29885.986.camel@localhost>
	<E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
	<20091102091427.GE9446@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402540379AA@dbde02.ent.ti.com>
	<87k4y8lxhg.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940254037B8F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:36547 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbZKBRKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 12:10:49 -0500
Received: by pwj9 with SMTP id 9so1963036pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 09:10:53 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254037B8F@dbde02.ent.ti.com> (Manjunath Kondaiah G.'s message of "Mon\, 2 Nov 2009 22\:00\:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> > diff --git a/arch/arm/mach-omap2/pm-debug.c 
>> b/arch/arm/mach-omap2/pm-debug.c
>> > index 767ebbc..3a42615 100644
>> > --- a/arch/arm/mach-omap2/pm-debug.c
>> > +++ b/arch/arm/mach-omap2/pm-debug.c
>> > @@ -625,4 +625,6 @@ arch_initcall(pm_dbg_init);
>> >
>> >  #else
>> >  void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
>> > +int pm_dbg_regset_init(int reg_set) {}
>> > +int pm_dbg_regset_save(int reg_set) {}
>> 
>> you'll get compiler warnings from these.
>
> Can be changed to return with value zero for these API's.
>
>> 
>> >  #endif
>> 
>> but even there, this should be fixed in pm.h.  The current PM branch
>> has these defines already:
>> 
>> #define pm_dbg_regset_save(reg_set) do {} while (0);
>> #define pm_dbg_regset_init(reg_set) do {} while (0);
>> 
>> It would be cleaner to fix the #ifdef there to handle the
>> !CONFIG_DEBUG_FS case.
>
> pm branch has else condition for CONFIG_PM_DEBUG. But, CONFIG_DEBUG_FS
> is not handled. 

I know, my proposal is to handle the DEBUG_FS case there also.

> As there is already similar API - pm_dbg_update_time in pm_debug.c,
> these API's can also fit there. More over, using !CONFIG_DEBUG_FS
> will add some #ifdef's in header.

So handle the pm_dbg_update_time() in the header as well.

Handling them in the header will also eliminate the runtime overhead
of an empty function call when DEBUG_FS is not included.

Kevin
<
