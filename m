From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot
 failure)
Date: Fri, 14 Jan 2011 15:07:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101141445010.28621@utopia.booyaka.com>
References: <20110106203238.GH1198@n2100.arm.linux.org.uk> <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk> <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com> <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
 <20110113091546.GA24429@n2100.arm.linux.org.uk> <20110113155152.GG4957@atomide.com> <20110113164957.GA28040@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com> <20110114212027.GD22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39981 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1ANWHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 17:07:06 -0500
In-Reply-To: <20110114212027.GD22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, 14 Jan 2011, Russell King - ARM Linux wrote:

> On Fri, Jan 14, 2011 at 12:18:50PM -0700, Paul Walmsley wrote:
> > On Thu, 13 Jan 2011, Russell King - ARM Linux wrote:
> > > On Thu, Jan 13, 2011 at 07:51:53AM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> > > > > Given the very sorry state of OMAP in mainline at present, I'm surprised
> > > > > that this kind of stuff is still going on...
> > > > 
> > > > At least I boot test the patches I send..
> > > 
> > > Which is why OMAP3 and OMAP4 can't be built in mainline because they
> > > spit out lots of compile errors in the OMAP code...  As they won't
> > > even compile they couldn't have been boot tested.
> > 
> > Current mainline != the patches that Tony sent to Linus[1].
> > 
> > The patches that Tony sent to Linus, which Linus merged, build fine
> > with omap2plus_defconfig[2].
> 
> Right, but is that sufficient testing?
> 
> Can I read into your statement that the only testing which was done was
> a build of the omap2plus defconfig?

No.  The patches that Tony merged from me were built with omap1_defconfig 
and boot-tested on OMAP5912 OSK; they were built with an N8x0-specific 
configuration and boot-tested on N800; and they were built with 
omap2plus_defconfig and boot-tested on 2430SDP, OMAP3530 Beagle, DM37xx 
Beagle XM, and OMAP4430 ES2 Panda.  A brief summary of that testing was 
part of the pull request that was sent to Tony[1].

The problem in this case was that I did not compile-test them with an 
OMAP4-only configuration - hence the clockdomain and PRM breakage.

> Weren't builds specific to OMAP2, OMAP3, and OMAP4 tried?
> 
> As there is stuff like:
> 
> struct clockdomain {
>         const char *name;
>         union {
>                 const char *name;
>                 struct powerdomain *ptr;
>         } pwrdm;
> #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>         const u16 clktrctrl_mask;
> #endif
> 
> would you consider it's a good idea to at least run a build test with
> an OMAP4-only configuration?

Yes.  Given the clockdomain and PRM breakage from this merge window, I 
plan to compile-test future branches that I send to Tony with quite a few 
non-multi-OMAP configs.  I consider it my responsibility to catch breakage 
from my branches before it makes it to Tony.

> If it helps, here's what I do - not only do I run a few of the standard
> defconfigs in the tree, but I also run a number of platform specific
> builds, both covering platforms I do and do not have.  I'll pick a random
> selection of existing build trees to rebuild and see what the results are.
> This shows the spread of trees which I've built over the last year - and
> note that many of these I don't even have:
> 
> drwxrwxr-x. 20 rmk rmk   4096 Jan 14 20:30 omap4
> drwxrwxr-x. 21 rmk rmk   4096 Jan 14 11:45 versatile
> drwxrwxr-x. 21 rmk rmk   4096 Jan 14 11:14 iop13xx
> drwxrwxr-x. 20 rmk rmk   4096 Jan 13 23:10 vexpress
> drwxrwxr-x. 21 rmk rmk   4096 Jan 11 13:48 integrator
> drwxrwxr-x. 21 rmk rmk   4096 Jan 11 13:44 realview
> drwxrwxr-x. 21 rmk rmk   4096 Jan  8 11:10 assabet
> drwxrwxr-x. 21 rmk rmk   4096 Jan  8 11:07 rpc
> drwxrwxr-x. 21 rmk rmk   4096 Jan  7 17:34 omap3
> drwxrwxr-x. 20 rmk rmk   4096 Jan  6 14:24 nommu
> drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:44 omap2
> drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:27 omap
> drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:24 u300
> drwxrwxr-x. 21 rmk rmk   4096 Jan  5 19:14 pxa
> drwxrwxr-x. 21 rmk rmk   4096 Jan  5 10:30 msm
> drwxrwxr-x. 21 rmk rmk   4096 Jan  4 17:25 orion-kirkwood
> drwxrwxr-x. 21 rmk rmk   4096 Dec 24 11:06 ks8695
> drwxrwxr-x. 21 rmk rmk   4096 Dec 16 16:12 s3c2410
> drwxrwxr-x. 21 rmk rmk   4096 Dec 11 17:17 ixp4xx
> drwxrwxr-x. 20 rmk rmk   4096 Oct  9 22:59 netwinder2
> drwxrwxr-x. 21 rmk rmk   4096 Sep  5 23:54 ebsa285
> drwxrwxr-x. 21 rmk rmk   4096 Aug  4  2010 zylonite
> drwxrwxr-x. 21 rmk rmk   4096 Jul  8  2010 ep93xx
> drwxrwxr-x. 21 rmk rmk   4096 Jun 29  2010 corgi
> drwxrwxr-x. 21 rmk rmk   4096 Apr 25  2010 ebsa110
> drwxrwxr-x. 21 rmk rmk   4096 Mar 25  2010 clps711x
> drwxrwxr-x. 21 rmk rmk   4096 Mar 24  2010 ixp23xx
> drwxrwxr-x. 21 rmk rmk   4096 Mar 20  2010 n2100
> drwxrwxr-x. 21 rmk rmk   4096 Feb 19  2010 iop32x
> drwxrwxr-x. 21 rmk rmk   4096 Jan 20  2010 mx1
> drwxrwxr-x. 21 rmk rmk   4096 Jan 10  2010 w90p910evb
> 
> omap4 = 4430SDP only (I have). 
> omap3 = 3430LDP (I have) + 3430SDP + RX51 (I don't)
> omap2 = H2 (whose config can be traced to 2005 from when I once had one.)
> omap = some random omap1 config
> realview = realview eb/smp only
> assabet = assabet+neponset daugter board
> 
> All those are build trees, built from my git tree with:
> 	make ARCH=arm CROSS_COMPILE=arm-linux- O=../build/$tree <args>
> 
> You can see from the above that I built a kernel for at least orion-kirkwood,
> msm, u300, omap, nommu trees before sending my pull to Linus on the 6th,
> none of which I have (ever) had hardware for.  I also built omap3, omap4,
> and a bunch of the ARM evaluation platforms as well as older platforms
> like RiscPC, but those are hidden by later re-builds for work I've been
> doing since (which is all based upon commit 9e9bc97.)
> 
> I'm not saying that's perfect - it isn't.  It's better than just testing
> the defconfigs - and with regular checking of kautobuild/linux-next, it
> seems to catch quite a bit of really silly stuff.

I agree with you.  I do think it's a good idea, and it's something that I 
plan to do for future branches that I send to Tony.


regards


- Paul


1. Walmsley, Paul. _[GIT PULL v3] OMAP: core/PM architecture: pull request 
   for 2.6.38_.  Posted to linux-omap@vger.kernel.org mailing list on 22 
   December 2010. Available from 
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41289.html
   (among others).
