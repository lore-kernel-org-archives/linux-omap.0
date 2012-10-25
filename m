From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer (fwd)
Date: Thu, 25 Oct 2012 20:54:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210252053250.4745@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180125140.30902@utopia.booyaka.com> <20121023080533.GA16482@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38072 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760258Ab2JYUyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 16:54:00 -0400
In-Reply-To: <20121023080533.GA16482@spo001.leaseweb.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org

Hi Wim,

On Tue, 23 Oct 2012, Wim Van Sebroeck wrote:

> > When you have the opportunity, could you take a look at this patch, and 
> > the subsequent patch 6/7, and ack them if you're okay with them?
> 
> Signed them off, Acked-by would probably have been better :-).

Great!  Will add your Acked-by:s. 

> > We'd like to merge thse as part of a larger cleanup series through the 
> > arm-soc tree.  They like cleanup patches to arrive at the beginning of the 
> > -rc series, which means that we need to have the pull request sent pretty 
> > soon.
> 
> Please go ahead. The sooner those ifdefs are gone the better.

Thanks Wim,


- Paul
