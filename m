From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock stabilization
 delay
Date: Mon, 8 Feb 2010 15:52:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081549180.22923@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2C2@dbde02.ent.ti.com> <87vdfebzqa.fsf@deeprootsystems.com> <alpine.DEB.2.00.1001202232320.24456@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0C44@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53700 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab0BHWwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 17:52:15 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0C44@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Teerth,

On Thu, 21 Jan 2010, Reddy, Teerth wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Thursday, January 21, 2010 11:05 AM
> > To: Reddy, Teerth
> > Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock
> > stabilization delay
> > 
> > Hi Teerth,
> > 
> > any update on Kevin's comments?
> > 
> > This patch shouldn't use a hardcoded value.  Please explain further why
> > that formula can't be included...
> 
> Time required to switch clocks - 4 REFCLKS + 2 CLKOUTX2 Gives a small 
> number which doesn't seem to work and causes instability during DVFS. I 
> found that the value of 6us is safe and stable for the DVFS.I tried this 
> value on OMAP3430 sdp, zoom2 and zoom3 and it worked fine. I will let 
> you know more about the formula once I get the updates.

Any update on this?  Still waiting.  I don't see any reason why this 
formula couldn't be encoded.  If you can't get your implementation of 
the formula to work, please post the code for us to examine.  6 
microseconds is definitely too long for some cases and too short for 
others, so hardcoding that value is not correct.


- Paul
