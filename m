From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP and arm-soc's for-next branch
Date: Sat, 24 Mar 2012 18:14:42 +0000
Message-ID: <201203241814.43002.arnd@arndb.de>
References: <20120324122256.GA5611@n2100.arm.linux.org.uk> <20120324125029.GA29335@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab2CXSV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Mar 2012 14:21:29 -0400
In-Reply-To: <20120324125029.GA29335@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Saturday 24 March 2012, Russell King - ARM Linux wrote:
> On Sat, Mar 24, 2012 at 12:22:56PM +0000, Russell King - ARM Linux wrote:
> > I've just re-merged the build tree for the nightly builds so it's now
> > based on v3.3, and pulled in the latest for-next from arm-soc.
> > 
> > I notice that the problem I reported earlier (see the "arm-soc + rmk's
> > tree boot failure on OMAP4430SDP" thread), which results in OMAP
> > being totally unable to boot, is still present.
> > 
> > As far as I'm concerned, as long as this remains unfixed in arm-soc,
> > arm-soc is not to push any branch containing the broken commit
> > (3ec2decb) upstream.
> 
> Just noticed that the fix for this has already been pushed into mainline.
> So, what this means is that anyone trying to bisect across this merge
> window with an OMAP platform will hit a range of commits which just won't
> boot.  That's really great stuff when the merge window contains the most
> probable set of commits for causing issues which would need to be bisected.

I had already pulled the omap_dss2 branch from Tomi into the next/cleanup
branch of arm-soc, in order to resolve a bunch of merge conflicts that we
discussed earlier.

This should limit the number of broken commits in the history to five,
and I could reduce that further to two commits if I rebuild the
next/cleanup branch in a different order, but I think it's not worth
it for that.

I definitely agree that the cleanup branches need a little more care.
The idea is really that large bug harmless changes go in there, also
to help simplify the bisection process. If stuff breaks in the cleanups,
I consider that worse than bugs that come in through new code.

	Arnd
