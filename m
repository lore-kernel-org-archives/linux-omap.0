From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
Date: Tue, 3 May 2011 03:39:53 -0700
Message-ID: <20110503103952.GP2092@atomide.com>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
 <20110427140129.GH3755@atomide.com>
 <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
 <4DB9146F.2080002@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43041 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751389Ab1ECKj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 06:39:57 -0400
Content-Disposition: inline
In-Reply-To: <4DB9146F.2080002@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110428 00:13]:
> On 04/27/11 18:58, Grazvydas Ignotas wrote:
> 
> > On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
> >>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
> >>> remove unneeded variables, etc.
> >> Great :)
> > I think this does conflict with Mike's "omap: cleanup board files"
> > series though.
> 
> Yep, as I've stated in the description ;)
> 
> I've started working on this before Mike submitted his series and now
> I want to get some responses before any rebase work is done.

Mike's series is now applied into devel-cleanup, can you please
rebase on top of commit ff08a05b6ca3a22107d621b1417e703af25b1298?

Thanks,

Tony
