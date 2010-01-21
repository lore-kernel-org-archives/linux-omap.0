From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock
 stabilization delay
Date: Thu, 21 Jan 2010 14:28:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0C44@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2C2@dbde02.ent.ti.com>
 <87vdfebzqa.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1001202232320.24456@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53303 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab0AUI7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 03:59:02 -0500
In-Reply-To: <alpine.DEB.2.00.1001202232320.24456@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, January 21, 2010 11:05 AM
> To: Reddy, Teerth
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock
> stabilization delay
> 
> Hi Teerth,
> 
> any update on Kevin's comments?
> 
> This patch shouldn't use a hardcoded value.  Please explain further why
> that formula can't be included...

Time required to switch clocks -
4 REFCLKS + 2 CLKOUTX2
Gives a small number which doesn't seem to work and causes instability during DVFS. I found that the value of 6us is safe and stable for the DVFS.I tried this value on OMAP3430 sdp, zoom2 and zoom3 and it worked fine.
I will let you know more about the formula once I get the updates.

Regards
Teerth

