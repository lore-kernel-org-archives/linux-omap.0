From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/5] cbus/retu drivers to mainline
Date: Wed, 29 Aug 2012 16:28:45 -0700
Message-ID: <20120829232844.GF1303@atomide.com>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50113 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab2H2X2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 19:28:48 -0400
Content-Disposition: inline
In-Reply-To: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [120828 14:35]:
> Hi,
> 
> I would like to start converting cbus drivers from linux-omap cbus branch
> for mainline inclusion. Currently e.g. watchdog support is missing at
> least on Nokia N800, so you cannot run the mainline kernel for longer
> than ~60 seconds (and there is no way to disable the watchdog).
> 
> My proposal is to make cbus an i2c bus driver. For other drivers, it
> should be easier to find a proper place in the tree. Here's a first
> quickly made attempt to provide watchdog driver functionality for
> N800. Please comment.

Excellent! This will remove the last remaining patches from linux-omap
that we've carried around. (Not counting the few board-*.c files that
we still carry for testing though)

Regaqrds,

Tony
