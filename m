From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 02 Nov 2009 08:09:31 -0800
Message-ID: <87k4y8lxhg.fsf@deeprootsystems.com>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
	<1257150370.29885.986.camel@localhost>
	<E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
	<20091102091427.GE9446@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402540379AA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:36908 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbZKBQJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 11:09:29 -0500
Received: by pwj9 with SMTP id 9so1928541pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 08:09:34 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402540379AA@dbde02.ent.ti.com> (Manjunath Kondaiah G.'s message of "Mon\, 2 Nov 2009 15\:30\:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> -----Original Message-----
>> From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
>> Sent: Monday, November 02, 2009 2:44 PM
>> To: G, Manjunath Kondaiah
>> Cc: dedekind1@gmail.com; linux-omap@vger.kernel.org; 
>> khilman@deeprootsystems.com
>> Subject: Re: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
>> 
>> On Mon, Nov 02, 2009 at 10:00:23AM +0100, ext G, Manjunath 
>> Kondaiah wrote:
>> > 
>> > > > --- a/arch/arm/configs/omap_zoom2_defconfig
>> > > > +++ b/arch/arm/configs/omap_zoom2_defconfig
>> > > > @@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=y
>> > > >  CONFIG_FRAME_WARN=1024
>> > > >  CONFIG_MAGIC_SYSRQ=y
>> > > >  # CONFIG_UNUSED_SYMBOLS is not set
>> > > > -# CONFIG_DEBUG_FS is not set
>> > > > +CONFIG_DEBUG_FS=y
>> > > >  # CONFIG_HEADERS_CHECK is not set
>> > > >  CONFIG_DEBUG_KERNEL=y
>> > > >  # CONFIG_DEBUG_SHIRQ is not set
>> > > 
>> > > It is nicer to provide the build failure log. But if this 
>> is a build
>> > > failure, this means there is a problem with Kconfig 
>> dependency, which
>> > > should be fixed properly, not hidden.
>> > 
>> > Here is build failure log:
>> >   MODPOST vmlinux.o
>> > WARNING: modpost: Found 1 section mismatch(es).
>> > To see full details build your kernel with:
>> > 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>> >   GEN     .version
>> >   CHK     include/linux/compile.h
>> >   UPD     include/linux/compile.h
>> >   CC      init/version.o
>> >   LD      init/built-in.o
>> >   LD      .tmp_vmlinux1
>> > arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
>> > 
>> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34x
>> x.c:441: undefined reference to `pm_dbg_regset_save'
>> > 
>> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34x
>> x.c:452: undefined reference to `pm_dbg_regset_save'
>> > arch/arm/mach-omap2/built-in.o: In function `configure_vc':
>> > 
>> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34x
>> x.c:1226: undefined reference to `pm_dbg_regset_init'
>> > 
>> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34x
>> x.c:1227: undefined reference to `pm_dbg_regset_init'
>> > make: *** [.tmp_vmlinux1] Error 1
>> > 
>> > The above two API's are under CONFIG_DEBUG_FS flag in 
>> arch/arm/mach-omap2/pm-debug.c
>> 
>> so the right fix would be to change the ifdef to something saner.
>> Probably on the header file something like:
>> 
>> #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
>> 
>
> Thanks for review comments. I have handled the same thing in pm-debug.c.
> Here is code snippet. Now it compiles even without enabling CONFIG_DEBUG_FS.
> I will submit this patch if there are no comments for this rework.
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 767ebbc..3a42615 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -625,4 +625,6 @@ arch_initcall(pm_dbg_init);
>
>  #else
>  void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
> +int pm_dbg_regset_init(int reg_set) {}
> +int pm_dbg_regset_save(int reg_set) {}

you'll get compiler warnings from these.

>  #endif

but even there, this should be fixed in pm.h.  The current PM branch
has these defines already:

#define pm_dbg_regset_save(reg_set) do {} while (0);
#define pm_dbg_regset_init(reg_set) do {} while (0);

It would be cleaner to fix the #ifdef there to handle the
!CONFIG_DEBUG_FS case.

Kevin
