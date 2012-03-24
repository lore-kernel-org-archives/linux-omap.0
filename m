From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP and arm-soc's for-next branch
Date: Sat, 24 Mar 2012 12:50:29 +0000
Message-ID: <20120324125029.GA29335@n2100.arm.linux.org.uk>
References: <20120324122256.GA5611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53702 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab2CXMuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Mar 2012 08:50:35 -0400
Content-Disposition: inline
In-Reply-To: <20120324122256.GA5611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Sat, Mar 24, 2012 at 12:22:56PM +0000, Russell King - ARM Linux wrote:
> I've just re-merged the build tree for the nightly builds so it's now
> based on v3.3, and pulled in the latest for-next from arm-soc.
> 
> I notice that the problem I reported earlier (see the "arm-soc + rmk's
> tree boot failure on OMAP4430SDP" thread), which results in OMAP
> being totally unable to boot, is still present.
> 
> As far as I'm concerned, as long as this remains unfixed in arm-soc,
> arm-soc is not to push any branch containing the broken commit
> (3ec2decb) upstream.

Just noticed that the fix for this has already been pushed into mainline.
So, what this means is that anyone trying to bisect across this merge
window with an OMAP platform will hit a range of commits which just won't
boot.  That's really great stuff when the merge window contains the most
probable set of commits for causing issues which would need to be bisected.
