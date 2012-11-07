From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAPDSS: enable DSS for Panda & SDP with devtree
Date: Wed, 7 Nov 2012 13:34:50 -0800
Message-ID: <20121107213450.GL6801@atomide.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
 <20121107010405.GU6801@atomide.com>
 <509A3EE2.1080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48547 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751586Ab2KGVex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 16:34:53 -0500
Content-Disposition: inline
In-Reply-To: <509A3EE2.1080500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, archit@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s-guiriec@ti.com

* Benoit Cousson <b-cousson@ti.com> [121107 03:00]:
> On 11/07/2012 02:04 AM, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [121105 05:16]:
> >> Hi,
> >>
> >> OMAPDSS device tree support is still some way in the future. Tony has requested
> >> to get DSS working for Panda & SDP boards with DT kernel, so that we'll have
> >> fully working boards with DT.
> >>
> >> This series makes a few hacks to get a working display on OMAP4 Panda and SDP
> >> boards. The idea is to setup the omapdss with the non-DT method, creating the
> >> omapdss devices and passing platform data to them. This setup code is called
> >> from board-generic for Panda and SDP boards.
> >>
> >> There was one problem with this approach: omapdss cannot get regulators using
> >> the omapdss's names fro the regulators. Thus there's a hack patch to get the
> >> regulators using the OMAP4 "native" regulator names, thus circumventing the
> >> problem.
> >>
> >> Tony, if these look good, how do you want to merge these? There are three parts
> >> here, and I think they can be merged independently if so wished:
> >>
> >> * .dts changes for the pinmuxing (2 patches)
> > 
> > Let's let Benoit queue these.
> 
> Done. I'll send you the pull-request tomorrow in case some more DTS
> patches are coming.

OK thanks, I'll apply 3-6 to omap-for-v3.8/board branch.

Regards,

Tony
