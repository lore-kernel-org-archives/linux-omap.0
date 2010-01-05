From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] OMAP2 clock: dynamically allocate CPUFreq frequency
 table
Date: Tue, 5 Jan 2010 09:22:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001050918570.2083@utopia.booyaka.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain> <20100105024206.16275.58063.stgit@localhost.localdomain> <20100105104210.GA11291@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52976 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab0AEQWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 11:22:39 -0500
In-Reply-To: <20100105104210.GA11291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Jan 2010, Felipe Balbi wrote:

> On Tue, Jan 05, 2010 at 03:42:07AM +0100, ext Paul Walmsley wrote:
> > @@ -470,21 +472,51 @@ void omap2_clk_init_cpufreq_table(struct
> > cpufreq_frequency_table **table)
> > 		if (prcm->dpll_speed == prcm->xtal_speed)
> > 			continue;
> > 
> > +		tbl_sz++;
> > +	}
> > +
> > +	/*
> > +	 * XXX Ensure that we're doing what CPUFreq expects for this error
> > +	 * case and the following one
> > +	 */
> > +	if (tbl_sz == 0) {
> > +		pr_warning("%s: no matching entries in rate_table\n",
> > +			   __func__);
> > +		goto ocict_exit;
> 
> you only use this ocict_exit here, so how about only return instead of a goto
> to a return ?

It's used twice.  But your latter point is a good one.  I will change 
that.


- Paul
