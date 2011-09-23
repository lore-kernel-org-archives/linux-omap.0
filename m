From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: clock: cleanup CPUfreq leftovers
Date: Fri, 23 Sep 2011 00:34:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109230034180.10719@utopia.booyaka.com>
References: <1316726006-26925-1-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1109221746130.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab1IWGfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 02:35:00 -0400
In-Reply-To: <alpine.DEB.2.00.1109221746130.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 22 Sep 2011, Paul Walmsley wrote:

> On Thu, 22 Sep 2011, Kevin Hilman wrote:
> 
> > Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> > longer need/use the clock framework code for filling up CPUfreq
> > tables.  Remove it.
> > 
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> > Paul, this patch has a dependency on the OMAP CPUFreq driver
> > move/cleanup series just posted.  Assuming that is merged for v3.2,
> > this can go also.
> 
> Great, could you cc lakml also ?

By the way, I guess the subject line should start with "ARM: OMAP2+: 
clock: " .. etc., per Arnd's recent request.


- Paul
