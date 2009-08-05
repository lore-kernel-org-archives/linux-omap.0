From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: GPIO: Avoid generating extra IRQs
Date: Wed, 5 Aug 2009 18:15:41 +0300
Message-ID: <20090805151540.GU7374@atomide.com>
References: <20090805131703.GG7374@atomide.com> <1FFEF31EBAA4F64B80D33027D4297760047F6AECFD@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54672 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZHEPPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:15:43 -0400
Content-Disposition: inline
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760047F6AECFD@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

* ext-Eero.Nurkkala@nokia.com <ext-Eero.Nurkkala@nokia.com> [090805 17:45]:
> 
> >>               l ^= bank->saved_datain;
> >>               l &= bank->non_wakeup_gpios;
> >> -             if (l) {
> >> +
> >> +             /*
> >> +              * No need to generate IRQs for the rising edge for gpio IRQs
> >> +              * configured with falling edge only; and vice versa.
> >> +              */
> >> +             gen0 = l & bank->saved_fallingdetect;
> >> +             gen0 &= bank->saved_datain;
> >> +
> >> +             gen1 = l & bank->saved_risingdetect;
> >> +             gen1 &= ~(bank->saved_datain);
> >> +
> 
> > Is the gen0 &= correct or should it also clear the bits?
> 
> What do you mean, eg, what bits should be cleared?
> 
> gen0 = (bit has changed) and is falling_edge
> gen0 &= (the bit has changed) is falling edge and former state was "HIGH"
> (transition from HIGH to LOW has occurred)
> 
> for rising edge, needed is LOW to HIGH transition.

OK, my comment was just based on looking at the patch, sounds like
you have verified that it's correct. 

Tony
