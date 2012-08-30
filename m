From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/5] hwrng/ARM: OMAP: convert to use runtime PM
Date: Thu, 30 Aug 2012 13:29:25 -0700
Message-ID: <20120830202925.GA32300@gondor.apana.org.au>
References: <20120827232922.15045.56522.stgit@dusk.lan>
 <20120830202708.GZ1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:37317 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221Ab2H3U3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:29:34 -0400
Content-Disposition: inline
In-Reply-To: <20120830202708.GZ1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matt Mackall <mpm@selenic.com>

On Thu, Aug 30, 2012 at 01:27:08PM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120827 16:39]:
> > This series converts the OMAP hardware random number generator driver
> > to use runtime PM.  Hardware integration data is added for OMAP2xxx
> > systems.  I'm pretty sure this device is available on other OMAP chips
> > too, but may require some experimentation with the integration details.
> 
> Good to hear. I believe that at some point this got moved to be
> only accessible in the secure mode on later omaps?
>  
> > There are still a few rough edges with this series.  Something is
> > still not right with the reset behavior on OMAP2430, at least.  But it
> > would be good to get acks from the hwrng folks for the three patches that
> > touch files in that directory.  Will continue with the testing process
> > here.
> 
> Yes Matt & Herbert, care to ack the drivers/char/hw_random related changes?

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

> This series will conflict with the planned ARM common zImage changes
> that we have planned so I'd like to merge them via the ARM soc tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
