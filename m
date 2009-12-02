From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] arm: omap: Add omap3_defconfig
Date: Tue, 1 Dec 2009 20:14:57 -0600
Message-ID: <20091202021457.GA30281@lixom.net>
References: <20091130033434.GA8762@lixom.net> <20091201031932.GA19917@lixom.net> <20091201200925.GA27331@lixom.net> <20091202000819.GF4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:57462 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbZLBCM4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 21:12:56 -0500
Content-Disposition: inline
In-Reply-To: <20091202000819.GF4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Tue, Dec 01, 2009 at 04:08:19PM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Olof Johansson <olof@lixom.net> [091201 12:06]:
> > Having one combined defconfig that is the superset of the individual
> > defconfigs for OMAP3 platforms is useful for easily finding build
> > errors. Not to mention convenient as a base if you want to boot several
> > platforms with a single kernel image.
> 
> Good idea, that's what many people are already doing.

Yeah, we're doing it internally for the boards we use for early software
work. In PPC land we had good success booting a wide variety (even cross
brands) with single kernels, but ARM isn't quite there yet :)

> > Tony, I noticed linux-next doesn't build many of the OMAP defconfigs,
> > and a handful of them won't build to date. I suggest adding this config,
> > and I'll as Stephen Rothwell to add it as one of the configs that are
> > tested (and build errors reported) for every release.
> > 
> > He's reluctant to add too many individual configs since it adds time to
> > each cycle, but one more can surely be acceptable.
> 
> I've built tested the for-next patches, they compile just fine
> except for the omap36xx patches which depend on an update to the
> mach-types.

Yep, I noticed that and figured it's no big deal and will happen when
Russell pushes that update.

> If you find some other omap related compile errors in for-next,
> can you please post the errors to this list?

Of course. The build errors I am referring to in this case are not in
your for-next branch when built individually though, but instad when I
built linux-next which included your branch and other work. I.e. others
broke the omap compiles.

Having a generic config that Stephen Rothwell can build before he pushes
out a new release means others will be notified that they broke OMAP,
which will benefit everyone in the long run. He could of course build
individual ones but every added config adds to the turnaround time for him
so he prefers just one or two. Thus the superset config I'm proposing. :)


-Olof
