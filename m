From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going
 to RET or OFF when DSS is on
Date: Tue, 8 Mar 2011 17:04:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081659350.15132@utopia.booyaka.com>
References: <20110301220833.32613.54669.stgit@twilight.localdomain> <20110301224918.32613.95176.stgit@twilight.localdomain> <87pqq7pz27.fsf@ti.com> <854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab1CIAEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 19:04:52 -0500
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: khilman@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, 4 Mar 2011, Tero.Kristo@nokia.com wrote:

> What is the reason for having the sleepdep for DSS powerdomain anyway? 
> At least I can't see any reason why the sleepdep for DSS should be set. 
> In my opinion it should be perfectly okay for DSS domain to idle 
> independently of MPU/CORE, as this is going to be better for power 
> consumption also.

Those autodeps are only there because one of the old CDP trees had them in 
there.  Talking with some people at TI, as I understand it, they are only 
useful for working around hardware bugs.  As far as I know, as long as a 
target module has its main clock and interface clock enabled, the PRCM 
should not assert its SIdleReq line to the module, and so the module 
should never enter idle.  

But no one seems to have an authoritative idea of which autodeps are still 
needed, and which are not. Perhaps you, or someone else, might like to try 
seeing which ones can be safely removed?  After applying this patch here:

   http://marc.info/?l=linux-omap&m=129962861605157&w=2

it should be possible to simply set a CLKDM_NO_AUTODEPS flag on a struct 
clockdomain, and then no autodep will be added.

regards

- Paul
