From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Setting OMAP DSS fck
Date: Thu, 1 Dec 2011 11:23:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112011121220.6289@utopia.booyaka.com>
References: <1322727382.16429.4.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41100 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab1LASX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 13:23:59 -0500
In-Reply-To: <1322727382.16429.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On Thu, 1 Dec 2011, Tomi Valkeinen wrote:

> Why is it that the rate of DSS functional clock (dss_dss_clk on OMAP4)
> cannot be set, but we need to get the parent of the fck, and set the
> rate of that? The same is on OMAP3.
> 
> From driver's perspective I think this only makes things more complex,
> as the driver is not interested in the parent, only about the dss fck.

Yeah, I agree.  We've talked about implementing rate changes that 
percolate up to some higher point in the clock tree, but have never gotten 
around to it due to other, higher priorities.  And now the common clock 
discussion has reduced the desire to do much OMAP-specific implementation 
of this stuff.

Another (related) problem is that the driver probably needs to know the 
ranges of the possible values that can be set.


- Paul
