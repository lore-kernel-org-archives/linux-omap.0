From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Problem with DSS clocks & accessing registers
Date: Thu, 10 Mar 2011 08:07:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100803020.15132@utopia.booyaka.com>
References: <1299486149.2281.77.camel@deskari>  <4D74E2D5.2000705@ti.com> <1299510200.2281.199.camel@deskari> <4D760372.3020005@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1CJPHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 10:07:17 -0500
In-Reply-To: <4D760372.3020005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

On Tue, 8 Mar 2011, Cousson, Benoit wrote:

> Adding the check in the clock framework for DSS clock nodes only might be the
> cleanest way to do that right now.
> 
> You can map clock nodes to clkops_omap2_dflt_wait clkops instead of the
> clkops_omap2_dflt currently used. But then you will have to add the support
> for OMAP4, since for the moment the function seems to work only for OMAP2 & 3
> (omap2_clk_dflt_find_idlest).
> 
> It is a little bit more complex than the current WA but should not be that
> hard either to do.
> This is a much cleaner WA before having the full hwmod support for the DSS for
> my point of view.
> 
> Paul,
> Any thoughts?

Tomi, unless you have the time to try implementing it via the clock 
framework, I'd suggest that the udelay() is probably the best approach to 
get something into 2.6.39.  I don't like the udelay() either, and I'd 
suggest marking it with a #warning or a big fat comment. 

Unfortunately I've run out of time to do any additional work for this 
merge window.


- Paul
