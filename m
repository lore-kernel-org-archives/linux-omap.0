From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sun, 21 Oct 2012 08:23:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210210804060.10693@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <20121020141136.GA6433@netboy.at.omicron.at> <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com> <20121021073551.GA4735@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54193 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2JUIXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 04:23:36 -0400
In-Reply-To: <20121021073551.GA4735@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, 21 Oct 2012, Richard Cochran wrote:

> You are using an obsolete u-boot and the "legacy" appended dtb
> method. It was my understanding that that way is just a temporary hack
> in case the boot loader does not support dtb.
>
> Now that u-boot has the proper support, using the dtb method is the
> "offical" boot method, AFAICT. At least, that is what people are
> saying on the arm list. So I think that if you want to test whether a
> particular board is booting correctly, it is more useful to try the
> offical method.

I'm not interested in testing the bootloader, only the kernel.

And in particular, my focus is currently on the OMAP-specific parts of the 
boot and the PM code, not any kernel DT code.

> People keep saying, the beaglebone works fine with v3.7-rc1, but it 
> isn't true.  Now v3.7-rc2 is out, and the gpmc issue still has not been 
> fixed, and no one is doing anything about it either.

There's likely to be quite a bit that doesn't work in the AM335x boards in 
mainline, due to the fact that it's the first OMAP DT-only board.  Many 
device drivers and subsystems are still not fully adapted to DT across 
most ARM boards.

> When I read your report, it gave me a much rosier picture than is 
> actually the case WRT the beaglebone.

Really?  What section of the message provided that to you?


- Paul
