From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Dropping omap3430 ES1.0 support in mainline
Date: Fri, 1 Oct 2010 16:07:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010011558290.22941@utopia.booyaka.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53875 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab0JAWHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 18:07:34 -0400
In-Reply-To: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, 2 Oct 2010, Anand Gadiyar wrote:

> The OMAP3430 ES1.0 was pretty much a test chip, with the only known board
> being the 3430ES1.0 SDP. There are only a small number of these boards
> outside TI and within TI, they've likely never been used in over 2 years.
> It's unlikely that these boards still work on mainline, and likely have
> been broken in linux-omap since the very beginning.

We had linux-omap booting on the 3430SDP ES1.0 from at least 2007:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/012160.html

We've used the 3430SDP ES1.0 as part of our regular testbed up until last 
year, when it fried itself, so as far as I know, it's worked the whole 
time.


- Paul
