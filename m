From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] bq27x00 updates
Date: Sat, 18 Oct 2008 00:45:05 +0300
Message-ID: <20081017214504.GJ31842@frodo>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com> <20081017214006.GA5455@oksana.dev.rtsoft.ru>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50614 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbYJQVpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:45:19 -0400
Content-Disposition: inline
In-Reply-To: <20081017214006.GA5455@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sat, Oct 18, 2008 at 01:40:06AM +0400, Anton Vorontsov wrote:
> One thing though: we can't delete the old driver now. I'm about
> to send a pull request to Linus. Though I think we can hurry up and
> merge the new driver for 2.6.28, but delete the old one in 2.6.29.
> 
> This means that you might want to redo the patches this way:
> 
> > Felipe Balbi (4):
> >   power_supply: bq27x00: separate common code
> 
> This one should include its own Kconfig/Makefile entries.
> 
> >   power_supply: bq27200: separate bq27200-specific driver
> 
> Ditto.
> 
> >   power_supply: bq27200: separate bq27000-specific driver
> 
> Ditto.
> 
> >   power_supply: bq27x00: get rid of old code
> 
> We delay this patch for 2.6.29.

Ok, I'll wait for you final review and fix everything at once :-)

Thanks

-- 
balbi
