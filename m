From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/3] Implement powerdomain off on state counters
Date: Tue, 05 Aug 2008 17:28:23 +0300
Message-ID: <1217946503.16579.205.camel@localhost>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
	 <20080805142017.GR7193@atomide.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55226 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYHEOhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:37:33 -0400
In-Reply-To: <20080805142017.GR7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

Hi Tony,
On Tue, 2008-08-05 at 17:20 +0300, ext Tony Lindgren wrote:
> * Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080724 16:00]:
> > This patchset implement counters to count the number of off to on state transitions in a powerdomain. These counters will be made available to
> > drivers in a later patchset to allow them to make a better informed decision wether to restore the hardware registers or not.
> > 
> > Peter 'p2' De Schrijver (3):
> >   Power off on state counter debugging
> >   Power off on state counter infrastructure
> >   Add hooks for counting off on power transitions
> 
> We should merge these into Paul's powerdomain patches against mainline
> tree and post them again for more comments to LKML, linux-arm-kernel
> and linux-pm.

Dave Brownell commented already that this stuff, albeit apparently
generic enough to be interesting to other archs, would probably be
better off being merged in the omap tree, since in the end other SOCs
tend to be far simpler than OMAP.

Considering that we are not 100% sure about the usefulness of certain sw
features - example: the granularity for the bandwidth requirements might
be too fine - I'd rather avoid bringing in whishlists from other
architectures, unless they are proven to be really needed.

And AFAIK so far nobody has come forward with such claim.

Can't we first get it working in a reliable way on OMAP?

Whatever survives this process has probably better chances to result
interesting to other people.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
