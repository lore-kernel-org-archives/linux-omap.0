From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Fri, 11 Sep 2009 21:03:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD7D0F67@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
	<20090906124639.GA22239@lixom.net> <87bpliadnd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45029 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbZIKPeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 11:34:10 -0400
In-Reply-To: <87bpliadnd.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Olof Johansson <olof@lixom.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, September 10, 2009 11:25 PM
> To: Olof Johansson
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [RFC] Common mechanism to identify Si revision
> 

 <snip>--<snip>

> >
> > There's two major benefits to this:
> >
> > 1) Readability. No need to sit and look up in a manual why there's a
> > check for version X here.
> >  (and/or no need to add a specific comment about it).
> >
> > 2) Keeping changes centralized. If there's a new revision or chip,
> > there's just one header file to update, not 20 different 
> source files.
> >
> > For example, a bunch of the checks in pm34xx.c would be 
> nicer to have as:
> >
> > 	if (OMAP_HAS_USBHOST()) 
> >
> 
> I tend to agree with Olaf here and am in favor of the new 'features'
> patch that Sanjeev has already proposed.
> 
> That doesn't mean that I'm opposed to this change in principle, but
> would rather see most of the omap_rev() and cpu_is_* checks disappear
> in favor of more generic omap_has_feature() checks.
> 
> Kevin
> 
> 

Tony,

I am planning to submit another patch for "speed - enhanced" part for
OMAP3530.

I see enhanced speed as a feature; and would like to build upon the
last submission. BTW, there is no change in ES revision for new part.
Just additional set of control bits in TAP area.

Do you see any issues with the patch:
  [1] http://marc.info/?l=linux-omap&m=125050987112798&w=2

Best regards,
Sanjeev
