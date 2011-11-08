From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pet Peaves about Platform code, and arch_reset
Date: Mon, 7 Nov 2011 16:45:51 -0800
Message-ID: <20111108004550.GH31337@atomide.com>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53835 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1KHApz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:45:55 -0500
Content-Disposition: inline
In-Reply-To: <20111106135250.GC15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 05:18]:
> Here's a list of my peaves about current platform code - which are
> causing me great issue when trying to clean up the arch_reset() stuff:
> 
> 1. Lack of trailing ',' on structure initializers
>    This makes it much harder to add additional initializers at the end
>    of existing initializers, and increases the risks of conflicts being
>    caused due to more lines having to be modified.
> 
> (This won't work directly because the tabs have been converted to space.
> The empty-looking [] contain a space plus a tab.)
> $ grep '[   ][      ]*\.[[:alnum:]_][[:alnum:]_]*[  ]*=[    ]*[[:alnum:]_{][[:alnum:]_|()}]*[^,]$' arch/arm -r|wc -l
> 768
> $ grep '[   ][      ]*\.[[:alnum:]_][[:alnum:]_]*[  ]*=[    ]*[[:alnum:]_{][[:alnum:]_|()}]*[^,]$' arch/arm/*omap* -r|wc -l
> 325
> 
>    Note that this is _far_ too big a problem - and trivial - to fix in
>    a set of silly churn generating patches - it's a problem to be fixed
>    as a part of _other_ changes to the files.
> 
>    But most importantly _stop_ introducing versions of this problem.

Sounds like we need a spatch for this issue?
 
> 2. Lack of consistent formatting for structure initializers within a
>    mach- subdirectory.  Some use tabs to align the '=' sign.  Others
>    use one space.  This makes a repeated paste of a new initializer
>    mismatch the rest of the formatting of the structure.
> 
>    I _really_ don't care to fix the new initializer I'm introducing to
>    match the random formatting within a subdirectory.

This too could be fixes up using spatch?
 
> 3. Files containing one data structure or function are quite an annoyance
>    when trying to do something like move arch_reset() out of the header
>    file into the platform .c code; this requires creating yet another
>    file containing one function, or consolidating the platform code
>    together first.  I've fixed clps711x for that (so I can convert it),
>    but left others.
> 
> 4. People who think that include files must be stored under a directory
>    with 'include' somewhere mentioned in its path.  This is a big one
>    and a *REAL* hate.  Include files _private_ to a group of source files
>    in a directory should live in the same directory as those files.
>    For instance, this should be zero because the 'map_io' function should
>    not be exported outside of the arch/arm/mach-* subdirectory:
> 
> $ grep -l map_io arch/arm/mach-*/include/mach/*.h | wc -l
> 21
> 
>    Let's look at some specific cases:
> 
> $ grep omap15xx_map_io arch/arm/mach-omap1 arch/arm/plat-omap/ -r
> arch/arm/mach-omap1/board-innovator.c:      omap15xx_map_io();
> arch/arm/mach-omap1/board-palmte.c: .map_io         = omap15xx_map_io,
> arch/arm/mach-omap1/board-palmz71.c:        .map_io         = omap15xx_map_io,
> arch/arm/mach-omap1/board-voiceblue.c:      .map_io         = omap15xx_map_io,
> arch/arm/mach-omap1/io.c:void __init omap15xx_map_io(void)
> arch/arm/mach-omap1/board-palmtt.c: .map_io         = omap15xx_map_io,
> arch/arm/mach-omap1/board-fsample.c:        omap15xx_map_io();
> arch/arm/mach-omap1/board-sx1.c:    .map_io         = omap15xx_map_io,
> arch/arm/mach-omap1/board-ams-delta.c:      .map_io         = omap15xx_map_io,
> arch/arm/plat-omap/include/plat/io.h:void omap15xx_map_io(void);
> arch/arm/plat-omap/include/plat/io.h:static inline void omap15xx_map_io(void)
> 
>    What is the point of the omap15xx_map_io prototype being is a
>    _completely_ different place to where it is defined?
> 
>    The problem is where do I put a function prototype for omap1_restart()
>    amongst these header files for OMAP1 board files to pick up?  Better
>    still, don't tell me, but fix this stuff so that OMAP1 private stuff
>    is in a 'common.h' or 'board.h' header file in arch/arm/mach-omap1.

Yeah we should add arch/arm/mach-omap1/common.h for this.
 
> $ grep s5pv210_init_irq arch/arm -r
> arch/arm/mach-s5pv210/mach-aquila.c:        .init_irq       = s5pv210_init_irq,
> arch/arm/mach-s5pv210/mach-torbreck.c:      .init_irq       = s5pv210_init_irq,
> arch/arm/mach-s5pv210/mach-goni.c:  .init_irq       = s5pv210_init_irq,
> arch/arm/mach-s5pv210/cpu.c:void __init s5pv210_init_irq(void)
> arch/arm/mach-s5pv210/mach-smdkc110.c:      .init_irq       = s5pv210_init_irq,
> arch/arm/mach-s5pv210/mach-smdkv210.c:      .init_irq       = s5pv210_init_irq,
> arch/arm/plat-samsung/include/plat/s5pv210.h:extern void s5pv210_init_irq(void);
> 
>    Again, what is the point of this lack of locality?  And more-over,
>    where the hell do I put a prototype for my new s5pv210_restart()
>    which is in arch/arm/mach-s5pv210/cpu.c ?  Again, don't tell me but
>    fix stuff so that the function prototypes etc are closer to their
>    definitions and uses.
> 
>    There is no excuse for this kind of crap, other than people being
>    sheep and following idiotic and rediculous ideas like "include files
>    must be under a directory called include".
> 
> The arch_reset() branch, when published, will end with a commit removing
> the converted (and therefore empty) arch_reset() functions in mach/system.h,
> and its call site.  Those platforms which haven't been converted will
> still have an arch_reset() function but this will no longer be called.
> 
> I currently have a couple of commits which move things like OMAP1
> (dangling arch_reset), Exynos4 and S5PV210 (converted but missing a
> function prototype, and therefore fail to build) in the right direction
> _but_ will break because of the issues raised above, particularly (4).
> Whether I care to fix it depends on the reaction to this mail and whether
> people change their behaviour to how they lay code out.
> 
> One point to note (for those who question whether it's a good idea to
> touch the old code): the problem platform code is not the old stuff.
> The old stuff, being older, is much less complex and therefore easier
> to convert.  What's proving to be more of a headache is the more modern
> and current stuff, particularly where people have decided to follow
> non-kernel convention about things like placement of include files.
> 
> For reference, he's the list - after five days work - of those platforms
> which are proving hard to convert:
> 
> arch/arm/mach-bcmring/include/mach/system.h
> arch/arm/mach-davinci/include/mach/system.h
> arch/arm/mach-gemini/include/mach/system.h
> arch/arm/mach-ks8695/include/mach/system.h
> arch/arm/mach-netx/include/mach/system.h
> arch/arm/mach-nomadik/include/mach/system.h
> arch/arm/mach-omap1/include/mach/system.h
> arch/arm/mach-omap2/include/mach/system.h
> arch/arm/mach-s3c2410/include/mach/system-reset.h
> arch/arm/mach-s3c64xx/include/mach/system.h
> arch/arm/mach-shmobile/include/mach/system.h
> arch/arm/mach-vt8500/include/mach/system.h
> arch/arm/plat-mxc/include/mach/system.h
> arch/arm/plat-samsung/include/plat/system-reset.h
> arch/arm/plat-tcc/include/mach/system.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
