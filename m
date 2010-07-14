From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH resend] omap: 3630: disable TLL SAR on 3630 ES1
Date: Wed, 14 Jul 2010 18:33:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C0F6@dbde02.ent.ti.com>
References: <1278718469-7940-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.1007121414430.10106@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0GNNDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 09:03:09 -0400
In-Reply-To: <alpine.DEB.2.00.1007121414430.10106@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley wrote:
> 
> On Sat, 10 Jul 2010, Anand Gadiyar wrote:
> 
> > USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
> > enabled could result in incorrect register restores as
> > the OMAP exits off-mode. This could potentially result in
> > unexpected wakeup events.
> > 
> > This is fixed in ES1.1. So disable it for ES1.0s.
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> > This is a fix for buggy hardware, and it would be nice
> > to see this in the next merge window too.
> > 
> > Depends on the patch I just posted which adds the CHIP_GE_OMAP3630ES1_1 macro
> > <https://patchwork.kernel.org/patch/111147/>
> 
> Verified against the OMAP3630 errata PDF from June 16.  Anand, could you 
> please add an erratum ID to the commit message or to a comment in the 
> code?
> 

Will do. I just noticed the errata doc has finally been updated with a
proper ID that I can use here.

I'll resend in a short while.


> Tony, once Anand does that, it's
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> if you want it for .36; otherwise, for .37, I'd be happy to queue it.

I assume you mean .35 and .36 here - isn't .37 another 3+ months away?

- Anand
