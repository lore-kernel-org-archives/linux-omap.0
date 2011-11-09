From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pet Peaves about Platform code, and arch_reset
Date: Wed, 9 Nov 2011 13:46:52 -0800
Message-ID: <20111109214652.GM31337@atomide.com>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk>
 <20111108004550.GH31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111108004550.GH31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [111107 16:11]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 05:18]:
> > Here's a list of my peaves about current platform code - which are
> > causing me great issue when trying to clean up the arch_reset() stuff:
> > 
> > 1. Lack of trailing ',' on structure initializers
> >    This makes it much harder to add additional initializers at the end
> >    of existing initializers, and increases the risks of conflicts being
> >    caused due to more lines having to be modified.
> > 
> > (This won't work directly because the tabs have been converted to space.
> > The empty-looking [] contain a space plus a tab.)
> > $ grep '[   ][      ]*\.[[:alnum:]_][[:alnum:]_]*[  ]*=[    ]*[[:alnum:]_{][[:alnum:]_|()}]*[^,]$' arch/arm -r|wc -l
> > 768
> > $ grep '[   ][      ]*\.[[:alnum:]_][[:alnum:]_]*[  ]*=[    ]*[[:alnum:]_{][[:alnum:]_|()}]*[^,]$' arch/arm/*omap* -r|wc -l
> > 325
> > 
> >    Note that this is _far_ too big a problem - and trivial - to fix in
> >    a set of silly churn generating patches - it's a problem to be fixed
> >    as a part of _other_ changes to the files.
> > 
> >    But most importantly _stop_ introducing versions of this problem.
> 
> Sounds like we need a spatch for this issue?

I guess spatch would need some patching to deal with this.. I tried
with something like:

@r@
identifier I, s, fld;
position p0,p;
expression E;
@@

struct I s =@p0 {
...
-       .fld@p = E,
+       .fld = E,
...
};

That catches them, but adds an extra comma in the beginning :)

--- a/ams-delta-fiq.c 2011-11-08 18:03:20.110707512 -0800
+++ b/ams-delta-fiq.c 2011-11-08 18:04:36.094948038 -0800
@@ -25,7 +25,7 @@
 #include <mach/ams-delta-fiq.h>
 
 static struct fiq_handler fh = {
-	.name	= "ams-delta-fiq"
+	,.name = "ams-delta-fiq",
 };
 
 /*

And it also messes up the formatting for other structs..

Anyways, I think I got most of these fixed for all ARM subarchitectures
in a pile of 72 patches, the stats are: 

486 files changed, 2296 insertions(+), 2296 deletions(-)

This is something people can then use as a base to start chipping away at
the problem. I'm thinking it may be possible to use this as a base for
search and replacement type work and then hopefully git mergetool will
pick the relevant changes when rebasing a working branch to the mainline.

I can also post the patches here if people want, but sounds like we're
not going to merge them as they are, but instead will slowly fix the
issue in other related patches?

I've pushed the patches into a git branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap formatting:

Web interface at:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=shortlog;h=refs/heads/formatting

Regards,

Tony
