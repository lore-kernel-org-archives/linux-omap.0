From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Tue, 25 Dec 2012 12:34:27 -0700
Message-ID: <20121225193427.GE4846@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20121225192937.GD4846@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:55882 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab2LYTe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Dec 2012 14:34:28 -0500
Content-Disposition: inline
In-Reply-To: <20121225192937.GD4846@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

On Tue, Dec 25, 2012 at 12:29:37PM -0700, Mark A. Greer wrote:
> On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
> > Hi Mark,
> > 
> > On Fri, 21 Dec 2012, Mark A. Greer wrote:
> > 
> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > > 
> > > [This series supersedes the hwmod related patches sent in the
> > >  "crypto: omap-sham updates" and "crypto: omap-aes updates"
> > >  series a few weeks ago.]
> > > 
> > > This series adds hwmod support for the OMAP SHAM and AES
> > > modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
> > > adds device tree info for those modules.
> > 
> > Thanks for working on this, this will get us much closer to being able to 
> > convert the hwmod code into an OMAP bus.  I haven't looked closely at 
> > these patches yet, but a few comments/questions:
> > 
> > - Looks like the two DTS patches are the ones with direct dependencies on 
> > the DMA Engine support patches that you mentioned.
> 
> The patch(es) that convert the drivers to use
> dma_request_slave_channel_compat() will cause problems too if the
> patch that adds that call isn't in your branch.  AFAIK, this is the
> latest version, https://patchwork.kernel.org/patch/1459231/ from
> Jon Hunter.

Oops, sorry, please disregard this comment.  I had the wrong patchset
in mind when I wrote it.

Mark
--
