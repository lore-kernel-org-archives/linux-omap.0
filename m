From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: clock: cleanup CPUfreq leftovers
Date: Thu, 22 Sep 2011 17:46:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109221746130.10719@utopia.booyaka.com>
References: <1316726006-26925-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38703 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1IVXq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 19:46:57 -0400
In-Reply-To: <1316726006-26925-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin

On Thu, 22 Sep 2011, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, this patch has a dependency on the OMAP CPUFreq driver
> move/cleanup series just posted.  Assuming that is merged for v3.2,
> this can go also.

Great, could you cc lakml also ?

thanks,


- Paul
