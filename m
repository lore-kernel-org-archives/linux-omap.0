From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod core upgrades for 2.6.38: first set
Date: Mon, 22 Nov 2010 17:15:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011221715000.20215@utopia.booyaka.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain> <alpine.DEB.2.00.1011160945100.32653@utopia.booyaka.com> <87y68lnhsp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52917 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932471Ab0KWAPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 19:15:40 -0500
In-Reply-To: <87y68lnhsp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 22 Nov 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > On Tue, 16 Nov 2010, Paul Walmsley wrote:
> >
> >> This patch series contains upgrades for the OMAP2+ hwmod core
> >> code, intended for 2.6.38.  Most of these patches were developed
> >> in response to use-cases discovered while converting device
> >> drivers to use the hwmod code.
> >> 
> >> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.
> >
> > Just FYI, this branch 'hwmod_a_2.6.38' is available at 
> > git://git.pwsan.com/linux-2.6
> >
> > Warning: it's based on Tony's tree, not the mainline, due to the recent 
> > board file changes.
> 
> Looks like Tony has collected the board file changes into his
> devel-board branch.  Can this rebased there?
> 
> That way, I can included it as part of the PM branch testing without
> having to pull in master.

hwmod_a_2.6.38 is now based on devel-board and wdt_2.6.38 is now rebased 
on the updated hwmod_a_2.6.38.

- Paul
