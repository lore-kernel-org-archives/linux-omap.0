From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH resend] omap: 3630: disable TLL SAR on 3630 ES1
Date: Mon, 12 Jul 2010 14:18:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007121414430.10106@utopia.booyaka.com>
References: <1278718469-7940-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42667 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab0GLUSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 16:18:05 -0400
In-Reply-To: <1278718469-7940-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Sat, 10 Jul 2010, Anand Gadiyar wrote:

> USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
> enabled could result in incorrect register restores as
> the OMAP exits off-mode. This could potentially result in
> unexpected wakeup events.
> 
> This is fixed in ES1.1. So disable it for ES1.0s.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> This is a fix for buggy hardware, and it would be nice
> to see this in the next merge window too.
> 
> Depends on the patch I just posted which adds the
> CHIP_GE_OMAP3630ES1_1 macro
> <https://patchwork.kernel.org/patch/111147/>

Verified against the OMAP3630 errata PDF from June 16.  Anand, could you 
please add an erratum ID to the commit message or to a comment in the 
code?

Tony, once Anand does that, it's

Acked-by: Paul Walmsley <paul@pwsan.com>

if you want it for .36; otherwise, for .37, I'd be happy to queue it.


- Paul
