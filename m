From: Tony Lindgren <tony@atomide.com>
Subject: Re: Tracking N770 breakage
Date: Tue, 19 May 2009 16:15:00 -0700
Message-ID: <20090519231500.GM19742@atomide.com>
References: <20090516140653.10104565olvxrwjk@lidskialf.net> <20090517031715.92503qopn0joudhc@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49937 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbZESXPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:15:01 -0400
Content-Disposition: inline
In-Reply-To: <20090517031715.92503qopn0joudhc@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-omap@vger.kernel.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
> Argh, my N770 seems to have just died; it has been behaving slightly  
> oddly and now it simply won't turn on (black screen and no sign of life 
> whatsoever).
>
> It is well out of warranty and frankly I don't see myself buying another 
> one, so this effectively ends my hacking on it :(

Bummer :(

After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first stopper, then
it could not mount the MMC root.

I think there was a patch posted for the omap1 MMC by Ladislav few months
ago that probably fixes it.

Regards,

Tony
