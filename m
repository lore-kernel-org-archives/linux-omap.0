From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Wed, 15 Sep 2010 15:45:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151544390.458@utopia.booyaka.com>
References: <> <1270142216-18118-1-git-send-email-pramod.gurav@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322986980@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB03232DAE08@dbde02.ent.ti.com> <alpine.DEB.2.00.1007011235090.13691@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49468 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0IOVpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:45:19 -0400
In-Reply-To: <alpine.DEB.2.00.1007011235090.13691@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gurav , Pramod" <pramod.gurav@ti.com>, teerth@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, b-cousson@ti.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Pramod, Teerth,

On Thu, 1 Jul 2010, Paul Walmsley wrote:

> Pramod, Teerth,
> 
> On Mon, 7 Jun 2010, Gurav , Pramod wrote:
> 
> > Can you please push these patches if you don't you are OK with them?
> 
> As we discussed in Bangalore, these patches need some changes:
> 
> 1. The delay needs to be precisely characterized in terms of what the 
> hardware actually needs.  It should not be necessary to add any extra 
> timing slop, due to unknown sources, in the code.  Unknown sources of 
> delay can cause problems if, for example, a customer changes some board 
> characteristics (such as sys_clk frequency, or DPLL multipliers/dividers) 
> that the delay depends on.
> 
> Also, my understanding is that RX-51 shipped without unknown timing 
> factors in this code.  Please work with the hardware people to precisely 
> characterize the delay, assuming that it does not match what is documented 
> in the TRM.
> 
> 2. Please split out the individual components of the delay calculation to 
> the code that handles those clocks.  For example, HSDIVIDER change delay 
> should be calculated by code that handles the HSDIVIDER.  DPLL relock 
> delay should be calculated by code in the dpll*.c files.  etc.

Any updates on these patches?


- Paul
