From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAPDSS: enable DSS for Panda & SDP with devtree
Date: Tue, 6 Nov 2012 17:04:05 -0800
Message-ID: <20121107010405.GU6801@atomide.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:52742 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129Ab2KGBEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:04:08 -0500
Content-Disposition: inline
In-Reply-To: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, s-guiriec@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121105 05:16]:
> Hi,
> 
> OMAPDSS device tree support is still some way in the future. Tony has requested
> to get DSS working for Panda & SDP boards with DT kernel, so that we'll have
> fully working boards with DT.
> 
> This series makes a few hacks to get a working display on OMAP4 Panda and SDP
> boards. The idea is to setup the omapdss with the non-DT method, creating the
> omapdss devices and passing platform data to them. This setup code is called
> from board-generic for Panda and SDP boards.
> 
> There was one problem with this approach: omapdss cannot get regulators using
> the omapdss's names fro the regulators. Thus there's a hack patch to get the
> regulators using the OMAP4 "native" regulator names, thus circumventing the
> problem.
> 
> Tony, if these look good, how do you want to merge these? There are three parts
> here, and I think they can be merged independently if so wished:
> 
> * .dts changes for the pinmuxing (2 patches)

Let's let Benoit queue these.

> * dss-common.c and board-generic.c changes (3 patches)

And I can take these.

> * DSS hack for the regulators (1 patch)

And you can take this.
 
> If one of those parts is missing, DSS won't start with DT kernel, but otherwise
> there shouldn't be any problems. So to avoid conflicts, I suggest that you take
> the first two parts, and I'll merge the DSS hack via omapdss tree.

Cool thanks for doing this. Looks OK to me until we have the DT bindings ready.

Regards,

Tony
