From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 00/05] OMAP3: SR: Fixes in Smartreflex driver
Date: Thu, 19 Mar 2009 15:27:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6E934@dbde02.ent.ti.com>
References: <8763i6pzfk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZCSJ5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 05:57:36 -0400
In-Reply-To: <8763i6pzfk.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, March 18, 2009 9:59 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/05] OMAP3: SR: Fixes in Smartreflex driver
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> > Hi,
> >
> > This series fixes a set of defects/issues in Smartreflex 
> driver. SR autocompensation is now
> > functional and is validated with these patches on a ES3.1 
> based SDP with the
> > N values in Efuse.
> > Patches apply and are validated on the latest pm branch (2.6.28).
> >
> 
> Hi Rajendra,
> 
> Thanks for this series of SR fixes.  I send a couple very minor
> comments to a couple of the patches.  Also, this series does not apply
> cleanly to pm-2.6.28, I'm not sure why.  Applying manually with
> 'patch' allows them to apply with "fuzz" suggesting that they were not
> generated against the current tree.

I usually pull from kernel.org. The latest commit on pm branch that's pulled
from it shows me this.. 

commit 4f422d583e2e233c19eb20754b8cfad6ed9e460a
Author: Nayak, Rajendra <rnayak@ti.com>
Date:   Fri Feb 13 11:30:57 2009 +0530

    OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2

..which does look quite old. But so does gitweb.
Is there some delta between kernel.org and your internal tree?

> 
> Also, while you are in there cleaing up, could you add one more patch
> which converts the printk(KERN_* ...) into pr_debug, pr_err, pr_info,
> etc.

Yes, I can add a patch to clean that up.

> 
> Thanks,
> 
> Kevin
> 
> 
> 