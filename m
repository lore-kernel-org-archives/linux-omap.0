From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Removes unused platform device for osk5912
Date: Mon, 8 Dec 2008 12:03:52 -0800
Message-ID: <20081208200351.GA4593@atomide.com>
References: <1228456391-7292-1-git-send-email-arunks@mistralsolutions.com> <20081208191251.GS7388@atomide.com> <200812081135.58610.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62232 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYLHUDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 15:03:54 -0500
Content-Disposition: inline
In-Reply-To: <200812081135.58610.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: arunks@mistralsolutions.com, linux-omap@vger.kernel.org, dirk.behme@de.bosch.com

* David Brownell <david-b@pacbell.net> [081208 11:36]:
> On Monday 08 December 2008, Tony Lindgren wrote:
> > 
> > > This patch removes platform device used my ALSA driver, which
> > > is now replaced with ASoC driver.
> > 
> > Thanks, I'll apply this to linux-omap tree. Will also expand it to
> > delete similar code from other board files for the mainline queue.
> > Some of the includes can disappear with this patch, BTW.
> 
> Maybe drivers/i2c/chips/tlv320aic23.c should be removed too.
> I think that's a remnant of now-removed OSS infrastructure;

Great, done!

Tony
