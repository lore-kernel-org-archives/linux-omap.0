From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mmc: fix compile breakage on board-n800-mmc.c
Date: Mon, 6 Oct 2008 15:22:26 +0300
Message-ID: <20081006122225.GJ2806@atomide.com>
References: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com> <20081006133227.8fd5e001.jarkko.nikula@nokia.com> <20081006114931.GM7437@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58635 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYJFMT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 08:19:29 -0400
Content-Disposition: inline
In-Reply-To: <20081006114931.GM7437@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [081006 14:50]:
> On Mon, Oct 06, 2008 at 01:32:27PM +0300, Jarkko Nikula wrote:
> > On Mon,  6 Oct 2008 12:09:22 +0300
> > "ext Felipe Balbi" <felipe.balbi@nokia.com> wrote:
> > 
> > > Commit 81d2c7d87a9c1eb724788fce7312922effa1b1ae broke
> > > compilation of board-n800-mmc.c, this patch fixes it.
> > > 
> > > Still n810 doesn't boot anymore with current linux-omap.
> > > Will look into that soon.
> > > 
> > > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > > ---
> > >  arch/arm/mach-omap2/board-n800-mmc.c |    6 +++---
> > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > Heh, I did the very same patch already last week :-)
> > 
> > http://marc.info/?l=linux-omap&m=122286380121424&w=2
> > 
> > I'm not sure but I think N810 was booting then. Or I was using N800.
> 
> cool, let's push your patch then ;-)

Sorry already pushed Felipe's version.

Tony
