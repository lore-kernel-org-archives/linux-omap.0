From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Pull request for OMAP PM, clock, SDRC 2.6.32 patches
Date: Mon, 17 Aug 2009 18:09:21 +0100
Message-ID: <20090817170921.GT10764@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33577 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbZHQRJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 13:09:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org, hiroshi.doyu@nokia.com

On Sun, Aug 16, 2009 at 07:45:59AM -0600, Paul Walmsley wrote:
> 
> Hello Russell,
> 
> Here's the pull request for the thirteen patches posted earlier, plus 
> Hiroshi's clock debugfs error path fix.

I'm afraid to say that I think you've left it far too late to send this.
I did set a date of the 16th as being the final date to sort out stuff
(which was flexible to a degree) but since these patches were only posted
on Saturday, and they're still being discussed, I don't think it would
make sense for me to pull it today.

And this is likely to be the final day that I merge anything into my
kernel tree for the next two weeks.
> 
> regards,
> 
> - Paul
> 
> The following changes since commit 3b3119fc549c93df60316d28bdd77c2de3986588:
>   Russell King (1):
>         Merge branch 'ixp4xx-fixes' of git://git.kernel.org/.../chris/linux-2.6

That's stupid.  Someone publishing _my_ tree, which I make no guarantees
about the life of the commits, for other people to base their work on...
That's definitely a big FAIL.

Luckily for you though, that commit still exists in my tree, and I've
asked Linus to pull that set; so essentially it became immutable only
last night.

Don't base patches on the contents of my tree without talking to me first
please.
