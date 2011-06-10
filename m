From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 10:51:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106101050140.1921-100000@iolanthe.rowland.org>
References: <20110610143657.GF26441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34505 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754382Ab1FJOvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 10:51:03 -0400
In-Reply-To: <20110610143657.GF26441@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, 10 Jun 2011, Mark Brown wrote:

> > No, it's generally agreed that _all_ devices should return to full 
> > power during system resume -- even if they were runtime suspended 
> > before the system sleep.  This also is explained in the Documentation 
> > files.
> 
> What is the reasoning behind this agreement?  It's not immediately
> obvious why this is useful.

See section 6 of Documentation/power/runtime_pm.txt.

Alan Stern

