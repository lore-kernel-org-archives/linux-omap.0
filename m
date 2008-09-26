From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [patch 2.6.27-rc6-omap] ASOC: quieter boot for non-Overo boards
Date: Fri, 26 Sep 2008 10:37:32 +0300
Message-ID: <20080926103732.382cfb5b.jarkko.nikula@nokia.com>
References: <200809211414.42194.david-b@pacbell.net>
	<200809250950.06409.david-b@pacbell.net>
	<1222362451.24304.59.camel@tera.sakoman.net>
	<200809251041.48997.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56467 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbYIZHi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:38:28 -0400
In-Reply-To: <200809251041.48997.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: steve@sakoman.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, 25 Sep 2008 10:41:48 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> > Putting the board specific bits in the
> > arch/arm/mach-omap2/board-XYZ.c file has been discussed a number of
> > times on alsa-devel and the folks there insist that for now (i.e.
> > ASoC V1) this is the proper way to do things.
> 
> Hmm, I'm not sure I follow.  They want the SOC devices
> in the wrong place in the driver model tree, potentially
> impacting power management?
> 
> I don't want to fight that fight, but ... that seems unwise.
> 
Yep. Now in ASoC v1, the machine, platform/CPU and codec are tied
together during compile time and I think it has been easier to
review/manage by keeping them under one sound/soc directory.

I suppose that when ASoC v2 is in place and devices can be individually
probed, we might see that machine drivers will start moving out from
there.


Jarkko
