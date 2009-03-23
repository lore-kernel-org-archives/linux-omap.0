From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Problems with 2.6.29-rc8 and SDRAM on LDP
Date: Mon, 23 Mar 2009 01:02:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903230058540.4676@utopia.booyaka.com>
References: <1237740082.23022.9.camel@blackhole> <alpine.DEB.2.00.0903230015140.4676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36728 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbZCWHCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 03:02:53 -0400
In-Reply-To: <alpine.DEB.2.00.0903230015140.4676@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Peter, 

On Mon, 23 Mar 2009, Paul Walmsley wrote:

> On Sun, 22 Mar 2009, Peter Barada wrote:
> 
> > I assume that I have to create a sdram-mt29c262maklajg.h file that
> > contains the sdrc_params to use, but can anyone explain the differences
> > between the 5 entries in the array it would contain?  I know they are
> > tied to OPP levels, but "rate" seems to go down as the OPP level goes
> > up.  This doesn't make sense to me as I'd expect the rate to go up with
> > OPP level.  What am I missing?
> 
> It's just a coincidence that there are five array members.  These are 
> unrelated to OPPs.

I should clarify this a bit.  It is the array _indices_ that are unrelated 
to the OPPs.  The SDRC rates are of course related to the CORE DVFS OPPs, 
in that CORE OPP3 corresponds to the 133MHz rate, and CORE OPP2 
corresponds to the 83MHz rate.


- Paul
