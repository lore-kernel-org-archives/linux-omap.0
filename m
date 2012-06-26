From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
Date: Tue, 26 Jun 2012 04:39:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206260433010.12797@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-9-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com> <4FE7F73D.6090402@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59772 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2FZKjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 06:39:19 -0400
In-Reply-To: <4FE7F73D.6090402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Herbert Xu <herbert@gondor.hengli.com.au>

On Mon, 25 Jun 2012, Rajendra Nayak wrote:

> So if CCF conversion patches get in before these get converted to
> runtime PM, do we break them? or should CCF conversion for OMAP
> wait till all remaining drivers get converted to runtime PM?

I'd suggest getting patches 1, 10, and 11 from your series in shape and 
PM-tested.  Those shouldn't have any driver dependencies, so once those 
are in good condition, they can be merged through the OMAP tree.

Then at the same time, maybe get the rest of the drivers runtime-PM 
converted and acked through their respective maintainers.  Looks like you 
have a couple of driver patches that don't involve runtime-PM conversions;
those can presumably get merged through their respective maintainers?

...

I did notice that some other driver conversions weren't present in this 
series, e.g., omap3isp.  If someone doesn't convert those drivers, then 
those seem likely to break.


- Paul
