From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 16 Dec 2011 05:38:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160536360.12660@utopia.booyaka.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com> <4ED85835.7080108@ti.com> <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com> <alpine.DEB.2.00.1112160422150.12660@utopia.booyaka.com>
 <4EEB37C0.1070307@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44573 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1LPMiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 07:38:14 -0500
In-Reply-To: <4EEB37C0.1070307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 16 Dec 2011, Rajendra Nayak wrote:

> On Friday 16 December 2011 04:53 PM, Paul Walmsley wrote:
> > On Fri, 16 Dec 2011, Paul Walmsley wrote:
> > 
> > > + * XXX Will not work correctly if the RM_*_CONTEXT register
> > > + * offset is 0 -- probably a flag should be used to avoid this
> > > + * situation, rather than testing @oh->prcm.omap4.context_offs.  No
> > > + * return value.
> > 
> > By the way, I'm also worried about this case.  Am wondering if we should
> > add a flag here just to be sure, rather than testing the offset.
> > Thoughts?
> 
> I am not sure if we even have any modules on OMAP4 which *do not*
> support module level context loss status and for which we need to fall
> back on pwrdm level status. So maybe we could even get rid of the check
> for a valid context_offset altogether and expect it to be populated for
> all modules as we do with the clkctrl offset.

Okay, we'll probably want to double-check that in the data and make sure 
it's true.  We should probably wait on this one until someone has a chance 
to check that out, I guess during the 3.4 time frame?


- Paul
