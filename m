From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers
	removed
Date: Tue, 28 Oct 2008 12:57:15 +0200
Message-ID: <20081028105715.GE27144@gandalf.research.nokia.com>
References: <20081027204323.GA7539@atomide.com> <20081028012538.GA32518@frodo> <20081028030754.GC7539@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51724 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbYJ1K6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 06:58:04 -0400
Content-Disposition: inline
In-Reply-To: <20081028030754.GC7539@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

On Mon, Oct 27, 2008 at 08:07:56PM -0700, Tony Lindgren wrote:
> > n8x0 are still too "new" to do that, but we should get some more effort
> > in merging those drivers upstream. If anyone wanna help, that would be
> > really appreciated. I'll try to do what I can with my small spare time.
> 
> Well I have those retu watchdog and keyboard patches that need more
> work, but it may take a while before I get a chance to work on those
> again.
> 
> For the cbus support, I think we could possibly expand the drivers/spi
> to do cbus too..

in i2c specs, it's said that i2c supports cbus in the lower speed, maybe
extending i2c core would be another option ??

-- 
balbi
