From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP and arm-soc's for-next branch
Date: Sun, 25 Mar 2012 08:56:09 +0100
Message-ID: <20120325075608.GB22608@n2100.arm.linux.org.uk>
References: <20120324122256.GA5611@n2100.arm.linux.org.uk> <20120324125029.GA29335@n2100.arm.linux.org.uk> <201203241814.43002.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45329 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2CYH4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Mar 2012 03:56:17 -0400
Content-Disposition: inline
In-Reply-To: <201203241814.43002.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Sat, Mar 24, 2012 at 06:14:42PM +0000, Arnd Bergmann wrote:
> On Saturday 24 March 2012, Russell King - ARM Linux wrote:
> > On Sat, Mar 24, 2012 at 12:22:56PM +0000, Russell King - ARM Linux wrote:
> > > I've just re-merged the build tree for the nightly builds so it's now
> > > based on v3.3, and pulled in the latest for-next from arm-soc.
> > > 
> > > I notice that the problem I reported earlier (see the "arm-soc + rmk's
> > > tree boot failure on OMAP4430SDP" thread), which results in OMAP
> > > being totally unable to boot, is still present.
> > > 
> > > As far as I'm concerned, as long as this remains unfixed in arm-soc,
> > > arm-soc is not to push any branch containing the broken commit
> > > (3ec2decb) upstream.
> > 
> > Just noticed that the fix for this has already been pushed into mainline.
> > So, what this means is that anyone trying to bisect across this merge
> > window with an OMAP platform will hit a range of commits which just won't
> > boot.  That's really great stuff when the merge window contains the most
> > probable set of commits for causing issues which would need to be bisected.
> 
> I had already pulled the omap_dss2 branch from Tomi into the next/cleanup
> branch of arm-soc, in order to resolve a bunch of merge conflicts that we
> discussed earlier.

I don't see the commit which Tony talked about - dc7e57fa (OMAPDSS:
register dss drivers in module init) in last night's arm-soc for-next
branch.  So, the only reason the autobuilds are able to boot is because
I'm manually reverting 3ec2decb.
