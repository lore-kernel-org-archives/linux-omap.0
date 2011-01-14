From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
Date: Fri, 14 Jan 2011 21:20:27 +0000
Message-ID: <20110114212027.GD22505@n2100.arm.linux.org.uk>
References: <20110106203238.GH1198@n2100.arm.linux.org.uk> <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk> <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com> <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com> <20110113091546.GA24429@n2100.arm.linux.org.uk> <20110113155152.GG4957@atomide.com> <20110113164957.GA28040@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43929 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab1ANVUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 16:20:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, Jan 14, 2011 at 12:18:50PM -0700, Paul Walmsley wrote:
> On Thu, 13 Jan 2011, Russell King - ARM Linux wrote:
> > On Thu, Jan 13, 2011 at 07:51:53AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> > > > Given the very sorry state of OMAP in mainline at present, I'm surprised
> > > > that this kind of stuff is still going on...
> > > 
> > > At least I boot test the patches I send..
> > 
> > Which is why OMAP3 and OMAP4 can't be built in mainline because they
> > spit out lots of compile errors in the OMAP code...  As they won't
> > even compile they couldn't have been boot tested.
> 
> Current mainline != the patches that Tony sent to Linus[1].
> 
> The patches that Tony sent to Linus, which Linus merged, build fine
> with omap2plus_defconfig[2].

Right, but is that sufficient testing?

Can I read into your statement that the only testing which was done was
a build of the omap2plus defconfig?  Weren't builds specific to OMAP2,
OMAP3, and OMAP4 tried?

As there is stuff like:

struct clockdomain {
        const char *name;
        union {
                const char *name;
                struct powerdomain *ptr;
        } pwrdm;
#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
        const u16 clktrctrl_mask;
#endif

would you consider it's a good idea to at least run a build test with
an OMAP4-only configuration?


If it helps, here's what I do - not only do I run a few of the standard
defconfigs in the tree, but I also run a number of platform specific
builds, both covering platforms I do and do not have.  I'll pick a random
selection of existing build trees to rebuild and see what the results are.
This shows the spread of trees which I've built over the last year - and
note that many of these I don't even have:

drwxrwxr-x. 20 rmk rmk   4096 Jan 14 20:30 omap4
drwxrwxr-x. 21 rmk rmk   4096 Jan 14 11:45 versatile
drwxrwxr-x. 21 rmk rmk   4096 Jan 14 11:14 iop13xx
drwxrwxr-x. 20 rmk rmk   4096 Jan 13 23:10 vexpress
drwxrwxr-x. 21 rmk rmk   4096 Jan 11 13:48 integrator
drwxrwxr-x. 21 rmk rmk   4096 Jan 11 13:44 realview
drwxrwxr-x. 21 rmk rmk   4096 Jan  8 11:10 assabet
drwxrwxr-x. 21 rmk rmk   4096 Jan  8 11:07 rpc
drwxrwxr-x. 21 rmk rmk   4096 Jan  7 17:34 omap3
drwxrwxr-x. 20 rmk rmk   4096 Jan  6 14:24 nommu
drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:44 omap2
drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:27 omap
drwxrwxr-x. 21 rmk rmk   4096 Jan  6 10:24 u300
drwxrwxr-x. 21 rmk rmk   4096 Jan  5 19:14 pxa
drwxrwxr-x. 21 rmk rmk   4096 Jan  5 10:30 msm
drwxrwxr-x. 21 rmk rmk   4096 Jan  4 17:25 orion-kirkwood
drwxrwxr-x. 21 rmk rmk   4096 Dec 24 11:06 ks8695
drwxrwxr-x. 21 rmk rmk   4096 Dec 16 16:12 s3c2410
drwxrwxr-x. 21 rmk rmk   4096 Dec 11 17:17 ixp4xx
drwxrwxr-x. 20 rmk rmk   4096 Oct  9 22:59 netwinder2
drwxrwxr-x. 21 rmk rmk   4096 Sep  5 23:54 ebsa285
drwxrwxr-x. 21 rmk rmk   4096 Aug  4  2010 zylonite
drwxrwxr-x. 21 rmk rmk   4096 Jul  8  2010 ep93xx
drwxrwxr-x. 21 rmk rmk   4096 Jun 29  2010 corgi
drwxrwxr-x. 21 rmk rmk   4096 Apr 25  2010 ebsa110
drwxrwxr-x. 21 rmk rmk   4096 Mar 25  2010 clps711x
drwxrwxr-x. 21 rmk rmk   4096 Mar 24  2010 ixp23xx
drwxrwxr-x. 21 rmk rmk   4096 Mar 20  2010 n2100
drwxrwxr-x. 21 rmk rmk   4096 Feb 19  2010 iop32x
drwxrwxr-x. 21 rmk rmk   4096 Jan 20  2010 mx1
drwxrwxr-x. 21 rmk rmk   4096 Jan 10  2010 w90p910evb

omap4 = 4430SDP only (I have). 
omap3 = 3430LDP (I have) + 3430SDP + RX51 (I don't)
omap2 = H2 (whose config can be traced to 2005 from when I once had one.)
omap = some random omap1 config
realview = realview eb/smp only
assabet = assabet+neponset daugter board

All those are build trees, built from my git tree with:
	make ARCH=arm CROSS_COMPILE=arm-linux- O=../build/$tree <args>

You can see from the above that I built a kernel for at least orion-kirkwood,
msm, u300, omap, nommu trees before sending my pull to Linus on the 6th,
none of which I have (ever) had hardware for.  I also built omap3, omap4,
and a bunch of the ARM evaluation platforms as well as older platforms
like RiscPC, but those are hidden by later re-builds for work I've been
doing since (which is all based upon commit 9e9bc97.)

I'm not saying that's perfect - it isn't.  It's better than just testing
the defconfigs - and with regular checking of kautobuild/linux-next, it
seems to catch quite a bit of really silly stuff.

Please test a (small) selection of configurations to improve build
coverage.  Try to develop a set of configurations which trip up common
issues which won't be found with the omap2plus defconfig.  Don't assume
that just because the omap2plus defconfig builds that it's ready.
