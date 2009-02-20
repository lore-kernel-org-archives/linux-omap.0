From: Tony Lindgren <tony@atomide.com>
Subject: Re: ohci patches sitting in linux-omap only
Date: Fri, 20 Feb 2009 09:54:55 -0800
Message-ID: <20090220175454.GS7414@atomide.com>
References: <20090219214231.GM20723@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52662 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZBTRy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 12:54:58 -0500
Content-Disposition: inline
In-Reply-To: <20090219214231.GM20723@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [090219 13:43]:
> Hi Tony, all,
> 
> if you don't have any objections, I'll send the following patches to
> linux-usb as soon as possible, they've being sitting in linux-omap only
> for a while already (they're all to ohci-omap.c):
> 
> David Brownell (1):
>       ARM: OMAP: switch to gpio_direction_input
> 
> Jarkko Nikula (1):
>       ARM: OMAP: Switch ohci-omap to gpio_request/free calls
> 
> Russell King (2):
>       [ARM] omap: convert OMAP drivers to use ioremap()
>       [ARM] omap: ensure OMAP drivers pass a struct device to clk_get()
> 
> Tony Lindgren (1):
>       USB: ohci-omap: handle other omap15xx chips

Hmm, yeah I thought some of these were already getting queued up.. If
not, sure please try to get them merged.

Tony
