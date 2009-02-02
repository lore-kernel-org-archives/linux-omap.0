From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH F 12/12] OMAP2/3 McBSP: add temporary clockdomain fix
 for McBSP virtual clocks
Date: Mon, 2 Feb 2009 01:09:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0902020105370.888@utopia.booyaka.com>
References: <20090128193326.2396.9437.stgit@localhost.localdomain> <20090128193531.2396.91172.stgit@localhost.localdomain> <20090131114226.GE1394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48940 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZBBIJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 03:09:15 -0500
In-Reply-To: <20090131114226.GE1394@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Hi Russell,

On Sat, 31 Jan 2009, Russell King - ARM Linux wrote:

> On Wed, Jan 28, 2009 at 12:35:33PM -0700, Paul Walmsley wrote:
> > The McBSP driver uses virtual clocks to handle enabling and disabling
> > its hardware clocks.  These virtual clocks have no associated
> > clockdomain. After commit 60b8b431e47d8c5b8c02a2e4fa9af388aae20790,
> > this prevents the McBSP clocks from registering correctly.
> > Resolve this for the short term by using virt_opp_clkdm for these clocks.
> > These McBSP virtual clocks should be removed, but such a fix would require
> > significant changes to the McBSP drivers that would require testing on
> > OMAP1, 2, and 3 platforms.
> 
> With either my clkdev patches or the spinlock fixing for mcbsp, this patch
> seems to be redundant.

Indeed.  It was included so the patch set would work if your tree didn't 
have Stanley's McBSP patch applied; I don't think it's made it up to 
mainline.


- Paul
