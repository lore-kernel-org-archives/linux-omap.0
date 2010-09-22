From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] OMAP4: PM: Update PRCM register bitshits and masks
 for ES2
Date: Wed, 22 Sep 2010 10:10:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009221010020.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009220014340.21002@utopia.booyaka.com> <0680EC522D0CC943BC586913CF3768C003C21EE40F@dbde02.ent.ti.com>
 <4C9A29E8.4020509@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39385 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0IVQK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 12:10:26 -0400
In-Reply-To: <4C9A29E8.4020509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, 22 Sep 2010, Cousson, Benoit wrote:

> On 9/22/2010 8:43 AM, Nayak, Rajendra wrote:
> > 
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Wednesday, September 22, 2010 11:47 AM
> > > 
> > > We should really get rid of all these 'BITFIELD' defines, and just replace
> > > them with simple bitshifts.  Care to spin a patch to do that during the
> > > 2.6.38 timeframe?
> > 
> > Sure, there's already a patch for this which I guess Benoit should be
> > posting pretty soon.
> 
> Yes, I already updated the scripts a couple of weeks ago to fix that on top of
> Rajendra's series.
> Since it was not critical, I kind of forgot it :-)
> 
> I can sent the fix to you right now if you want?

Sure, if you have it ready to go, I'll take it.


- Paul
