From: "Gurav , Pramod" <pramod.gurav@ti.com>
Subject: RE: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Wed, 10 Mar 2010 16:07:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB589@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
 <4B94CC12.3000104@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB3DC@dbde02.ent.ti.com>
 <4B974560.5070704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44354 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab0CJKh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 05:37:57 -0500
In-Reply-To: <4B974560.5070704@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Ambresh" <ambresh@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kandasamy, Rajkumar" <rajkumark@ti.com>


> -----Original Message-----
> From: K, Ambresh
> Sent: Wednesday, March 10, 2010 12:38 PM
> To: Gurav , Pramod
> Cc: K, Ambresh; Reddy, Teerth; linux-omap@vger.kernel.org; Sripathy,
> Vishwanath; Paul Walmsley; Kevin Hilman; Kandasamy, Rajkumar
> Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
> during DVFS
Hello Ambresh,

> 
> 
> We can get ride of the steps used to calculate CLKOUTX2, by simply
> calling parent's (dpll3_ck) clk->recalc function pointer.
> 
> recalc function will return CLKOUT, so CLKOUTX2 = CLKOUT * 2.
> 
> pseudo code
> ------------
> struct clk *parent = clk->parent;
> clkout = parent->recalc();
> clkoutx2 = clkout * 2;
> 

I will test this and update the patch if works fine.

> To derive REFCLK. the only unknown parameter will be N, which can be
> read from .clksel_reg.
> 
> Why can't we use do_div() api to calculate REFCLK, instead of manual
> calculation?
> 

This should hold good for 3430 formula. I am also modifying the code to get 3630 formula included for DVFS latency calculation. But, I am not sure whether using do_div() takes care of truncation (fraction part) as the 3630 formula gives very small value (Need to converted to nano seconds).

